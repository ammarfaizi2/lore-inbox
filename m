Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbTBLXIL>; Wed, 12 Feb 2003 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTBLXIL>; Wed, 12 Feb 2003 18:08:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267923AbTBLXII>;
	Wed, 12 Feb 2003 18:08:08 -0500
Date: Wed, 12 Feb 2003 15:15:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: high-res-timers-discourse@lists.sourceforge.net
Cc: cgl_discussion@osdl.org, linux-kernel@vger.kernel.org, dkegel@ixiacom.com
Subject: review high-res-timers patches
Message-Id: <20030212151505.70ac117f.rddunlap@osdl.org>
In-Reply-To: <3E4AAB24.7060306@ixiacom.com>
References: <87lm0lqy4l.fsf@esdg-pc08.esdgkonsult.com>
	<3E4A7D97.47FB78DE@attbi.com>
	<3E4AAB24.7060306@ixiacom.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| By the way, is there any comparison of the two patches
| available?  One of the things stopping Linus may be
| that we haven't come to a consensus as to which of
| the patches is "right".

Here's the current status of CGL review of them.
--
~Randy

=====================================================================

Geoff Gustafson, Julie Fleischer, and I have spent some time on
high-res-timers review and testing.  The initial goals were:

(a) requirements justification for CGL;
(b) code review and feedback; and
(c) conformance, functional, and performance/stress testing.


(a) Requirements

"Requirement: 6.4.1 Concurrent Timers Scaling Behavior and Report 
 Description: OSDL CGL shall determine support for applications that 
 require scaling of total count of system timers into the 1000s."

[This is not _that_ report.]

(b) Code review and feedback

I reviewed Jim Houston's "alternate" timers patch and sent comments
on it to to high-res-timers-discourse@lists.sf.net and
linux-kernel@vger.kernel.org.

Review of George Anzinger's high-res-timers patch is currently postponed
indefinitely.

A few notable differences in the patches, mostly from a usability
viewpoint instead of an implementation viewpoint:

. Jim's patch is not a CONFIG option but George's patch is.
. Jim's patch works with TSC or PIT a timer source whereas George's
  patch uses TSC, PIT, or the ACPI timer (CONFIG-selectable).


(c) Code testing

Julie maintains a POSIX test suite at <http://posixtest.sourceforge.net/>.
There is also some verification/conformance code in the high-res-timers
support patch at <http://sourceforge.net/projects/high-res-timers/>.

There are still some POSIX conformance issues with the original HRT
patches, although some of these may be fixed in the most recent versions
of the patches.  The alternate patchset passes all POSIX conformance
tests.
See <http://posixtest.sourceforge.net/testpass.html> for test results.

I created a timerstress program to test 1000s of active timers.
I ran it on Linux 2.5.59 with George's HRT patch, with profile=4
(in-kernel profiling) on a dual P4 1.7 GHz PC with 1 GB of RAM.

All stress tests were run for 60 seconds, with random initial timeout
and interval per timer (initial timeout == interval).
Currently all timers are relative in time, not absolute.
The timerstress test uses one POSIX real-time signal and no other
threads/processes, so this isn't a timer + threads test, just a
timers/signals test.

As you can see in the following table, the high-res-timers code is not
taking unusual amounts of processor time, although the system call
overhead from the timer stress test program is high.


Timers	Expirations/60 seconds	Avg/second	Syscall 'load' (profile)
==============================================================================
1000		2505		41.75			5.20
2000		4852		80.87			5.18
3000		7175		119.58			5.68
4000		9588		159.8			8.66
5000		12026		200.43			9.68
6000		14284		238.07			8.89
7000		16669		277.82			12.59
8000		19134		318.9			9.84
9000		21597		359.95			14.41
10000		24288		404.8			11.55
12000		28812		480.2			11.41
14000		33606		560.1			28.16
16000		38680		644.67			18.11


Stress testing of Jim's alternate HRT patch is currently on hold.

###
