Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSCKUOI>; Mon, 11 Mar 2002 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSCKUOA>; Mon, 11 Mar 2002 15:14:00 -0500
Received: from air-2.osdl.org ([65.201.151.6]:47623 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292708AbSCKUNn>;
	Mon, 11 Mar 2002 15:13:43 -0500
Date: Mon, 11 Mar 2002 12:13:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Scott L. Burson" <gyro@zeta-soft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Performance issue on dual Athlon MP
In-Reply-To: <20020311093217.GB31108@suse.de>
Message-ID: <Pine.LNX.4.33L2.0203111204240.3326-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346823425-2098181509-1015877581=:3326"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346823425-2098181509-1015877581=:3326
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 11 Mar 2002, Jens Axboe wrote:

| On Thu, Mar 07 2002, Alan Cox wrote:
| > > BTW, this doesn't seem like a preemption issue, considering that throughput
| > > is very definitely affected as well as latency.
| > >
| > > Anyway, please let me know if there's anything I can do, within my
| > > constraints, to help.  (As you can guess, though, I don't have any kernel
| > > debugging experience.)
| >
| > It sounds like the hit you are taking is from highmem and I/O (having to
| > copy pages lower into memory so the I/O subsystem can use them). Some of
| > that is in the hard to fix for 2.4 category with the x86. There are some
| > experimental patches around but they are experimental.
|
| If you are referring to my block-highmem patch, then it's not considered
| too experiemental anymore. It's been a long time since any problems have
| been reported.

I've certainly tortured it a bit, with no problems.

| Scott, a small profile run would give us the information needed to tell
| whether this is a bounce problem or not. Boot the kernel with profile=2,
| then do a readprofile -r ; run problematic stuff ; readprofile >
| prof_data
|
| and share the prof_data.

Using this (above) profiling method shouldn't be very intrusive.
(I.e., need to reboot, but not patch and build a kernel.)

Here's another thing you could do, Scott.  This patch is against
2.4.19-pre2 but probably will apply to several versions of 2.4.x
that do *not* have the block-highmem patch applied.

This patch adds bounce IO and bounce swap IO statistics
to /proc/stat .
It also prints out a message about which device is using (causing)
bounce IO.  This message could easily become excessive, so if you
try this, feel free to disable that part of the patch.

bounce IO stats for block-highmem will require a different patch,
but Jens has helped me on that a bit, and I'll post it after some
more testing.

Any updated news from you on this issue, Scott?

-- 
~Randy

--346823425-2098181509-1015877581=:3326
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bounce-stats-24q.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0203111213010.3326@dragon.pdx.osdl.net>
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
--346823425-2098181509-1015877581=:3326--
