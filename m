Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTEVJe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTEVJe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:34:58 -0400
Received: from pop.gmx.de ([213.165.65.60]:21790 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262341AbTEVJe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:34:56 -0400
Message-Id: <5.2.0.9.2.20030522114349.00cfd8f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 22 May 2003 11:52:24 +0200
To: davidm@hpl.hp.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <16075.48579.189593.405154@napali.hpl.hp.com>
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <16075.8557.309002.866895@napali.hpl.hp.com>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_20410453==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_20410453==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 10:56 AM 5/21/2003 -0700, David Mosberger wrote:
> >>>>> On Wed, 21 May 2003 11:26:31 +0200, Mike Galbraith <efault@gmx.de> 
> said:
>
>   Mike> The page mentions persistent starvation.  My own explorations
>   Mike> of this issue indicate that the primary source is always
>   Mike> selecting the highest priority queue.
>
>My working assumption is that the problem is a bug with the dynamic
>prioritization.  The task receiving the signals calls sleep() after
>handling a signal and hence it's dynamic priority should end up higher
>than the priority of the task sending signals (since the sender never
>relinquishes the CPU voluntarily).
>
>However, I haven't actually had time to look at the relevant code, so
>I may be missing something.  If you understand the issue better,
>please explain to me why this isn't a dynamic priority issue.

You're right, it looks like a corner case.  It works fine here with the 
attached diff.

         -Mike 
--=====================_20410453==_
Content-Type: application/octet-stream; name="xx.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.diff"

LS0tIGxpbnV4LTIuNS42OS52aXJnaW4va2VybmVsL3NjaGVkLmMub3JnCVdlZCBNYXkgMjEgMDc6
NDU6MDAgMjAwMworKysgbGludXgtMi41LjY5LnZpcmdpbi9rZXJuZWwvc2NoZWQuYwlUaHUgTWF5
IDIyIDExOjA2OjEyIDIwMDMKQEAgLTEyNjQsNyArMTI2NCw3IEBACiAJdGFza190ICpwcmV2LCAq
bmV4dDsKIAlydW5xdWV1ZV90ICpycTsKIAlwcmlvX2FycmF5X3QgKmFycmF5OwotCXN0cnVjdCBs
aXN0X2hlYWQgKnF1ZXVlOworCXN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsICpjdXJyOwogCWludCBp
ZHg7CiAKIAkvKgpAQCAtMTI4Niw3ICsxMjg2LDYgQEAKIAlycSA9IHRoaXNfcnEoKTsKIAogCXJl
bGVhc2Vfa2VybmVsX2xvY2socHJldik7Ci0JcHJldi0+bGFzdF9ydW4gPSBqaWZmaWVzOwogCXNw
aW5fbG9ja19pcnEoJnJxLT5sb2NrKTsKIAogCS8qCkBAIC0xMzAzLDYgKzEzMDIsOSBAQAogCQkJ
YnJlYWs7CiAJCX0KIAlkZWZhdWx0OgorCQkvKiBPbmUgc2xlZXAgY3JlZGl0IGZvciByZWxlYXNp
bmcgdGhlIGNwdSBpbW1lZGlhdGVseS4gKi8KKwkJaWYgKHByZXYtPmxhc3RfcnVuID09IGppZmZp
ZXMgJiYgcHJldi0+c2xlZXBfYXZnIDwgTUFYX1NMRUVQX0FWRykKKwkJCXByZXYtPnNsZWVwX2F2
ZysrOwogCQlkZWFjdGl2YXRlX3Rhc2socHJldiwgcnEpOwogCWNhc2UgVEFTS19SVU5OSU5HOgog
CQk7CkBAIC0xMzMxLDggKzEzMzMsMjIgQEAKIAl9CiAKIAlpZHggPSBzY2hlZF9maW5kX2ZpcnN0
X2JpdChhcnJheS0+Yml0bWFwKTsKLQlxdWV1ZSA9IGFycmF5LT5xdWV1ZSArIGlkeDsKLQluZXh0
ID0gbGlzdF9lbnRyeShxdWV1ZS0+bmV4dCwgdGFza190LCBydW5fbGlzdCk7CituZXh0X3F1ZXVl
OgorCWhlYWQgPSBhcnJheS0+cXVldWUgKyBpZHg7CisJY3VyciA9IGhlYWQtPm5leHQ7CisJbmV4
dCA9IGxpc3RfZW50cnkoY3VyciwgdGFza190LCBydW5fbGlzdCk7CisJY3VyciA9IGN1cnItPm5l
eHQ7CisJLyoKKwkgKiBJZiB3ZSBhcmUgYWJvdXQgdG8gd3JhcCBiYWNrIHRvIHRoZSBoZWFkIG9m
IHRoZSBxdWV1ZSwKKwkgKiBnaXZlIGEgbG93ZXIgcHJpb3JpdHkgcXVldWUgYSBjaGFuY2UgdG8g
c25lYWsgb25lIGluLgorCSAqLworCWlmIChpZHggPT0gcHJldi0+cHJpbyAmJiBjdXJyID09IGhl
YWQgJiYgYXJyYXktPm5yX2FjdGl2ZSA+IDEpIHsKKwkJaW50IHRtcCA9IGZpbmRfbmV4dF9iaXQo
YXJyYXktPmJpdG1hcCwgTUFYX1BSSU8sICsraWR4KTsKKwkJaWYgKHRtcCA8IE1BWF9QUklPKSB7
CisJCQlpZHggPSB0bXA7CisJCQlnb3RvIG5leHRfcXVldWU7CisJCX0KKwl9CiAKIHN3aXRjaF90
YXNrczoKIAlwcmVmZXRjaChuZXh0KTsKQEAgLTEzNDIsNiArMTM1OCw3IEBACiAJaWYgKGxpa2Vs
eShwcmV2ICE9IG5leHQpKSB7CiAJCXJxLT5ucl9zd2l0Y2hlcysrOwogCQlycS0+Y3VyciA9IG5l
eHQ7CisJCXByZXYtPmxhc3RfcnVuID0gbmV4dC0+bGFzdF9ydW4gPSBqaWZmaWVzOwogCiAJCXBy
ZXBhcmVfYXJjaF9zd2l0Y2gocnEsIG5leHQpOwogCQlwcmV2ID0gY29udGV4dF9zd2l0Y2gocnEs
IHByZXYsIG5leHQpOwo=
--=====================_20410453==_--

