Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbTCNOTb>; Fri, 14 Mar 2003 09:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbTCNOTb>; Fri, 14 Mar 2003 09:19:31 -0500
Received: from mail.gmx.net ([213.165.65.60]:29942 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263330AbTCNOT2>;
	Fri, 14 Mar 2003 09:19:28 -0500
Message-Id: <5.2.0.9.2.20030314152115.00ce76b0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 14 Mar 2003 15:34:44 +0100
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm6, a new test case for scheduler interactivity
  problems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303132201.02278.cb-lkml@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_8278375==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_8278375==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 10:01 PM 3/13/2003 +0000, Charles Baylis wrote:

>Hi all
>
>I've just installed 2.5.64-mm6, and I've tried out the new improved
>scheduler and it's definately not there yet. I can easily cause ogg
>playback to skip (for example) by changing virtual desktop in windowmaker
>to busy konqueror window. X is not reniced (has a nice level of 0)
>
>It's several months since I last ran a 2.4 kernel on this machine, but as I
>remember it did not skip when changing desktops.
>
>My experience suggests that skips occur when more than one interactive task
>starts to become a CPU hog, for example X and konqueror can be idle for
>long periods, and so become interactive, but during an intensive redraw
>they briefly behave as CPU hogs but maintain their interactive bonus this
>means that ogg123 has to wait until the hogs complete their timeslice
>before being scheduled.
>
>My test case tries to reproduce this by creating a number of tasks which
>alternate between being 'interactive' and CPU hogs. On my Celery 333 laptop
>it can sometimes cause skips with only 1 child, and is pretty much
>guaranteed to cause skips with more child tasks.

Greetings,

Nice test case.  I don't have sound capability on my linux box, but your 
test case makes it fail the window wiggle test horribly.  I fiddled with it 
a bit, and convinced it to "stop doing that please".  Does the attached 
(experimental butchery) help your box's sp-sp-speach im-p-p-pediment?

         -Mike 
--=====================_8278375==_
Content-Type: application/octet-stream; name="bk5_sched.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bk5_sched.diff"

LS0tIGxpbnV4LTIuNS42NC1iazUva2VybmVsL3NjaGVkLmMub3JnCVdlZCBNYXIgMTIgMDg6NTE6
MTEgMjAwMworKysgbGludXgtMi41LjY0LWJrNS9rZXJuZWwvc2NoZWQuYwlGcmkgTWFyIDE0IDE1
OjI3OjEyIDIwMDMKQEAgLTcyLDcgKzcyLDcgQEAKICNkZWZpbmUgUFJJT19CT05VU19SQVRJTwky
NQogI2RlZmluZSBJTlRFUkFDVElWRV9ERUxUQQkyCiAjZGVmaW5lIE1BWF9TTEVFUF9BVkcJCSgx
MCpIWikKLSNkZWZpbmUgU1RBUlZBVElPTl9MSU1JVAkoMTAqSFopCisjZGVmaW5lIFNUQVJWQVRJ
T05fTElNSVQJKDEqSFopCiAjZGVmaW5lIE5PREVfVEhSRVNIT0xECQkxMjUKIAogLyoKQEAgLTM1
Niw2ICszNTYsOCBAQAogCQkgKiBzcGVuZHMgc2xlZXBpbmcsIHRoZSBoaWdoZXIgdGhlIGF2ZXJh
Z2UgZ2V0cyAtIGFuZCB0aGUKIAkJICogaGlnaGVyIHRoZSBwcmlvcml0eSBib29zdCBnZXRzIGFz
IHdlbGwuCiAJCSAqLworCQlpZiAoc2xlZXBfdGltZSA+IE1BWF9USU1FU0xJQ0UpCisJCQlzbGVl
cF90aW1lID0gTUFYX1RJTUVTTElDRTsKIAkJc2xlZXBfYXZnID0gcC0+c2xlZXBfYXZnICsgc2xl
ZXBfdGltZTsKIAogCQkvKgpAQCAtMzk3LDYgKzM5OSw4IEBACiAJCXJxLT5ucl91bmludGVycnVw
dGlibGUrKzsKIAlkZXF1ZXVlX3Rhc2socCwgcC0+YXJyYXkpOwogCXAtPmFycmF5ID0gTlVMTDsK
KwlpZiAocC0+c2xlZXBfYXZnKQorCQlwLT5zbGVlcF9hdmctLTsKIH0KIAogLyoKQEAgLTEyNDks
NiArMTI1Myw4IEBACiAJaWYgKCEtLXAtPnRpbWVfc2xpY2UpIHsKIAkJZGVxdWV1ZV90YXNrKHAs
IHJxLT5hY3RpdmUpOwogCQlzZXRfdHNrX25lZWRfcmVzY2hlZChwKTsKKwkJaWYgKFRBU0tfSU5U
RVJBQ1RJVkUocCkgJiYgcC0+c2xlZXBfYXZnID4gTUlOX1RJTUVTTElDRSkKKwkJCXAtPnNsZWVw
X2F2ZyAtPSBNSU5fVElNRVNMSUNFOwogCQlwLT5wcmlvID0gZWZmZWN0aXZlX3ByaW8ocCk7CiAJ
CXAtPnRpbWVfc2xpY2UgPSB0YXNrX3RpbWVzbGljZShwKTsKIAkJcC0+Zmlyc3RfdGltZV9zbGlj
ZSA9IDA7Cg==
--=====================_8278375==_--

