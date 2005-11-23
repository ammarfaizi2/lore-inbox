Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKWM5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKWM5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKWM5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:57:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:57323 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750762AbVKWM5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:57:14 -0500
Date: Wed, 23 Nov 2005 18:24:40 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051123125440.GE22714@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu> <Pine.LNX.4.58.0511230727330.23751@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511230727330.23751@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 07:35:04AM -0500, Steven Rostedt wrote:
> 
> On Wed, 23 Nov 2005, Ingo Molnar wrote:
> 
> >
> > note that Steven has a dual-core Athlon64 X2 system. Steven, do you get
> > the crash even with maxcpus=1?
> >
> 
> Actually Ingo,  this happened on my UP test machine, a 368MHz Pentium.
> 
> But unfortunately, it so far only happened once, and I've been trying to
> recreate it, with no success.  The test that crashed it was running 10
> tasks that would read the entire filesystem. I was debugging another bug
> (something specific to my kernel, or maybe -rt) when I hit this bug.
> Looking at it, it seemed to not be related to the changes I made.  Perhaps
> it could be related to your changes?
> 


I normally test the sysfs races by running these two loops simultenously
on a SMP box. Basically running these will create/delete sysfs files and
directories and also do readdir. 

 while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
 while true; do find /sys/class/net/dummy0/ | xargs cat > /dev/null; done


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
