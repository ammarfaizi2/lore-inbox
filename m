Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267082AbSLDUuY>; Wed, 4 Dec 2002 15:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSLDUuY>; Wed, 4 Dec 2002 15:50:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267082AbSLDUuV>;
	Wed, 4 Dec 2002 15:50:21 -0500
Date: Wed, 4 Dec 2002 12:54:47 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Nat Ersoz <nat.ersoz@myrio.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: pc_keyb.c #define kbd_controller_present()
In-Reply-To: <1039019244.25141.34.camel@ersoz.et.myrio.com>
Message-ID: <Pine.LNX.4.33L2.0212041243350.8842-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346823425-1357170084-1039035287=:8842"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346823425-1357170084-1039035287=:8842
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

Nat Ersoz wrote a couple of weeks back about systems that he has
without PS/2 (or AT) keyboards attached, and he mentioned a possible
solution.  I have done a minimal implementation of that solution
for 2.4.20.  Nat has tested it on a system with an IR keyboard and is
ready to ship it.  :)  I have tested it on a system with a USB
keyboard.  Both of these systems have a PS/2 keyboard controller
on them but no PS/2 keyboard attached.

I know that 2.5 has a different solution for this, but this is
now available for 2.4 for anyone who needs it.
This introduces CONFIG_PSKEYBOARD for i386, which defaults to Yes/ON,
so you'll need to disablel this option to use/test it, and it's
marked Experimental, so you'll need to enable Experimental also.

This eliminates some keyboard timeouts and messages such as:
| keyboard: Timeout - AT keyboard not present?(ed)
| keyboard: Timeout - AT keyboard not present?(f4)
| "pc_keyb: controller jammed 0xFF"
and it makes booting faster on systems that were experiencing
such keyboard timeouts.

Comments?

--
~Randy


On 4 Dec 2002, Nat Ersoz wrote:

| That worked for me.  Thanks for taking the initiative on this! I used it
| to patch both the 2.4.19 and 2.4.20 kernels without errors.  This looks
| good to me.  Ship it!
|
| Nat



--346823425-1357170084-1039035287=:8842
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kbc_option_2420.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0212041254470.8842@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="kbc_option_2420.patch"

LS0tIC4vaW5jbHVkZS9hc20taTM4Ni9rZXlib2FyZC5oJUtCQwlNb24gRGVj
ICAyIDEyOjE1OjA4IDIwMDINCisrKyAuL2luY2x1ZGUvYXNtLWkzODYva2V5
Ym9hcmQuaAlUdWUgRGVjICAzIDE2OjE4OjU2IDIwMDINCkBAIC0xMywxMiAr
MTMsMTcgQEANCiANCiAjaWZkZWYgX19LRVJORUxfXw0KIA0KKyNpbmNsdWRl
IDxsaW51eC9jb25maWcuaD4NCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPg0KICNpbmNsdWRlIDxsaW51
eC9rZC5oPg0KICNpbmNsdWRlIDxsaW51eC9wbS5oPg0KICNpbmNsdWRlIDxh
c20vaW8uaD4NCiANCisjaWZuZGVmIENPTkZJR19QU0tFWUJPQVJEDQorI2Rl
ZmluZSBrYmRfY29udHJvbGxlcl9wcmVzZW50KCkJMA0KKyNlbmRpZg0KKw0K
ICNkZWZpbmUgS0VZQk9BUkRfSVJRCQkJMQ0KICNkZWZpbmUgRElTQUJMRV9L
QkRfRFVSSU5HX0lOVEVSUlVQVFMJMA0KIA0KQEAgLTQ5LDEwICs1NCwxNyBA
QA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJrZXlib2FyZCIsIE5VTEwpDQogDQogLyogSG93IHRvIGFjY2VzcyB0
aGUga2V5Ym9hcmQgbWFjcm9zIG9uIHRoaXMgcGxhdGZvcm0uICAqLw0KKyNp
ZmRlZiBDT05GSUdfUFNLRVlCT0FSRA0KICNkZWZpbmUga2JkX3JlYWRfaW5w
dXQoKSBpbmIoS0JEX0RBVEFfUkVHKQ0KICNkZWZpbmUga2JkX3JlYWRfc3Rh
dHVzKCkgaW5iKEtCRF9TVEFUVVNfUkVHKQ0KICNkZWZpbmUga2JkX3dyaXRl
X291dHB1dCh2YWwpIG91dGIodmFsLCBLQkRfREFUQV9SRUcpDQogI2RlZmlu
ZSBrYmRfd3JpdGVfY29tbWFuZCh2YWwpIG91dGIodmFsLCBLQkRfQ05UTF9S
RUcpDQorI2Vsc2UNCisjZGVmaW5lIGtiZF9yZWFkX2lucHV0KCkJMA0KKyNk
ZWZpbmUga2JkX3JlYWRfc3RhdHVzKCkJMA0KKyNkZWZpbmUga2JkX3dyaXRl
X291dHB1dCh2YWwpDQorI2RlZmluZSBrYmRfd3JpdGVfY29tbWFuZCh2YWwp
DQorI2VuZGlmDQogDQogLyogU29tZSBzdG9uZWFnZSBoYXJkd2FyZSBuZWVk
cyBkZWxheXMgYWZ0ZXIgc29tZSBvcGVyYXRpb25zLiAgKi8NCiAjZGVmaW5l
IGtiZF9wYXVzZSgpIGRvIHsgfSB3aGlsZSgwKQ0KLS0tIC4vZHJpdmVycy9j
aGFyL0NvbmZpZy5pbiVLQkMJVGh1IE5vdiAyOCAxNTo1MzoxMiAyMDAyDQor
KysgLi9kcml2ZXJzL2NoYXIvQ29uZmlnLmluCVR1ZSBEZWMgIDMgMTQ6MzA6
MDEgMjAwMg0KQEAgLTE1NSw2ICsxNTUsOCBAQA0KIA0KIHNvdXJjZSBkcml2
ZXJzL2kyYy9Db25maWcuaW4NCiANCitib29sICdQUy8yIGtleWJvYXJkIHN1
cHBvcnQgKE9mZiA9IEVYUEVSSU1FTlRBTCknIENPTkZJR19QU0tFWUJPQVJE
ICRDT05GSUdfRVhQRVJJTUVOVEFMDQorDQogbWFpbm1lbnVfb3B0aW9uIG5l
eHRfY29tbWVudA0KIGNvbW1lbnQgJ01pY2UnDQogdHJpc3RhdGUgJ0J1cyBN
b3VzZSBTdXBwb3J0JyBDT05GSUdfQlVTTU9VU0UNCi0tLSAuL2FyY2gvaTM4
Ni9kZWZjb25maWclS0JDCVRodSBOb3YgMjggMTU6NTM6MDkgMjAwMg0KKysr
IC4vYXJjaC9pMzg2L2RlZmNvbmZpZwlUdWUgRGVjICAzIDE0OjM3OjUwIDIw
MDINCkBAIC01NTksNiArNTU5LDggQEANCiAjDQogIyBDT05GSUdfSTJDIGlz
IG5vdCBzZXQNCiANCitDT05GSUdfUFNLRVlCT0FSRD15DQorDQogIw0KICMg
TWljZQ0KICMNCi0tLSAuL0RvY3VtZW50YXRpb24vQ29uZmlndXJlLmhlbHAl
S0JDCVRodSBOb3YgMjggMTU6NTM6MDggMjAwMg0KKysrIC4vRG9jdW1lbnRh
dGlvbi9Db25maWd1cmUuaGVscAlUdWUgRGVjICAzIDE0OjM2OjM3IDIwMDIN
CkBAIC0xNzY3OSw2ICsxNzY3OSwxMiBAQA0KICAgaXQgYXMgYSBtb2R1bGUs
IHNheSBNIGhlcmUgYW5kIHJlYWQgPGZpbGU6RG9jdW1lbnRhdGlvbi9tb2R1
bGVzLnR4dD4uDQogICBUaGUgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGkyYy1w
cm9jLm8uDQogDQorUFMvMiBrZXlib2FyZCBzdXBwb3J0DQorQ09ORklHX1BT
S0VZQk9BUkQNCisgIFBTLzIga2V5Ym9hcmQgc3VwcG9ydCBpcyBvcHRpb25h
bCBhbmQgY2FuIGJlIG9taXR0ZWQgb24gc29tZSBzeXN0ZW1zLA0KKyAgZm9y
IGV4YW1wbGUsIHNvbWUgSUEzMiBzeXN0ZW1zIHdoaWNoIHVzZSBJckRBIGtl
eWJvYXJkcy4NCisgIElmIHVuc3VyZSwgc2F5IFkuDQorDQogQnVzIE1vdXNl
IFN1cHBvcnQNCiBDT05GSUdfQlVTTU9VU0UNCiAgIFNheSBZIGhlcmUgaWYg
eW91ciBtYWNoaW5lIGhhcyBhIGJ1cyBtb3VzZSBhcyBvcHBvc2VkIHRvIGEg
c2VyaWFsDQo=
--346823425-1357170084-1039035287=:8842--
