Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUEGCw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUEGCw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 22:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUEGCw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 22:52:57 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:64679 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262499AbUEGCww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 22:52:52 -0400
Message-ID: <20040507025252.38914.qmail@web14929.mail.yahoo.com>
Date: Thu, 6 May 2004 19:52:52 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Is it possible to implement interrupt time printk's reliably?
To: lkml <linux-kernel@vger.kernel.org>
Cc: Keith Packard <keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
1) Some operations on graphics cards cannot be stopped once they are started.
It's not reasonable to turn interrupts off around these operations.
2) Kernel developers want console printk's to work from interrupt routines.

How do you fix this situation?

1) Grpahics driver has started non-restartable operation. For example
transferring a bitmap. This is not an automatic DMA operation, CPU involvement
is needed.
2) Interrupt happens
3) Printk happens from interrupt.

Now we're stuck. The graphics chip is in a non-interruptible state and printk
wants to use it.

We need some mechanism to get back to the driver code and finish the
non-restartable operation before the printk can be allowed to proceed.

Another solution also comes to mind. Mark the appropriate sections in the video
driver with BEGIN/END_INT_PRINTK. Then add a kernel build option to convert
these macros to en/disable interrupts if interrupt time printk's are allowed.
Would it be acceptable to disable interrupts for signifcant time on a
development kernel where the developer is printk'ing from interrupts?


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
