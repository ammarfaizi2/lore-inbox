Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbRAOKyO>; Mon, 15 Jan 2001 05:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbRAOKxz>; Mon, 15 Jan 2001 05:53:55 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:17033 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130686AbRAOKxe>; Mon, 15 Jan 2001 05:53:34 -0500
Message-ID: <3A62D82F.49BF3693@uow.edu.au>
Date: Mon, 15 Jan 2001 21:59:59 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: Re: low-latency scheduling patch for 2.4.0
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> <3A618F17.FD285E2B@uow.edu.au>,
		<3A618F17.FD285E2B@uow.edu.au>; from andrewm@uow.edu.au on Sun, Jan 14, 2001 at 10:35:51PM +1100 <20010114093836.C10910@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> 
> On Sun, Jan 14, 2001 at 10:35:51PM +1100, Andrew Morton wrote:
> [snip]
> > - The patch now works properly on SMP.
> [snip]
> 
> Any benchmark results on SMP yet?

SMP and UP are much the same.

Workload is `make -j3 bzImage', the measured time
is from entry to an ISR to execution of the userspace
process.  The histogram has 10 microsecond resolution.

SMP
===
0:165601 10:17192 20:12769 30:33220 40:59318
50:60814 60:42915 70:20949 80:8124 90:2590
100:944 110:397 120:211 130:96 140:51
150:41 160:36 170:24 180:21 190:15
200:14 210:12 220:13 230:7 240:11
250:6 260:3 270:4 280:10 290:6
300:5 310:3 320:3 330:6 340:1
350:1 370:1 400:1 620:1

Total samples: 425436

So on SMP, latency is < 10 microseconds 165601/425436 = 39% of
the time.

UP
==

0:52735 10:33480 20:101199 30:200301 40:135470
50:9199 60:4356 70:1531 80:770 90:396
100:288 110:178 120:102 130:100 140:63
150:45 160:61 170:40 180:30 190:23
200:29 210:12 220:26 230:10 240:8
250:6 260:2 300:1

Total samples: 540461


In other words:

SMP
===

usecs

0  -100:   99.54%
100-200:    0.43%
200-300:    0.02%
300-400:    0.0049%
620:        0.00023%

UP
==

0  -100:   99.81%
100-200:    0.17%
200-300:    0.017%
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
