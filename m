Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270246AbRHHASi>; Tue, 7 Aug 2001 20:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270243AbRHHAS2>; Tue, 7 Aug 2001 20:18:28 -0400
Received: from mail.ureach.com ([63.150.151.36]:58635 "EHLO ureach.com")
	by vger.kernel.org with ESMTP id <S270242AbRHHASO>;
	Tue, 7 Aug 2001 20:18:14 -0400
Date: Tue, 7 Aug 2001 20:18:22 -0400
Message-Id: <200108080018.UAA13390@www23.ureach.com>
To: linux-kernel@vger.kernel.org
From: Kapish K <kapish@ureach.com>
Reply-to: <kapish@ureach.com>
Subject: a query related to locks and smp
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-vsuite-type: e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      We have been getting a consistent oops on an smp box ( 2
processors ), and when kdb is turned on, it oopses, but the oops
message shows only the register information for the faulting
process a on cpu x. cpu y shows a running process b which at
that point seems to be in a lock_kernel routine from within
sys_ioctl. We are unable to exactly figure out the code path for
the process a, but there are a few other processes in run state
on cpu a, which are the nfs daemons. A backtrace of those show
that they are in the schedule routine near, switch_to(). Each
instance of the nfsd daemons call into another daemon c each,
each of which call the schedule routine, as part of a sleep
on/interruptible sleep on routines, based along the same lines
as the code in sched.c
I am trying to understand what could possibly going wrong in the
locking mechanism here, that could be causing the oops. Is there
any way to debug code specific to such locks, like spinlocks,
maybe try some kind of configuration parameter setup or
something? If need be, I can attach portions of the kdb output. 
Or if there are suggestions as to how to narrow this further,
that would be helpful.
Since I am not subscribed on this list, kindly cc to the id.
TIA

________________________________________________
Get your own "800" number
Voicemail, fax, email, and a lot more
http://www.ureach.com/reg/tag
