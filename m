Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbTCLTjO>; Wed, 12 Mar 2003 14:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTCLTjO>; Wed, 12 Mar 2003 14:39:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:21808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261968AbTCLTjM>;
	Wed, 12 Mar 2003 14:39:12 -0500
Message-Id: <5.2.0.9.2.20030312204553.00cd5068@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 20:54:27 +0100
To: jim.houston@attbi.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] self tuning scheduler 0.2
Cc: linux-kernel@vger.kernel.org, jim.houston@ccur.com
In-Reply-To: <200303121529.h2CFTMv00924@linux.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_10294578==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_10294578==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 10:29 AM 3/12/2003 -0500, Jim Houston wrote:

>Hi Mike, Everyone,

Greetings,

>Mike, I have made a few adjustments which I hope will make you happy.
>I changed the time_slice code so it gives larger time slices to
>processes with less than average priorities.  This makes my "make -j30"
>compile times match those of linux-2.5.64.

I only did one run, but yep, it's pretty close on my box too.

>I have some experimental code to address the irman issues.  My first
>change was to adjust the run_avg value during a synchronous wakeup.
>The idea is to average the values so that related processes priorities
>will clump together.  I also felt that the circle of processes passing
>a token are really a disguised compute bound process.  To punish this
>behavoir, I add a small amount to the run_avg of the woken process.
>You can adjust the amount with /proc/sys/sched/pipe_circle_tax.  I default
>this value to 5.  This obviously also punishes the innocent.  So the
>question is if the value is small enough can it fix the irman problem
>without breaking something else.

A value of 5 doesn't seem to be enough.  I fixed irman's parse problem so 
it can run the memory test properly and ran it with pipe_circle_tax set to 
5, 25 and 50.  The results are attached along with results from 
2.5.64.virgin and 2.5.64.bk5 for comparison.

There isn't any detectable change wrt the window wiggle test... still 
pretty choppy.

         -Mike

--=====================_10294578==_
Content-Type: text/plain; name="xx.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.txt"

cGlwZV9jaXJjbGVfdGF4ID0gNQphYm9ydGVkIGFmdGVyIDIwIG1pbnV0ZXMKCnBpcGVfY2lyY2xl
X3RheCA9IDI1ClttaWtlZ106PiB0aW1lIC4vaXJtYW4KUmVzcG9uc2UgdGltZSBtZWFzdXJlbWVu
dHMgKG1pbGxpc2Vjb25kcykgZm9yOiAyLjUuNjRiazVzdHMKICAgICAgTG9hZCAgICAgICBNYXgg
ICAgICAgTWluICAgICAgIEF2ZyBTdGQuIERldi4KICAgICAgTlVMTCAgICAgMC4zNjIgICAgIDAu
MDA5ICAgICAwLjAxMCAgICAgMC4wMDIKICAgIE1FTU9SWSAgIDI1MC4wNDggICAgIDAuMDA5ICAg
ICAwLjAxOSAgICAgMS4wNzUKICAgRklMRV9JTyAgIDc0OS45NjUgICAgIDAuMDEwICAgICAwLjAy
NyAgICAgMi4xOTkKICAgUFJPQ0VTUyAgIDgyNC4zMDUgICAgIDAuMDEwICAgICAwLjA4MCAgICAg
Mi44MjEKCnJlYWwgICAgM20yMC43MzNzCnVzZXIgICAgMG01Mi42NjJzCnN5cyAgICAgMG0yMC45
ODFzCgpwaXBlX2NpcmNsZV90YXggPSA1MApbbWlrZWddOj4gdGltZSAuL2lybWFuClJlc3BvbnNl
IHRpbWUgbWVhc3VyZW1lbnRzIChtaWxsaXNlY29uZHMpIGZvcjogMi41LjY0Yms1c3RzCiAgICAg
IExvYWQgICAgICAgTWF4ICAgICAgIE1pbiAgICAgICBBdmcgU3RkLiBEZXYuCiAgICAgIE5VTEwg
ICAgIDAuMjQ3ICAgICAwLjAxMCAgICAgMC4wMTEgICAgIDAuMDAyCiAgICBNRU1PUlkgICAzNzUu
MDAxICAgICAwLjAwOSAgICAgMC4wMjAgICAgIDEuMjQ0CiAgIEZJTEVfSU8gICA0OTkuOTg3ICAg
ICAwLjAwOSAgICAgMC4wMzIgICAgIDIuNDgzCiAgIFBST0NFU1MgICA1MjUuOTMyICAgICAwLjAx
MCAgICAgMC4wNTEgICAgIDIuMzA2CgpyZWFsICAgIDNtNS44NTdzCnVzZXIgICAgMG01NC44Mjhz
CnN5cyAgICAgMG0yMS41NzFzCgpbbWlrZWddOj4gdGltZSAuL2lybWFuClJlc3BvbnNlIHRpbWUg
bWVhc3VyZW1lbnRzIChtaWxsaXNlY29uZHMpIGZvcjogMi41LjY0LnZpcmdpbgogICAgICBMb2Fk
ICAgICAgIE1heCAgICAgICBNaW4gICAgICAgQXZnIFN0ZC4gRGV2LgogICAgICBOVUxMICAgICAw
LjczMyAgICAgMC4wMTAgICAgIDAuMDExICAgICAwLjAwMgogICAgTUVNT1JZICAgMTUxLjMwOCAg
ICAgMC4wMTAgICAgIDAuMDE3ICAgICAwLjk2OQogICBGSUxFX0lPICAgNDU0LjAxNiAgICAgMC4w
MTAgICAgIDAuMDI3ICAgICAyLjcxOAogICBQUk9DRVNTICAxMjE2Ljg0OCAgICAgMC4wMTAgICAg
IDAuMDQ5ICAgICA2LjQxMQoKcmVhbCAgICAybTQ2LjU5MXMKdXNlciAgICAwbTIwLjI3MHMKc3lz
ICAgICAwbTIxLjYyMnMKClttaWtlZ106PiB0aW1lIC4vaXJtYW4KUmVzcG9uc2UgdGltZSBtZWFz
dXJlbWVudHMgKG1pbGxpc2Vjb25kcykgZm9yOiAyLjUuNjRiazUKICAgICAgTG9hZCAgICAgICBN
YXggICAgICAgTWluICAgICAgIEF2ZyBTdGQuIERldi4KICAgICAgTlVMTCAgICAgMy4zNzMgICAg
IDAuMDEwICAgICAwLjAxMiAgICAgMC4wMDQKICAgIE1FTU9SWSAgIDEwNi4wNDIgICAgIDAuMDEx
ICAgICAwLjAyMyAgICAgMS4wOTAKICAgRklMRV9JTyAgIDMxMi4wNDYgICAgIDAuMDExICAgICAw
LjA0NyAgICAgMy4yOTcKICAgUFJPQ0VTUyAgIDIyMy40ODIgICAgIDAuMDEwICAgICAwLjAzNyAg
ICAgMC40ODgKCnJlYWwgICAgMm01MS4yNjVzCnVzZXIgICAgMG0yOS45MDJzCnN5cyAgICAgMG0y
My45MjBzCg==
--=====================_10294578==_--

