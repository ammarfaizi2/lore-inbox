Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278152AbRJ1LQF>; Sun, 28 Oct 2001 06:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278151AbRJ1LP4>; Sun, 28 Oct 2001 06:15:56 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:32068 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S278152AbRJ1LPr>; Sun, 28 Oct 2001 06:15:47 -0500
Posted-Date: Sun, 28 Oct 2001 11:15:03 GMT
Date: Sun, 28 Oct 2001 11:15:03 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: H Peter Anvin <hpa@zytor.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
In-Reply-To: <9rge9n$sua$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0110281044340.28398-200000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463746820-547378677-1004267703=:28398"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463746820-547378677-1004267703=:28398
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Peter.

> I think the idea of making a standard set of macros available is a
> good idea for two reasons:
> 
> a) It avoids mispellings;
> 
> b) It makes it possible to apply standard definitions to the
>    codified strings.

For reference, here's a summary of the strings in the 2.4.13 kernel
tarball as distributed, counted using `sort | uniq -c` to avoid spam:

     6	MODULE_LICENSE("BSD without advertisement clause")
    22	MODULE_LICENSE("BSD without advertising clause")
     1	MODULE_LICENSE("BSD")
     8	MODULE_LICENSE("Dual BSD/GPL")
    15	MODULE_LICENSE("Dual MPL/GPL")
     2	MODULE_LICENSE("GPL and additional rights")
     1	MODULE_LICENSE("GPL v2")
   912	MODULE_LICENSE("GPL")

Note particularly the line...

     1	MODULE_LICENSE("GPL v2")

...which indicates that drivers/net/pcmcia/xircom_tulip_cb.c is regarded
as tainting the kernel - this string is NOT one of the ones that are
accepted as untainted. Is this reasonable?

The enclosed patch first moves the license definitions to a new header
file linux/license.h and then defines standard macros (with the ML_
prefix) for each of the above strings in standardised form, with dual
licenses listed in alphabetical order. It does NOT change any of the
uses of the MODULE_LICENSE macro, but if I get confirmation that this
patch is accepted into the kernel source tree, I'll go through the
kernel and tweak them all to match it.

Here's the definitions used for the above, in the same order.

	ML_BSD_NO_AD
	ML_BSD_NO_AD
	ML_BSD
	ML_BSD_GPL
	ML_GPL_MPL
	ML_GPL_PLUS
	ML_GPL_V2
	ML_GPL

You will note that the first two have been merged into a single
definition, as they are reasonably clearly the same license.

Best wishes from Riley.

---1463746820-547378677-1004267703=:28398
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mod.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0110281115030.28398@Consulate.UFP.CX>
Content-Description: Standardise module licenses
Content-Disposition: attachment; filename="mod.diff"

LS0tIGxpbnV4LTIuNC4xMy9pbmNsdWRlL2xpbnV4L2xpY2Vuc2UuaH4JVGh1
IEphbiAgMSAwMDowMDowMCAxOTcwDQorKysgbGludXgtMi40LjEzL2luY2x1
ZGUvbGludXgvbGljZW5zZS5oCVN1biBPY3QgMjggMTA6NTg6MjEgMjAwMQ0K
QEAgLTAsMCArMSw0OSBAQA0KKy8qDQorICogTW9kdWxlIGxpY2Vuc2UgZGVj
bGFyYXRpb25zLg0KKyAqDQorICogUmV3cml0dGVuIGJ5IFJpbGV5IFdpbGxp
YW1zIDxyaHdATWVtQWxwaGEuY3g+IE9jdCAyMDAxDQorICovDQorDQorI2lm
bmRlZiBfTElOVVhfTU9EVUxFX0xJQ0VOU0VfSA0KKyNkZWZpbmUgX0xJTlVY
X01PRFVMRV9MSUNFTlNFX0gNCisNCisvKg0KKyAqIFRoZSBmb2xsb3dpbmcg
c3RhbmRhcmQgbGljZW5zZSBpZGVudGl0aWVzIGFyZSBkZWZpbmVkLg0KKyAq
Lw0KKw0KKyNkZWZpbmUgTUxfQlNECQkiQlNEIg0KKyNkZWZpbmUgTUxfQlNE
X05PX0FECSJCU0Qgd2l0aG91dCBhZHZlcnRpc2VtZW50IGNsYXVzZSINCisj
ZGVmaW5lIE1MX0JTRF9HUEwJIkJTRC9HUEwiDQorI2RlZmluZSBNTF9HUEwJ
CSJHUEwiDQorI2RlZmluZSBNTF9HUExfTVBMCSJHUEwvTVBMIg0KKyNkZWZp
bmUgTUxfR1BMX1BMVVMJIkdQTCBhbmQgYWRkaXRpb25hbCByaWdodHMiDQor
I2RlZmluZSBNTF9HUExfVjIJIkdQTCB2ZXJzaW9uIDIgb25seSINCisNCisj
ZGVmaW5lIE1MX1BST1BSSUVUQVJZCSJQcm9wcmlldGFyeSINCisNCisvKg0K
KyAqIE9mIHRoZXNlLCB0aGUgZm9sbG93aW5nIGFyZSBjdXJyZW50bHkgYWNj
ZXB0ZWQgYXMgaW5kaWNhdGluZyBmcmVlIHNvZnR3YXJlDQorICogbW9kdWxl
cy4NCisgKg0KKyAqCU1MX0JTRF9HUEwNCisgKglNTF9HUEwNCisgKglNTF9H
UExfTVBMDQorICoJTUxfR1BMX1BMVVMNCisgKglNTF9HUExfVjIJCShTaG91
bGQgYmUsIGJ1dCBjdXJyZW50bHkgaXNuJ3QpDQorICoNCisgKiBUaGVyZSBh
cmUgZHVhbCBsaWNlbnNlZCBjb21wb25lbnRzLCBidXQgd2hlbiBydW5uaW5n
IHdpdGggTGludXggaXQgaXMgdGhlDQorICogR1BMIHRoYXQgaXMgcmVsZXZh
bnQgc28gdGhpcyBpcyBhIG5vbiBpc3N1ZS4gU2ltaWxhcmx5IExHUEwgbGlu
a2VkIHdpdGgNCisgKiBHUEwgaXMgYSBHUEwgY29tYmluZWQgd29yay4NCisg
Kg0KKyAqIFRoaXMgZXhpc3RzIGZvciBzZXZlcmFsIHJlYXNvbnMNCisgKiAx
LglTbyBtb2RpbmZvIGNhbiBzaG93IGxpY2Vuc2UgaW5mbyBmb3IgdXNlcnMg
d2FudGluZyB0byB2ZXQgdGhlaXIgc2V0dXAgDQorICoJaXMgZnJlZQ0KKyAq
IDIuCVNvIHRoZSBjb21tdW5pdHkgY2FuIGlnbm9yZSBidWcgcmVwb3J0cyBp
bmNsdWRpbmcgcHJvcHJpZXRhcnkgbW9kdWxlcw0KKyAqIDMuCVNvIHZlbmRv
cnMgY2FuIGRvIGxpa2V3aXNlIGJhc2VkIG9uIHRoZWlyIG93biBwb2xpY2ll
cw0KKyAqLw0KKw0KKyNkZWZpbmUgTU9EVUxFX0xJQ0VOU0UobGljZW5zZSkg
CVwNCitzdGF0aWMgY29uc3QgY2hhciBfX21vZHVsZV9saWNlbnNlW10gX19h
dHRyaWJ1dGVfXygoc2VjdGlvbigiLm1vZGluZm8iKSkpID0gICBcDQorImxp
Y2Vuc2U9IiBsaWNlbnNlDQorDQorI2VuZGlmIC8qIF9MSU5VWF9NT0RVTEVf
SCAqLw0KLS0tIGxpbnV4LTIuNC4xMy9pbmNsdWRlL2xpbnV4L21vZHVsZS5o
fglTYXQgT2N0IDI3IDIwOjQyOjMyIDIwMDENCisrKyBsaW51eC0yLjQuMTMv
aW5jbHVkZS9saW51eC9tb2R1bGUuaAlTdW4gT2N0IDI4IDEwOjU5OjM4IDIw
MDENCkBAIC0yNCw2ICsyNCw4IEBADQogDQogI2luY2x1ZGUgPGFzbS9hdG9t
aWMuaD4NCiANCisjaW5jbHVkZSA8bGludXgvbGljZW5zZS5oPg0KKw0KIC8q
IERvbid0IG5lZWQgdG8gYnJpbmcgaW4gYWxsIG9mIHVhY2Nlc3MuaCBqdXN0
IGZvciB0aGlzIGRlY2wuICAqLw0KIHN0cnVjdCBleGNlcHRpb25fdGFibGVf
ZW50cnk7DQogDQpAQCAtMjU5LDM0ICsyNjEsNiBAQA0KICAgX19hdHRyaWJ1
dGVfXyAoKHVudXNlZCkpID0gbmFtZQ0KICNkZWZpbmUgTU9EVUxFX0RFVklD
RV9UQUJMRSh0eXBlLG5hbWUpCQlcDQogICBNT0RVTEVfR0VORVJJQ19UQUJM
RSh0eXBlIyNfZGV2aWNlLG5hbWUpDQotDQotLyoNCi0gKiBUaGUgZm9sbG93
aW5nIGxpY2Vuc2UgaWRlbnRzIGFyZSBjdXJyZW50bHkgYWNjZXB0ZWQgYXMg
aW5kaWNhdGluZyBmcmVlDQotICogc29mdHdhcmUgbW9kdWxlcw0KLSAqDQot
ICoJIkdQTCIJCQkJW0dOVSBQdWJsaWMgTGljZW5zZSB2MiBvciBsYXRlcl0N
Ci0gKgkiR1BMIGFuZCBhZGRpdGlvbmFsIHJpZ2h0cyIJW0dOVSBQdWJsaWMg
TGljZW5zZSB2MiByaWdodHMgYW5kIG1vcmVdDQotICoJIkR1YWwgQlNEL0dQ
TCIJCQlbR05VIFB1YmxpYyBMaWNlbnNlIHYyIG9yIEJTRCBsaWNlbnNlIGNo
b2ljZV0NCi0gKgkiRHVhbCBNUEwvR1BMIgkJCVtHTlUgUHVibGljIExpY2Vu
c2UgdjIgb3IgTW96aWxsYSBsaWNlbnNlIGNob2ljZV0NCi0gKg0KLSAqIFRo
ZSBmb2xsb3dpbmcgb3RoZXIgaWRlbnRzIGFyZSBhdmFpbGFibGUNCi0gKg0K
LSAqCSJQcm9wcmlldGFyeSIJCQlbTm9uIGZyZWUgcHJvZHVjdHNdDQotICoN
Ci0gKiBUaGVyZSBhcmUgZHVhbCBsaWNlbnNlZCBjb21wb25lbnRzLCBidXQg
d2hlbiBydW5uaW5nIHdpdGggTGludXggaXQgaXMgdGhlDQotICogR1BMIHRo
YXQgaXMgcmVsZXZhbnQgc28gdGhpcyBpcyBhIG5vbiBpc3N1ZS4gU2ltaWxh
cmx5IExHUEwgbGlua2VkIHdpdGggR1BMDQotICogaXMgYSBHUEwgY29tYmlu
ZWQgd29yay4NCi0gKg0KLSAqIFRoaXMgZXhpc3RzIGZvciBzZXZlcmFsIHJl
YXNvbnMNCi0gKiAxLglTbyBtb2RpbmZvIGNhbiBzaG93IGxpY2Vuc2UgaW5m
byBmb3IgdXNlcnMgd2FudGluZyB0byB2ZXQgdGhlaXIgc2V0dXAgDQotICoJ
aXMgZnJlZQ0KLSAqIDIuCVNvIHRoZSBjb21tdW5pdHkgY2FuIGlnbm9yZSBi
dWcgcmVwb3J0cyBpbmNsdWRpbmcgcHJvcHJpZXRhcnkgbW9kdWxlcw0KLSAq
IDMuCVNvIHZlbmRvcnMgY2FuIGRvIGxpa2V3aXNlIGJhc2VkIG9uIHRoZWly
IG93biBwb2xpY2llcw0KLSAqLw0KLSANCi0jZGVmaW5lIE1PRFVMRV9MSUNF
TlNFKGxpY2Vuc2UpIAlcDQotc3RhdGljIGNvbnN0IGNoYXIgX19tb2R1bGVf
bGljZW5zZVtdIF9fYXR0cmlidXRlX18oKHNlY3Rpb24oIi5tb2RpbmZvIikp
KSA9ICAgXA0KLSJsaWNlbnNlPSIgbGljZW5zZQ0KIA0KIC8qIERlZmluZSB0
aGUgbW9kdWxlIHZhcmlhYmxlLCBhbmQgdXNhZ2UgbWFjcm9zLiAgKi8NCiBl
eHRlcm4gc3RydWN0IG1vZHVsZSBfX3RoaXNfbW9kdWxlOw0K
---1463746820-547378677-1004267703=:28398--
