Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269983AbTGUMV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbTGUMV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:21:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:61629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269983AbTGUMUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:20:09 -0400
Message-Id: <5.2.1.1.2.20030721143309.01bb95f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 21 Jul 2003 14:39:21 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: [NOTAPATCH] Re: [PATCH] O6int for interactivity 
Cc: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307201715130.3548@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_29434281==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_29434281==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 05:21 PM 7/20/2003 -0700, Davide Libenzi wrote:
>On Sat, 19 Jul 2003, Mike Galbraith wrote:
>
> > >Everything that will make the scheduler to say "ok, I gave enough time to
> > >interactive tasks, now I'm really going to spin one from the masses" will
> > >work. Having a clean solution would not be an option here.
> >
> > ... just as soon as I get my decidedly unclean work-around functioning at
> > least as well as it did for plain old irman.   irman2 is _much_ more evil
> > than irman ever was (wow, good job!).  I thought it'd be a half an hour
> > tops.  This little bugger shows active starvation, expired starvation,
> > priority inflation, _and_ interactive starvation (i have to keep inventing
> > new terms to describe things i see.. jeez this is a good testcase).
>
>Yes, the problem is not only the expired tasks starvation. Anything in
>the active array that reside underneath the lower priority value of the
>range irman2 tasks oscillate inbetween, will experience a "CPU time eclipse".
>And you do not even need a smoked glass to look at it :)

I think I whipped the obnoxious little bugger.  Comments on the attached 
[kiss] approach?

I don't like what gpm tells me while irman2 is running with this diff, but 
hiccup hiccup is a heck of lot better than terminal starvation.

         -Mike 
--=====================_29434281==_
Content-Type: application/octet-stream; name="xx.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.diff"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxLnZpcmdpbi9rZXJuZWwvc2NoZWQuYy5vcmcJU2F0IEp1bCAx
OSAwOTo0MjoxMiAyMDAzCisrKyBsaW51eC0yLjYuMC10ZXN0MS52aXJnaW4va2VybmVsL3NjaGVk
LmMJTW9uIEp1bCAyMSAxNDoyOToyNiAyMDAzCkBAIC03Niw2ICs3NiwxMiBAQAogI2RlZmluZSBN
QVhfU0xFRVBfQVZHCQkoMTAqSFopCiAjZGVmaW5lIFNUQVJWQVRJT05fTElNSVQJKDEwKkhaKQog
I2RlZmluZSBOT0RFX1RIUkVTSE9MRAkJMTI1CisjZGVmaW5lIEVORF9JQV9QUklPCQkoTklDRV9U
T19QUklPKDEgLSBJTlRFUkFDVElWRV9ERUxUQSkpCisjZGVmaW5lIElOVEVSVkFMCQkoSFopCisj
ZGVmaW5lIERVUkFUSU9OX1BFUkNFTlQJMTAKKyNkZWZpbmUgRFVSQVRJT04JCShJTlRFUlZBTCAq
IERVUkFUSU9OX1BFUkNFTlQgLyAxMDApCisjZGVmaW5lIElOVEVSVkFMX0VYUElSRUQocnEpICh0
aW1lX2FmdGVyKGppZmZpZXMsIFwKKwkocnEpLT5pbnRlcnZhbF90cyArICgocnEpLT5pZHggPyBE
VVJBVElPTiA6IElOVEVSVkFMKSkpCiAKIC8qCiAgKiBJZiBhIHRhc2sgaXMgJ2ludGVyYWN0aXZl
JyB0aGVuIHdlIHJlaW5zZXJ0IGl0IGluIHRoZSBhY3RpdmUKQEAgLTE1OCw3ICsxNjQsNyBAQAog
c3RydWN0IHJ1bnF1ZXVlIHsKIAlzcGlubG9ja190IGxvY2s7CiAJdW5zaWduZWQgbG9uZyBucl9y
dW5uaW5nLCBucl9zd2l0Y2hlcywgZXhwaXJlZF90aW1lc3RhbXAsCi0JCQlucl91bmludGVycnVw
dGlibGU7CisJCQlucl91bmludGVycnVwdGlibGUsIGludGVydmFsX3RzOwogCXRhc2tfdCAqY3Vy
ciwgKmlkbGU7CiAJc3RydWN0IG1tX3N0cnVjdCAqcHJldl9tbTsKIAlwcmlvX2FycmF5X3QgKmFj
dGl2ZSwgKmV4cGlyZWQsIGFycmF5c1syXTsKQEAgLTE3MSw2ICsxNzcsNyBAQAogCXN0cnVjdCBs
aXN0X2hlYWQgbWlncmF0aW9uX3F1ZXVlOwogCiAJYXRvbWljX3QgbnJfaW93YWl0OworCWludCBp
ZHg7CiB9OwogCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IHJ1bnF1ZXVlLCBydW5xdWV1
ZXMpOwpAQCAtMTE2Niw2ICsxMTczLDIzIEBACiAJCQlTVEFSVkFUSU9OX0xJTUlUICogKChycSkt
Pm5yX3J1bm5pbmcpICsgMSkpKQogCiAvKgorICogTXVzdCBiZSBjYWxsZWQgd2l0aCB0aGUgcnVu
cXVldWUgbG9jayBoZWxkLgorICovCitzdGF0aWMgdm9pZCBfX3JlcXVldWVfb25lX2V4cGlyZWQo
cnVucXVldWVfdCAqcnEpCit7CisJaW50IGlkeCA9IHNjaGVkX2ZpbmRfZmlyc3RfYml0KHJxLT5l
eHBpcmVkLT5iaXRtYXApOworCXN0cnVjdCBsaXN0X2hlYWQgKnF1ZXVlOworCXRhc2tfdCAqcDsK
KworCWlmIChpZHggPj0gTUFYX1BSSU8pCisJCXJldHVybjsKKwlxdWV1ZSA9IHJxLT5leHBpcmVk
LT5xdWV1ZSArIGlkeDsKKwlwID0gbGlzdF9lbnRyeShxdWV1ZS0+bmV4dCwgdGFza190LCBydW5f
bGlzdCk7CisJZGVxdWV1ZV90YXNrKHAsIHAtPmFycmF5KTsKKwllbnF1ZXVlX3Rhc2socCwgcnEt
PmFjdGl2ZSk7Cit9CisKKy8qCiAgKiBUaGlzIGZ1bmN0aW9uIGdldHMgY2FsbGVkIGJ5IHRoZSB0
aW1lciBjb2RlLCB3aXRoIEhaIGZyZXF1ZW5jeS4KICAqIFdlIGNhbGwgaXQgd2l0aCBpbnRlcnJ1
cHRzIGRpc2FibGVkLgogICoKQEAgLTEyNDIsMTAgKzEyNjYsMzUgQEAKIAkJCWlmICghcnEtPmV4
cGlyZWRfdGltZXN0YW1wKQogCQkJCXJxLT5leHBpcmVkX3RpbWVzdGFtcCA9IGppZmZpZXM7CiAJ
CQllbnF1ZXVlX3Rhc2socCwgcnEtPmV4cGlyZWQpOwotCQl9IGVsc2UKKwkJfSBlbHNlIHsKIAkJ
CWVucXVldWVfdGFzayhwLCBycS0+YWN0aXZlKTsKKwkJCWlmIChycS0+aWR4KQorCQkJCV9fcmVx
dWV1ZV9vbmVfZXhwaXJlZChycSk7CisJCX0KKwl9IGVsc2UgaWYgKElOVEVSVkFMX0VYUElSRUQo
cnEpKSB7CisJCS8qCisJCSAqIElmIHdlIGhhdmVuJ3QgcnVuIGEgbm9uLWludGVyYWN0aXZlIHRh
c2sgd2l0aGluIG91cgorCQkgKiBpbnRlcnZhbCwgd2UgdGFrZSB0aGlzIGFzIGEgaGludCB0aGF0
IHdlIG1heSBoYXZlCisJCSAqIHN0YXJ2YXRpb24gaW4gcHJvZ3Jlc3MuICBUcmlnZ2VyIGEgcXVl
dWUgd2Fsay1kb3duLAorCQkgKiBhbmQgd2FsayB1bnRpbCBlaXRoZXIgbm9uLWludGVyYWN0aXZl
IHRhc2tzIGhhdmUKKwkJICogcmVjZWl2ZWQgRFVSQVRJT04gdGlja3MsIG9yIHdlIGhpdCB0aGUg
Ym90dG9tLgorCQkgKi8KKwkJaWYgKFRBU0tfSU5URVJBQ1RJVkUocCkpIHsKKwkJCXByaW9fYXJy
YXlfdCAqYXJyYXkgPSBwLT5hcnJheTsKKworCQkJLyogUmVxdWV1ZSB0aGUgaGlnaHQgcHJpb3Jp
dHkgZXhwaXJlZCB0YXNrLi4uICovCisJCQkJX19yZXF1ZXVlX29uZV9leHBpcmVkKHJxKTsKKwkJ
CS8qIGFuZCB0ZWxsIHRoZSBzY2hlZHVsZXIgd2hlcmUgdG8gc3RhcnQgd2Fsa2luZy4gKi8KKwkJ
CXJxLT5pZHggPSBmaW5kX25leHRfYml0KGFycmF5LT5iaXRtYXAsIE1BWF9QUklPLCAxICsgcC0+
cHJpbyk7CisJCQlpZiAocnEtPmlkeCA+PSBNQVhfUFJJTykKKwkJCQlycS0+aWR4ID0gMDsKKwkJ
fSBlbHNlCisJCQlycS0+aWR4ID0gMDsKKwkJcnEtPmludGVydmFsX3RzID0gamlmZmllczsKIAl9
CiBvdXRfdW5sb2NrOgorCWlmIChycS0+aWR4ICYmIFRBU0tfSU5URVJBQ1RJVkUocCkpCisJCXJx
LT5pbnRlcnZhbF90cysrOwogCXNwaW5fdW5sb2NrKCZycS0+bG9jayk7CiBvdXQ6CiAJcmViYWxh
bmNlX3RpY2socnEsIDApOwpAQCAtMTMxMiw2ICsxMzYxLDggQEAKICNlbmRpZgogCQluZXh0ID0g
cnEtPmlkbGU7CiAJCXJxLT5leHBpcmVkX3RpbWVzdGFtcCA9IDA7CisJCXJxLT5pbnRlcnZhbF90
cyA9IGppZmZpZXM7CisJCXJxLT5pZHggPSAwOwogCQlnb3RvIHN3aXRjaF90YXNrczsKIAl9CiAK
QEAgLTEzMjksNiArMTM4MCwxNyBAQAogCWlkeCA9IHNjaGVkX2ZpbmRfZmlyc3RfYml0KGFycmF5
LT5iaXRtYXApOwogCXF1ZXVlID0gYXJyYXktPnF1ZXVlICsgaWR4OwogCW5leHQgPSBsaXN0X2Vu
dHJ5KHF1ZXVlLT5uZXh0LCB0YXNrX3QsIHJ1bl9saXN0KTsKKwlpZiAodW5saWtlbHkocnEtPmlk
eCkpIHsKKwkJaWYoIXJ0X3Rhc2sobmV4dCkpIHsKKwkJCWludCBpbmRleCA9IGZpbmRfbmV4dF9i
aXQoYXJyYXktPmJpdG1hcCwgTUFYX1BSSU8sIHJxLT5pZHgpOworCQkJaWYgKGluZGV4IDwgTUFY
X1BSSU8pIHsKKwkJCQlxdWV1ZSA9IGFycmF5LT5xdWV1ZSArIGluZGV4OworCQkJCW5leHQgPSBs
aXN0X2VudHJ5KHF1ZXVlLT5uZXh0LCB0YXNrX3QsIHJ1bl9saXN0KTsKKwkJCQlpZiAoaW5kZXgg
PCBFTkRfSUFfUFJJTykKKwkJCQkJcnEtPmlkeCA9IGluZGV4ICsgMTsKKwkJCX0KKwkJfQorCX0K
IAogc3dpdGNoX3Rhc2tzOgogCXByZWZldGNoKG5leHQpOwpAQCAtMjQ5Nyw2ICsyNTU5LDcgQEAK
IAkJcnEgPSBjcHVfcnEoaSk7CiAJCXJxLT5hY3RpdmUgPSBycS0+YXJyYXlzOwogCQlycS0+ZXhw
aXJlZCA9IHJxLT5hcnJheXMgKyAxOworCQlycS0+aW50ZXJ2YWxfdHMgPSBJTklUSUFMX0pJRkZJ
RVM7CiAJCXNwaW5fbG9ja19pbml0KCZycS0+bG9jayk7CiAJCUlOSVRfTElTVF9IRUFEKCZycS0+
bWlncmF0aW9uX3F1ZXVlKTsKIAkJYXRvbWljX3NldCgmcnEtPm5yX2lvd2FpdCwgMCk7Cg==
--=====================_29434281==_--

