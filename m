Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293514AbSCOXji>; Fri, 15 Mar 2002 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCOXjU>; Fri, 15 Mar 2002 18:39:20 -0500
Received: from air-2.osdl.org ([65.201.151.6]:48649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293514AbSCOXjO>;
	Fri, 15 Mar 2002 18:39:14 -0500
Date: Fri, 15 Mar 2002 15:38:11 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: John Helms <john.helms@photomask.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Trice Jim <Jim.Trice@photomask.com>, <Martin.Bligh@us.ibm.com>
Subject: Re: bug (trouble?) report on high mem support
In-Reply-To: <20020315.20324600@linux.local>
Message-ID: <Pine.LNX.4.33L2.0203151526250.14689-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346823425-2049754400-1016235491=:14689"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346823425-2049754400-1016235491=:14689
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi-

If someone (Martin or Alan ?) hasn't already told you,
there is a block-highmem patch for 2.4.teens, so if you
can upgrade your kernel to 2.4.19-pre3, for example,
the block-highmem patch is at
  http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2/
file: 00_block-highmem-all-18b-7.gz

Also, as suggested a day or two ago, you could profile the
kernel to see where it is spending time, although I'm not
sure how useful that would be.

A third alternative for you is to apply the attached patch.
I applied it to 2.4.9 (it applies with a little "fuzz"),
but I haven't tested it on 2.4.9, just 2.4.teens.

It counts bounce IOs, both normal IOs and swap IOs.
They can be displayed by printing /proc/stats .
This patch doesn't work with the block-highmem
patch applied -- I'm working on a different patch for that.

This patch also prints (by major:minor) which device(s) are
causing bounce IO.  This printing could become excessive
for you, so don't hesitate to disable it (comment it out, or
let me know if you need help with it).

Regards,
~Randy


On Fri, 15 Mar 2002, John Helms wrote:

| Alan,
|
| Ok, how do I go about determining that?  The machine
| I have is a brand-spankin' new IBM x-series 350 with
| 4 900MHz Xeon processors.  The system bios can
| recognize all of the 16320MB of memory at startup.
| If those patches work, it will save our butts as
| we have a major conversion project that hinges on
| this.
|
| Thanks,
| jwh
|
| >>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<
|
| On 3/15/02, 2:30:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote regarding
| Re: bug (trouble?) report on high mem support:
|
|
| > > Here is a top output.  We have 16Gb of ram.
| > > I have also tried a 2.4.9-31 enterprise=20
| > > kernel rpm from RedHat with the same=20
| > > results.
|
| > Ok that would make sense. Next question is do you have an I/O controller
| > that can use all the 64bit address space on the PCI bus ?
|
| > What is happening is that you are using a lot of CPU copying buffers down
| > into lower memory to transfer to/from disk - as well probably as that
| > causing a lot of competition for low memory. If your I/O controller can
| hit
| > the full 64bit space there are some rather nice test patches that should
| > completely obliterate the problem.
|
| > Alan

--346823425-2049754400-1016235491=:14689
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bounce-stats-24q.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0203151538110.14689@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="bounce-stats-24q.patch"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgva2VybmVsX3N0YXQuaC5vcmcJTW9u
IE5vdiAyNiAxMDoxOToyOSAyMDAxDQorKysgbGludXgvaW5jbHVkZS9saW51
eC9rZXJuZWxfc3RhdC5oCVRodSBEZWMgMjAgMTM6MjY6NTAgMjAwMQ0KQEAg
LTI2LDEyICsyNiwxNCBAQA0KIAl1bnNpZ25lZCBpbnQgZGtfZHJpdmVfd2Js
a1tES19NQVhfTUFKT1JdW0RLX01BWF9ESVNLXTsNCiAJdW5zaWduZWQgaW50
IHBncGdpbiwgcGdwZ291dDsNCiAJdW5zaWduZWQgaW50IHBzd3BpbiwgcHN3
cG91dDsNCisJdW5zaWduZWQgaW50IGJvdW5jZWluLCBib3VuY2VvdXQ7DQor
CXVuc2lnbmVkIGludCBib3VuY2Vzd2FwaW4sIGJvdW5jZXN3YXBvdXQ7DQog
I2lmICFkZWZpbmVkKENPTkZJR19BUkNIX1MzOTApDQogCXVuc2lnbmVkIGlu
dCBpcnFzW05SX0NQVVNdW05SX0lSUVNdOw0KICNlbmRpZg0KLQl1bnNpZ25l
ZCBpbnQgaXBhY2tldHMsIG9wYWNrZXRzOw0KLQl1bnNpZ25lZCBpbnQgaWVy
cm9ycywgb2Vycm9yczsNCi0JdW5zaWduZWQgaW50IGNvbGxpc2lvbnM7DQor
Ly8vCXVuc2lnbmVkIGludCBpcGFja2V0cywgb3BhY2tldHM7DQorLy8vCXVu
c2lnbmVkIGludCBpZXJyb3JzLCBvZXJyb3JzOw0KKy8vLwl1bnNpZ25lZCBp
bnQgY29sbGlzaW9uczsNCiAJdW5zaWduZWQgaW50IGNvbnRleHRfc3d0Y2g7
DQogfTsNCiANCi0tLSBsaW51eC9mcy9wcm9jL3Byb2NfbWlzYy5jLm9yZwlU
dWUgTm92IDIwIDIxOjI5OjA5IDIwMDENCisrKyBsaW51eC9mcy9wcm9jL3By
b2NfbWlzYy5jCVRodSBEZWMgMjAgMTM6MzQ6NDQgMjAwMQ0KQEAgLTMxMCw2
ICszMTAsMTIgQEANCiAJCXh0aW1lLnR2X3NlYyAtIGppZiAvIEhaLA0KIAkJ
dG90YWxfZm9ya3MpOw0KIA0KKwlsZW4gKz0gc3ByaW50ZihwYWdlICsgbGVu
LA0KKwkJImJvdW5jZSBpbyAldSAldVxuIg0KKwkJImJvdW5jZSBzd2FwIGlv
ICV1ICV1XG4iLA0KKwkJa3N0YXQuYm91bmNlaW4sIGtzdGF0LmJvdW5jZW91
dCwNCisJCWtzdGF0LmJvdW5jZXN3YXBpbiwga3N0YXQuYm91bmNlc3dhcG91
dCk7DQorDQogCXJldHVybiBwcm9jX2NhbGNfbWV0cmljcyhwYWdlLCBzdGFy
dCwgb2ZmLCBjb3VudCwgZW9mLCBsZW4pOw0KIH0NCiANCi0tLSBsaW51eC9t
bS9wYWdlX2lvLmMub3JnCU1vbiBOb3YgMTkgMTU6MTk6NDIgMjAwMQ0KKysr
IGxpbnV4L21tL3BhZ2VfaW8uYwlUaHUgRGVjIDIwIDE1OjU5OjQxIDIwMDEN
CkBAIC0xMCw2ICsxMCw3IEBADQogICogIEFsd2F5cyB1c2UgYnJ3X3BhZ2Us
IGxpZmUgYmVjb21lcyBzaW1wbGVyLiAxMiBNYXkgMTk5OCBFcmljIEJpZWRl
cm1hbg0KICAqLw0KIA0KKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4NCiAj
aW5jbHVkZSA8bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgva2VybmVs
X3N0YXQuaD4NCiAjaW5jbHVkZSA8bGludXgvc3dhcC5oPg0KQEAgLTY4LDYg
KzY5LDEzIEBADQogCQlkZXYgPSBzd2FwZi0+aV9kZXY7DQogCX0gZWxzZSB7
DQogCQlyZXR1cm4gMDsNCisJfQ0KKw0KKwlpZiAoUGFnZUhpZ2hNZW0ocGFn
ZSkpIHsNCisJCWlmIChydyA9PSBXUklURSkNCisJCQlrc3RhdC5ib3VuY2Vz
d2Fwb3V0Kys7DQorCQllbHNlDQorCQkJa3N0YXQuYm91bmNlc3dhcGluKys7
DQogCX0NCiANCiAgCS8qIGJsb2NrX3NpemUgPT0gUEFHRV9TSVpFL3pvbmVz
X3VzZWQgKi8NCi0tLSBsaW51eC9kcml2ZXJzL2Jsb2NrL2xsX3J3X2Jsay5j
Lm9yZwlNb24gT2N0IDI5IDEyOjExOjE3IDIwMDENCisrKyBsaW51eC9kcml2
ZXJzL2Jsb2NrL2xsX3J3X2Jsay5jCVRodSBEZWMgMjAgMTc6NDU6MTkgMjAw
MQ0KQEAgLTkzNiw2ICs5MzYsNyBAQA0KIAl9IHdoaWxlIChxLT5tYWtlX3Jl
cXVlc3RfZm4ocSwgcncsIGJoKSk7DQogfQ0KIA0KK3N0YXRpYyBpbnQgYm1z
Z19jb3VudCA9IDA7DQogDQogLyoqDQogICogc3VibWl0X2JoOiBzdWJtaXQg
YSBidWZmZXJfaGVhZCB0byB0aGUgYmxvY2sgZGV2aWNlIGxhdGVyIGZvciBJ
L08NCkBAIC05NTMsNiArOTU0LDcgQEANCiB2b2lkIHN1Ym1pdF9iaChpbnQg
cncsIHN0cnVjdCBidWZmZXJfaGVhZCAqIGJoKQ0KIHsNCiAJaW50IGNvdW50
ID0gYmgtPmJfc2l6ZSA+PiA5Ow0KKwlpbnQgYm91bmNlID0gUGFnZUhpZ2hN
ZW0oYmgtPmJfcGFnZSk7DQogDQogCWlmICghdGVzdF9iaXQoQkhfTG9jaywg
JmJoLT5iX3N0YXRlKSkNCiAJCUJVRygpOw0KQEAgLTk3MSwxMCArOTczLDE5
IEBADQogCXN3aXRjaCAocncpIHsNCiAJCWNhc2UgV1JJVEU6DQogCQkJa3N0
YXQucGdwZ291dCArPSBjb3VudDsNCisJCQlpZiAoYm91bmNlKSBrc3RhdC5i
b3VuY2VvdXQgKz0gY291bnQ7DQogCQkJYnJlYWs7DQogCQlkZWZhdWx0Og0K
IAkJCWtzdGF0LnBncGdpbiArPSBjb3VudDsNCisJCQlpZiAoYm91bmNlKSBr
c3RhdC5ib3VuY2VpbiArPSBjb3VudDsNCiAJCQlicmVhazsNCisJfQ0KKwlp
ZiAoYm91bmNlKSB7DQorCQlibXNnX2NvdW50Kys7DQorCQlpZiAoKGJtc2df
Y291bnQgJSAxMDAwKSA9PSAxKQ0KKwkJCXByaW50ayAoImJvdW5jZSBpbyAo
JWMpIGZvciAlZDolZFxuIiwNCisJCQkJKHJ3ID09IFdSSVRFKSA/ICdXJyA6
ICdSJywNCisJCQkJTUFKT1IoYmgtPmJfcmRldiksIE1JTk9SKGJoLT5iX3Jk
ZXYpKTsNCiAJfQ0KIH0NCiANCg==
--346823425-2049754400-1016235491=:14689--
