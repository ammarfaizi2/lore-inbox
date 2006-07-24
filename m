Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWGXCQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWGXCQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 22:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWGXCQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 22:16:04 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:38842 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751389AbWGXCQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 22:16:01 -0400
Date: Sun, 23 Jul 2006 19:16:00 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell3.speakeasy.net
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
 corruption
In-Reply-To: <1153647324.22089.32.camel@praia>
Message-ID: <Pine.LNX.4.58.0607231828430.16282@shell3.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com> 
 <20060713050541.GA31257@kroah.com>  <20060712222407.d737129c.rdunlap@xenotime.net>
  <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
  <1153013464.4755.35.camel@praia>  <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
  <1153310092.27276.9.camel@praia>  <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
  <1153484805.16225.12.camel@praia>  <Pine.LNX.4.58.0607211226430.26854@shell2.speakeasy.net>
  <1153513837.32625.71.camel@praia>  <Pine.LNX.4.58.0607211536190.26854@shell2.speakeasy.net>
 <1153647324.22089.32.camel@praia>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="289735796-2119888355-1153707360=:13138"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289735796-2119888355-1153707360=:13138
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 23 Jul 2006, Mauro Carvalho Chehab wrote:
> Ok, I had some time to fix the broken dependencies. Please look at the
> two commits I did today.

Two things I noticed.  bttv didn't use to _require_ V4L1.  I use bttv and h=
ave
V4L1 turned off.  I guess this is just because bttv ignored the V4L1 settin=
g?

Second, the fix for class_device_create_file() doesn't roll-back properly
on failure.  I already posted a patch which does this correctly.  Attached
is the patch against the current Hg, go ahead and import it.

Also attached is patch to bttv-driver.c that has it use
class_device_create_file(), with an error message and handling of failure.


> One patch removes HAVE_V4L1 check at drivers. It also include some checks=
 for
> V4L1_COMPAT on some core files that should implement both calls to provid=
e
> support for V4L1 drivers.
>
> The other fixes the broken dependencies for drivers that still need V4L1
> to work properly.
>
> Cheers,
> Mauro.
>
> Em Sex, 2006-07-21 =E0s 15:55 -0700, Trent Piepho escreveu:
> > On Fri, 21 Jul 2006, Mauro Carvalho Chehab wrote:
> > > config VIDEO_BT848
> > >         tristate "BT848 Video For Linux"
> > >         depends on VIDEO_DEV && PCI && I2C && VIDEO_V4L2
> > >
> > > Argh! it should be V4L1 instead!
> >
> > You can compile and use bt848 without V4L1 turned on.  It still has som=
e
> > V4L1 functions defined.
> >
> > > > All these files include v4l2-dev.h and have HAVE_V4L1 defined when =
V4L1 is
> > > > not turned on in Kconfig.  There files are all buildable when V4L1 =
is off;
> > > > they don't depend on it in Kconfig.
> > > Some of the above drivers are V4L2, like tda9887, tuner-core,
> > > tuner-simple, msp3400, cs53l32a, tveeprom, wm87xx. Maybe they are jus=
t
> > > including the wrong headers. We should try to change to videodev2.h a=
nd
> > > see what happens with all those drivers. The ones that break should m=
e
> > > marked with the proper requirement on Kconfig.
> > >
> > > Some of they need some #ifdef inside. For example, compat_ioctl32 sho=
uld
> > > handle both APIs, since it is a generic code to fix 32 bit calls to 6=
4
> > > bit kernel.
> >
> > I think this is pretty much what I've been saying.  Drivers should:
> > A. Not include videodev.h, but use videodev2.h
> > B. Include videodev.h, but be marked V4L1 in Kconfig
> > C. #ifdef around videodev.h (and code that needs videodev.h), so it
> >    is not included or needed when V4L1 is turned off.
> Cheers,
> Mauro.
>
>
--289735796-2119888355-1153707360=:13138
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cdcf_videodev.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0607231916001.13138@shell3.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="cdcf_videodev.patch"

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBUcmVudCBQaWVwaG8gPHh5
enp5QHNwZWFrZWFzeS5vcmc+DQojIE5vZGUgSUQgYjkwMDc5NmZkZmI0YmM4
NzY0MmM0NzA1MTVmODhlZDdhZTkyY2VkMw0KIyBQYXJlbnQgIGUzMzMzMTg1
NjIxMmU3MDcxNTBkYzg1ZmRhNDg2MjQwZWI3ZmVhZTANCkhhbmRsZSBjbGFz
c19kZXZpY2VfY3JlYXRlX2ZpbGUgZXJyb3JzDQoNCkZyb206IFRyZW50IFBp
ZXBobyA8eHl6enlAc3BlYWtlYXN5Lm9yZz4NCg0KQWRkIHByb3BlciBlcnJv
ciBjaGVja2luZyBhbmQgcm9sbC1iYWNrIGZvciBmYWlsdXJlIG9mDQpjbGFz
c19kZXZpY2VfY3JlYXRlX2ZpbGUoKSBpbiB2aWRlb2Rldi5jLiAgUHJpbnQg
ZXJyb3IgbWVzc2FnZXMgYW5kDQp1bnJvbGwgcGFydGlhbGx5IGNyZWF0ZWQg
c3lzZnMgZW50cmllcy4NCg0KQWxzbywgZmFpbHVyZSBvZiBjbGFzc19kZXZp
Y2VfcmVnaXN0ZXIoKSBpbiB2aWRlb19yZWdpc3Rlcl9kZXZpY2UoKSBpcw0K
aGFuZGxlZCBjb3JyZWN0bHkuICBJdCB3YXMgZmFpbGluZyB0byBkZS1hbGxv
Y2F0ZSB0aGUgbWlub3IgbnVtYmVyLiAgVGhpcw0KbXVzdCBiZSBkb25lIGlu
IHZpZGVvX3JlZ2lzdGVyX2RldmljZSgpLCBzaW5jZSB0aGUgY2FsbGVyIGhh
cyBubyB3YXkgb2YNCmtub3dpbmcgaWYgZmFpbHVyZSBvY2N1cnJlZCBiZWZv
cmUgb3IgYWZ0ZXIgdGhlIGNsYXNzIGRldmljZSB3YXMNCnJlZ2lzdGVyZWQu
DQoNCkFsc28gYWRkZWQgYW4gZXJyb3IgbWVzc2FnZSBpZiB2aWRlb19yZWdp
c3Rlcl9kZXZpY2UoKSBpcyBjYWxsZWQgd2l0aA0KYW4gdW5rbm93biB0eXBl
LCB3aGljaCBzaG91bGQgbmV2ZXIgaGFwcGVuLg0KDQpTaWduZWQtb2ZmLWJ5
OiBUcmVudCBQaWVwaG8gPHh5enp5QHNwZWFrZWFzeS5vcmc+DQoNCmRpZmYg
LXIgZTMzMzMxODU2MjEyIC1yIGI5MDA3OTZmZGZiNCBsaW51eC9kcml2ZXJz
L21lZGlhL3ZpZGVvL3ZpZGVvZGV2LmMNCi0tLSBhL2xpbnV4L2RyaXZlcnMv
bWVkaWEvdmlkZW8vdmlkZW9kZXYuYwlTdW4gSnVsIDIzIDE4OjM2OjAxIDIw
MDYgLTA3MDANCisrKyBiL2xpbnV4L2RyaXZlcnMvbWVkaWEvdmlkZW8vdmlk
ZW9kZXYuYwlTdW4gSnVsIDIzIDE5OjA4OjIxIDIwMDYgLTA3MDANCkBAIC0x
NTU3LDYgKzE1NTcsOCBAQCBpbnQgdmlkZW9fcmVnaXN0ZXJfZGV2aWNlKHN0
cnVjdCB2aWRlb19kDQogCQkJbmFtZV9iYXNlID0gInJhZGlvIjsNCiAJCQli
cmVhazsNCiAJCWRlZmF1bHQ6DQorCQkJcHJpbnRrKEtFUk5fRVJSICIlcyBj
YWxsZWQgd2l0aCB1bmtub3duIHR5cGU6ICVkXG4iLA0KKwkJCSAgICAgICBf
X0ZVTkNUSU9OX18sIHR5cGUpOw0KIAkJCXJldHVybiAtMTsNCiAJfQ0KIA0K
QEAgLTE1OTcsMTggKzE1OTksMjAgQEAgaW50IHZpZGVvX3JlZ2lzdGVyX2Rl
dmljZShzdHJ1Y3QgdmlkZW9fZA0KIAlpZiAocmV0KSB7DQogCQlwcmludGso
S0VSTl9FUlIgIiVzOiBjbGFzc19kZXZpY2VfcmVnaXN0ZXIgZmFpbGVkXG4i
LA0KIAkJICAgICAgIF9fRlVOQ1RJT05fXyk7DQotCQlyZXR1cm4gcmV0Ow0K
LQl9DQotICAgICAgICByZXQgPSBjbGFzc19kZXZpY2VfY3JlYXRlX2ZpbGUo
JnZmZC0+Y2xhc3NfZGV2LCAmY2xhc3NfZGV2aWNlX2F0dHJfbmFtZSk7DQot
ICAgICAgICBpZiAocmV0IDwgMCkgew0KLSAgICAgICAgICAgICAgICBwcmlu
dGsoS0VSTl9XQVJOSU5HICIlcyBlcnJvcjogJWRcbiIsIF9fRlVOQ1RJT05f
XywgcmV0KTsNCi0JCXJldHVybiByZXQ7DQorCQlnb3RvIGZhaWxfbWlub3I7
DQorCX0NCisJcmV0ID0gY2xhc3NfZGV2aWNlX2NyZWF0ZV9maWxlKCZ2ZmQt
PmNsYXNzX2RldiwgJmNsYXNzX2RldmljZV9hdHRyX25hbWUpOw0KKwlpZiAo
cmV0KSB7DQorCQlwcmludGsoS0VSTl9FUlIgIiVzOiBjbGFzc19kZXZpY2Vf
Y3JlYXRlX2ZpbGUgJ25hbWUnIGZhaWxlZFxuIiwNCisJCSAgICAgICBfX0ZV
TkNUSU9OX18pOw0KKwkJZ290byBmYWlsX2NsYXNzZGV2Ow0KIAl9DQogI2lm
IExJTlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9WRVJTSU9OKDIsNiwxMikN
Ci0gICAgICAgIHJldCA9IGNsYXNzX2RldmljZV9jcmVhdGVfZmlsZSgmdmZk
LT5jbGFzc19kZXYsICZjbGFzc19kZXZpY2VfYXR0cl9kZXYpOw0KLSAgICAg
ICAgaWYgKHJldCA8IDApIHsNCi0gICAgICAgICAgICAgICAgcHJpbnRrKEtF
Uk5fV0FSTklORyAiJXMgZXJyb3I6ICVkXG4iLCBfX0ZVTkNUSU9OX18sIHJl
dCk7DQotCQlyZXR1cm4gcmV0Ow0KKwlyZXQgPSBjbGFzc19kZXZpY2VfY3Jl
YXRlX2ZpbGUoJnZmZC0+Y2xhc3NfZGV2LCAmY2xhc3NfZGV2aWNlX2F0dHJf
ZGV2KTsNCisJaWYgKHJldCkgew0KKwkJcHJpbnRrKEtFUk5fRVJSICIlczog
Y2xhc3NfZGV2aWNlX2NyZWF0ZV9maWxlICdkZXYnIGZhaWxlZFxuIiwNCisJ
CSAgICAgICBfX0ZVTkNUSU9OX18pOw0KKwkJZ290byBmYWlsX2NsYXNzZGV2
Ow0KIAl9DQogI2VuZGlmDQogDQpAQCAtMTYyMCw2ICsxNjI0LDE1IEBAIGlu
dCB2aWRlb19yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IHZpZGVvX2QNCiAJCSAg
ICAgICAiaHR0cDovL2x3bi5uZXQvQXJ0aWNsZXMvMzY4NTAvXG4iLCB2ZmQt
Pm5hbWUpOw0KICNlbmRpZg0KIAlyZXR1cm4gMDsNCisNCitmYWlsX2NsYXNz
ZGV2Og0KKwljbGFzc19kZXZpY2VfdW5yZWdpc3RlcigmdmZkLT5jbGFzc19k
ZXYpOw0KK2ZhaWxfbWlub3I6DQorCW11dGV4X2xvY2soJnZpZGVvZGV2X2xv
Y2spOw0KKwl2aWRlb19kZXZpY2VbdmZkLT5taW5vcl0gPSBOVUxMOw0KKwl2
ZmQtPm1pbm9yID0gLTE7DQorCW11dGV4X3VubG9jaygmdmlkZW9kZXZfbG9j
ayk7DQorCXJldHVybiByZXQ7DQogfQ0KIA0KIC8qKg0K

--289735796-2119888355-1153707360=:13138
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cdcf_bttv.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0607231916002.13138@shell3.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="cdcf_bttv.patch"

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBUcmVudCBQaWVwaG8gPHh5
enp5QHNwZWFrZWFzeS5vcmc+DQojIE5vZGUgSUQgMDkyYjA0MDA3YzBmMWFh
MmQzZjliNDQ2N2VhOGFiMzgzNzcyMzE5Ng0KIyBQYXJlbnQgIGI5MDA3OTZm
ZGZiNGJjODc2NDJjNDcwNTE1Zjg4ZWQ3YWU5MmNlZDMNCmJ0dHY6IHVzZSBj
bGFzc19kZXZpY2VfY3JlYXRlX2ZpbGUgYW5kIGhhbmRsZSBlcnJvcnMNCg0K
RnJvbTogVHJlbnQgUGllcGhvIDx4eXp6eUBzcGVha2Vhc3kub3JnPg0KDQpS
ZXZlcnkgYnR0di1kcml2ZXIuYyBmcm9tIHZpZGVvX2RldmljZV9jcmVhdGVf
ZmlsZSgpIHRvIHVzZQ0KY2xhc3NfZGV2aWNlX2NyZWF0ZV9maWxlKCkgYWdh
aW4uICB2aWRlb19kZXZpY2VfY3JlYXRlX2ZpbGUoKSBpcyBvbmx5DQphdmFp
bGFibGUgd2hlbiBWNEwxIGlzIG9uLg0KDQpQcm9wZXIgZXJyb3IgY2hlY2tp
bmcgaXMgYWRkZWQgZm9yIGZhaWx1cmUgb2YgY2xhc3NfZGV2aWNlX2NyZWF0
ZV9maWxlKCkuIA0KV2lsbCBwcmludCBlcnJvciBtZXNzYWdlIGFuZCB1bnJv
bGwgcGFydGlhbGx5IGNyZWF0ZWQgc3lzZnMgZW50cmllcy4NCg0KU2lnbmVk
LW9mZi1ieTogVHJlbnQgUGllcGhvIDx4eXp6eUBzcGVha2Vhc3kub3JnPg0K
DQpkaWZmIC1yIGI5MDA3OTZmZGZiNCAtciAwOTJiMDQwMDdjMGYgbGludXgv
ZHJpdmVycy9tZWRpYS92aWRlby9idDh4eC9idHR2LWRyaXZlci5jDQotLS0g
YS9saW51eC9kcml2ZXJzL21lZGlhL3ZpZGVvL2J0OHh4L2J0dHYtZHJpdmVy
LmMJU3VuIEp1bCAyMyAxOTowODoyMSAyMDA2IC0wNzAwDQorKysgYi9saW51
eC9kcml2ZXJzL21lZGlhL3ZpZGVvL2J0OHh4L2J0dHYtZHJpdmVyLmMJU3Vu
IEp1bCAyMyAxOToxMDo1MiAyMDA2IC0wNzAwDQpAQCAtMzk1Nyw4ICszOTU3
LDEyIEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGJ0dHZfcmVnaXN0ZXJfdmlk
ZW8NCiAJcHJpbnRrKEtFUk5fSU5GTyAiYnR0diVkOiByZWdpc3RlcmVkIGRl
dmljZSB2aWRlbyVkXG4iLA0KIAkgICAgICAgYnR2LT5jLm5yLGJ0di0+dmlk
ZW9fZGV2LT5taW5vciAmIDB4MWYpOw0KICNpZiBMSU5VWF9WRVJTSU9OX0NP
REUgPiBLRVJORUxfVkVSU0lPTigyLDUsMCkNCi0NCi0JdmlkZW9fZGV2aWNl
X2NyZWF0ZV9maWxlKGJ0di0+dmlkZW9fZGV2LCAmY2xhc3NfZGV2aWNlX2F0
dHJfY2FyZCk7DQorCWlmIChjbGFzc19kZXZpY2VfY3JlYXRlX2ZpbGUoJmJ0
di0+dmlkZW9fZGV2LT5jbGFzc19kZXYsDQorCQkJCSAgICAgJmNsYXNzX2Rl
dmljZV9hdHRyX2NhcmQpPDApIHsNCisJCXByaW50ayhLRVJOX0VSUiAiYnR0
diVkOiBjbGFzc19kZXZpY2VfY3JlYXRlX2ZpbGUgJ2NhcmQnICINCisJCSAg
ICAgICAiZmFpbGVkXG4iLCBidHYtPmMubnIpOw0KKwkJZ290byBlcnI7DQor
CX0NCiAjZW5kaWYNCiANCiAJLyogdmJpICovDQo=

--289735796-2119888355-1153707360=:13138--
