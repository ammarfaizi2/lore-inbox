Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTEUIwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTEUIwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:52:21 -0400
Received: from pop.gmx.net ([213.165.65.60]:13044 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262034AbTEUIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:52:19 -0400
Message-Id: <5.2.0.9.2.20030521074611.00cbe3c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 21 May 2003 11:08:34 +0200
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-sync-2.5.69-A0
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305191027420.4382-100000@localhost.localdom
 ain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_58098875==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_58098875==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 10:35 AM 5/19/2003 +0200, Ingo Molnar wrote:

>the attached patch fixes the scheduler's sync-wakeup code to be consistent
>on UP as well.
>
>Right now there's a behavioral difference between an UP kernel and an SMP
>kernel running on a UP box: sync wakeups (which are only activated on SMP)
>can cause a wakeup of a higher prio task, without preemption. On UP
>kernels this does not happen. This difference in wakeup behavior is bad.

Cool.  That was the cause of some of the radical differences in behavior 
between smp and up kernels.  The sync wakeup in pipe wait for example was 
the irman process load climbs through the roof problem, and it also affects 
the ext3 concurrency problem if you have gcc using -pipe.  See attached log.

         -Mike 
--=====================_58098875==_
Content-Type: text/plain; name="log.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="log.txt"

W2JlZm9yZV06IyB0aW1lIC4vaXJtYW4KUmVzcG9uc2UgdGltZSBtZWFzdXJlbWVudHMgKG1pbGxp
c2Vjb25kcykgZm9yOiAyLjUuNjkKICAgTG9hZCAgICAgICBNYXggICAgICAgTWluICAgICAgIEF2
ZyBTdGQuIERldi4KICAgTlVMTCAgICAgMC4xNDIgICAgIDAuMDA5ICAgICAwLjAxMSAgICAgMC4w
MDIKIE1FTU9SWSAgIDEwNy4wNDAgICAgIDAuMDEwICAgICAwLjAyMSAgICAgMC45OTYKRklMRV9J
TyAgIDMxMC45OTEgICAgIDAuMDEwICAgICAwLjAzMyAgICAgMi41OTgKUFJPQ0VTUyAgMTAyMS44
NzMgICAgIDAuMDEwICAgICAwLjA1MyAgICAgNS42MjUKCnJlYWwgICAgM20zMi41ODhzCnVzZXIg
ICAgMG0yOC4zNTBzCnN5cyAgICAgMG0yMS4zNTNzCgpbYmVmb3JlXTojIHRpbWUgbWFrZSAtajMw
IGJ6SW1hZ2UgKGV4dDMsIGdjYyB1c2luZyAtcGlwZSkKcmVhbCAgICAybTMyLjE0MnMKdXNlciAg
ICAybTE0LjUwNXMKc3lzICAgICAwbTEwLjY4NXMKCltiZWZvcmVdOiMgZ3JlcCBwc3dwIC9wcm9j
L3Ztc3RhdApwc3dwaW4gMTQ0OApwc3dwb3V0IDI0MzYKClthZnRlcl06IyB0aW1lIC4vaXJtYW4K
UmVzcG9uc2UgdGltZSBtZWFzdXJlbWVudHMgKG1pbGxpc2Vjb25kcykgZm9yOiAyLjUuNjkKICAg
TG9hZCAgICAgICBNYXggICAgICAgTWluICAgICAgIEF2ZyBTdGQuIERldi4KICAgTlVMTCAgICAg
MC4yODYgICAgIDAuMDEwICAgICAwLjAxMSAgICAgMC4wMDIKIE1FTU9SWSAgIDEwMy4xMTEgICAg
IDAuMDEwICAgICAwLjAyMSAgICAgMC45OTAKRklMRV9JTyAgIDMwNi4xNTEgICAgIDAuMDEwICAg
ICAwLjAzMyAgICAgMi41NzgKUFJPQ0VTUyAgIDM1OS4wNzIgICAgIDAuMDEwICAgICAwLjAzMyAg
ICAgMC42ODcKCnJlYWwgICAgMm0yMy41NDhzCnVzZXIgICAgMG0yNi4xNjBzCnN5cyAgICAgMG0y
Mi45NDBzCgpbYWZ0ZXJdOiMgdGltZSBtYWtlIC1qMzAgYnpJbWFnZSAoZXh0MywgZ2NjIHVzaW5n
IC1waXBlKQpyZWFsICAgIDJtMzUuMDE4cwp1c2VyICAgIDJtMTYuMDc1cwpzeXMgICAgIDBtMTEu
ODk5cwoKW2FmdGVyXTojIGdyZXAgcHN3cCAvcHJvYy92bXN0YXQKcHN3cGluIDE5MjIwCnBzd3Bv
dXQgMzMwMTkK
--=====================_58098875==_--

