Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292315AbSB0Kso>; Wed, 27 Feb 2002 05:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292320AbSB0Ksf>; Wed, 27 Feb 2002 05:48:35 -0500
Received: from h24-80-72-10.vn.shawcable.net ([24.80.72.10]:52740 "EHLO
	linisoft.localdomain") by vger.kernel.org with ESMTP
	id <S292315AbSB0KsZ>; Wed, 27 Feb 2002 05:48:25 -0500
Message-ID: <3C7CBB39.A6FC444@linisoft.com>
Date: Wed, 27 Feb 2002 02:55:53 -0800
From: Reza Roboubi <reza@linisoft.com>
Organization: Linisoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LK <linux-kernel@vger.kernel.org>
Subject: Async IO using threads
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUMMARY:

Basically, I'm trying to do async io through a SCHED_FIFO thread with
high priority reading the disk, and the other less prioritized thread
doing "real" work.  But I can't get _nearly_ enough out of the CPU while
reading the disk with the other thread.  It is just intolerably 
inefficient and I _hope_ that I am making  a mistake. 
Any ideas on how this should work are appreciated.

MORE INFO (only if you must have it):

I read much of the async io / kio discussion on the LK mailing list. 
Finally
Linus concluded that threading _is_ the way to go for now(2001 I
believe).

First, I have kernel 2.2.16  (RedHat 6.2).   If this has been corrected
in the 2.4, then please let me know, but I think not.

On my system, "raw" read()ing a large chunk of the /dev/hda5 partition
shows that reading a page (4k) takes about 230000 clock "ticks" which is
the cpu effort required for 23 context switches.  So I figure if the
disk generates the "io available" interrupt once every 4k chunk  (this
might be the bad assumption), then linux  has plenty time to do
several switches between the interrupt handler, and the high priority
SCHED_FIFO process, and the low priority SCHED_FIFO process, and still
have time for plenty useful work at the user level, and time to get back
to handle the io request.  During this read(), I should be able to use
at _least_ 50% of my CPU.  But I get much less than 10 percent!!  Why??

If there is anything that should be done to the kernel, please let me
know  as I'd certainly be very willing to help.  How  exactly _does_
this  scheduling and io thing work?  Is there some "jiffy" that _must_
expire before Linux switches and lets my other thread do useful work? 
If so,  then how do you shorten it?  Or is it that my IDE disk is very
lousy?   Then what are the parameters I should consider in an IDE disk
and how do I tell what I have??  Or is this simply a bad and pending
Linux bug?
(hard to believe)

Or maybe my test code  is faulty (unlikely also.)

(Test code at http://www.linisoft.com/test/async.c .)

Please reply to me directly.

Thanks in advance for any insight.

-- 
Reza
