Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRG1Arp>; Fri, 27 Jul 2001 20:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265975AbRG1Arg>; Fri, 27 Jul 2001 20:47:36 -0400
Received: from PSI.MIT.EDU ([18.77.0.154]:13440 "EHLO psi.mit.edu")
	by vger.kernel.org with ESMTP id <S265377AbRG1ArS>;
	Fri, 27 Jul 2001 20:47:18 -0400
Date: Fri, 27 Jul 2001 20:48:06 -0400 (EDT)
From: Taylan Akdogan <akdogan@mit.edu>
To: Alan Cox <alan@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Several problems with i810_audio driver
Message-ID: <Pine.LNX.4.33.0107272013230.4500-300000@psi.mit.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1332649479-996281031=:6184"
Content-ID: <Pine.LNX.4.33.0107272044270.6184@psi.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1332649479-996281031=:6184
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0107272044271.6184@psi.mit.edu>

Hello Alan,

I assumed you are the maintainer of i810_audio driver. I had
three problems with it. I think, I solved one of them. I'm
talking about integrated sound card on Intel 850GBAL motherboard.
It's a 82801BA (ICH2) based AD1881A chip.

The first problem is that it's locked to 48kHz when it's included
into the kernel. It works fine when loaded as module. This is
fine, as I can live with it as module.

The second and third problem is somewhat related. When I play
something and stop playing without closing the /dev/dsp device
(say because of heavy system load), if DAC drains during this
pause, it won't continue to play anymore. The test program is
attached, which is going to fail with 2.4.7 (it was also failing
with 2.4.2).

The reason for this, I believe, is that when it receives DCH (DMA
controller is Halted) interrupt, it doesn't change dmabuf->ready
flag. A one line patch for this fix (?) is also attached. It
needs to be checked, because I'm not sure if I should lock
anything before changing it. However, the test program, and my
real application works fine with this patch.

On the other hand, the third problem... When one try to play very
very short, say less then fragsize (I tried just 8 bytes),
sample, after such pause/drain sequence, it doesn't resume to
play. I didn't track down this problem, because it's not as
disturbing as the previous one. However, it should be noted.

Best regards,
Taylan

PS: Please CC your reply to me, because of the know reason...

---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
Taylan Akdogan              Massachusetts Institute of Technology
akdogan@mit.edu                             Department of Physics
---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---


--8323328-1332649479-996281031=:6184
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="i810_audio.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107272043500.6184@psi.mit.edu>
Content-Description: i810_audio.c patch to 2.4.7
Content-Disposition: ATTACHMENT; FILENAME="i810_audio.patch"

ZGlmZiAtdXJOIGxpbnV4LW9yai9kcml2ZXJzL3NvdW5kL2k4MTBfYXVkaW8u
YyBsaW51eC9kcml2ZXJzL3NvdW5kL2k4MTBfYXVkaW8uYw0KLS0tIGxpbnV4
LW9yai9kcml2ZXJzL3NvdW5kL2k4MTBfYXVkaW8uYwlUdWUgSnVsICAzIDEw
OjU5OjUxIDIwMDENCisrKyBsaW51eC9kcml2ZXJzL3NvdW5kL2k4MTBfYXVk
aW8uYwlGcmkgSnVsIDI3IDIwOjEwOjMzIDIwMDENCkBAIC0xMDksNiArMTA5
LDcgQEANCiANCiAvLyNkZWZpbmUgREVCVUcNCiAvLyNkZWZpbmUgREVCVUcy
DQorLy8jZGVmaW5lIERFQlVHX0lOVEVSUlVQVFMNCiANCiAjZGVmaW5lIEFE
Q19SVU5OSU5HCTENCiAjZGVmaW5lIERBQ19SVU5OSU5HCTINCkBAIC05ODMs
NyArOTg0LDcgQEANCiAJCXsNCiAJCQlpODEwX3VwZGF0ZV9wdHIoc3RhdGUp
Ow0KICNpZmRlZiBERUJVR19JTlRFUlJVUFRTDQotCQkJcHJpbnRrKCJDT01Q
JWQgIix4KTsNCisJCQlwcmludGsoIkNPTVAgIik7DQogI2VuZGlmDQogCQl9
DQogCQlpZihzdGF0dXMgJiBETUFfSU5UX0xWSSkNCkBAIC0xMDA1LDYgKzEw
MDYsOSBAQA0KIAkJCQlvdXRiKGluYihwb3J0K09GRl9DUikgfCAxLCBwb3J0
K09GRl9DUik7DQogCQkJfSBlbHNlIHsNCiAJCQkJd2FrZV91cCgmZG1hYnVm
LT53YWl0KTsNCisJCQkJLy8gV2hlbiBEQ0ggKERNQSBDb250cm9sbGVyIGlz
IEhhbHRlZCkNCisJCQkJLy8gSXQncyBub3QgcmVhZHkgYW55bW9yZSEhIQ0K
KwkJCQlkbWFidWYtPnJlYWR5ID0gMDsNCiAjaWZkZWYgREVCVUdfSU5URVJS
VVBUUw0KIAkJCQlwcmludGsoIkRDSCAtIFNUT1AgIik7DQogI2VuZGlmDQo=
--8323328-1332649479-996281031=:6184
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="dsp_test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107272043510.6184@psi.mit.edu>
Content-Description: Test program for bugs
Content-Disposition: ATTACHMENT; FILENAME="dsp_test.c"

I2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4NCiNp
bmNsdWRlIDxzeXMvaW9jdGwuaD4NCiNpbmNsdWRlIDxtYXRoLmg+DQojaW5j
bHVkZSA8c3lzL3NvdW5kY2FyZC5oPg0KDQppbnQgbWFpbihpbnQgYXJnbiwg
Y2hhciAqYXJnW10pIHsNCiAgaW50IGk7DQogIGludDE2X3Qgc2FtcGxlMVs0
ODAwMCoyKjJdOw0KICBpbnQxNl90IHNhbXBsZTJbNDgwMDAqMioyXTsNCiAg
dV9pbnQ4X3QgKnB0cjEsICpwdHIyOw0KICBpbnQgcmV0LCBvdXQsIHJlcTsN
CiAgaW50IGZkOw0KICBpbnQgdG1wOw0KDQogIHB0cjEgPSAodV9pbnQ4X3Qg
KilzYW1wbGUxOw0KICBwdHIyID0gKHVfaW50OF90ICopc2FtcGxlMjsNCg0K
ICBmZCA9IG9wZW4oIi9kZXYvZHNwIiwgT19XUk9OTFkgfCBPX05PTkJMT0NL
KTsNCiAgdG1wPTA7ICAgICBpb2N0bChmZCwgU05EQ1RMX0RTUF9SRVNFVCwg
ICAgICAmdG1wKTsNCiAgdG1wPTI7ICAgICBpb2N0bChmZCwgU05EQ1RMX0RT
UF9TVEVSRU8sICAgICAmdG1wKTsNCiAgdG1wPTE2OyAgICBpb2N0bChmZCwg
U05EQ1RMX0RTUF9TQU1QTEVTSVpFLCAmdG1wKTsNCiAgdG1wPTQ4MDAwOyBp
b2N0bChmZCwgU05EQ1RMX0RTUF9TUEVFRCwgICAgICAmdG1wKTsNCg0KICB1
c2xlZXAoNTAwMDAwKTsNCg0KICBmb3IgKGk9MDtpPDQ4MDAwKjI7aSsrKSB7
DQogICAgc2FtcGxlMVtpKjIgIF09MjAwMDAuMCpzaW4oMi4wKk1fUEkqNDQw
LjAqKChkb3VibGUpaSkvNDgwMDAuMCk7DQogICAgc2FtcGxlMVtpKjIrMV09
MjAwMDAuMCpzaW4oMi4wKk1fUEkqNDQ1LjAqKChkb3VibGUpaSkvNDgwMDAu
MCk7DQogIH0NCg0KICBmb3IgKGk9MDtpPDQ4MDAwKjI7aSsrKSB7DQogICAg
c2FtcGxlMltpKjIgIF09MjAwMDAuMCpzaW4oMi4wKk1fUEkqNjYwLjAqKChk
b3VibGUpaSkvNDgwMDAuMCk7DQogICAgc2FtcGxlMltpKjIrMV09MjAwMDAu
MCpzaW4oMi4wKk1fUEkqNjY1LjAqKChkb3VibGUpaSkvNDgwMDAuMCk7DQog
IH0NCg0KICAvLyBwbGF5IHRoZSBmaXJzdCB0b25lDQogIG91dCA9IDA7IHJl
cSA9IDQ4MDAwKjIqMioyOw0KICB3aGlsZSAob3V0IT1yZXEpIHsNCiAgICBy
ZXQgPSB3cml0ZShmZCwgcHRyMStvdXQsIHJlcS1vdXQpOw0KICAgIGlmIChy
ZXQhPS0xKSBvdXQgKz0gcmV0Ow0KICAgIHVzbGVlcCgxMCk7DQogIH0NCiAN
CiAgLy8gd2FpdCBmb3IgZGFjIGRyYWluIA0KICBkbyBpb2N0bChmZCwgU05E
Q1RMX0RTUF9HRVRPREVMQVksICZ0bXApOyB3aGlsZSAodG1wPjApOw0KDQog
IC8vIFdhaXQgbW9yZSB0byBiZSBjZXJ0YWluIHRoYXQgaXQncyBkcmFpbmVk
DQogIHVzbGVlcCg1MDAwMDApOw0KDQogIC8vIFRyeSB0byBwbGF5IHRoZSBz
ZWNvbmQgdG9uZQ0KICBvdXQgPSAwOyByZXEgPSA0ODAwMCoyKjIqMjsNCiAg
d2hpbGUgKG91dCE9cmVxKSB7DQogICAgcmV0ID0gd3JpdGUoZmQsIHB0cjIr
b3V0LCByZXEtb3V0KTsNCiAgICBpZiAocmV0IT0tMSkgb3V0ICs9IHJldDsN
CiAgICB1c2xlZXAoMTApOw0KICB9DQoNCiAgZG8gaW9jdGwoZmQsIFNORENU
TF9EU1BfR0VUT0RFTEFZLCAmdG1wKTsgd2hpbGUgKHRtcD4wKTsNCg0KICB1
c2xlZXAoNTAwMDAwKTsNCg0KICBjbG9zZShmZCk7DQogIHJldHVybiAwOw0K
fQ0K
--8323328-1332649479-996281031=:6184--
