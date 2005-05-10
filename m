Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVEJCXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEJCXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEJCXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:23:52 -0400
Received: from mx.freeshell.org ([192.94.73.21]:37607 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261460AbVEJCXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:23:48 -0400
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Tue, 10 May 2005 02:23:01 +0000
To: Bill Davidsen <davidsen@tmr.com>
Cc: Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050510022301.GA13763@SDF.LONESTAR.ORG>
References: <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427FA876.7000401@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon Bill,

Thanks for the input.  Let me make a couple of comments.

On Mon, May 09, 2005 at 02:14:14PM -0400, Bill Davidsen wrote:

> Might I suggest that if you like the "we know best just trust us" 
> approach, there is another OS to use. Making information available to 
> good applications will improve system performance, or at least allow 
> better limitation of requests for resources, and bad applications will 
> be bad regardless of what you hide. You don't hide the CPU hardware any 
> more than the memory size.

You could use a similar argument for cooperative rather than
preemptive multitasking.  It might even be a valid argument,
assuming you controlled all the processes running on the system.
But it didn't work very well in practice.

I see two problems with encouraging applications to get involved
with processor selection.

The first is they don't have enough information to get it right.
There are going to be other processes running on the machine.
The optimal set of processors to run on is going to depend on
what else is running and what it is doing at that instant.  This
isn't information a usermode process has good access to.  Say I
have an application that wants to bind its 2 threads to the two
processors on a single SMT chip.  Now say I run two of these
applications on a machine with 2 SMT chips on it.  What keeps
both of them from binding themselves to the same chip?  Should
it be the applications responsibility to look through the process
table and see what other applicatioins are bound to what processors?
What prevents races if they do?


The second is that once you give userland an interface, it becomes
very difficult to remove it once it no longer makes sense.  See
the thread on this mailing list concerning the C/H/S values returned
for disk drives as an example.  Having to support a particular interface
may make it impossible to add improvements we want to add in the
future.  For example, if at some point in the future we come up with 
a really great scheduling algorithm, it won't help if the programs
have already bound themselvs to particular processors.

Now I know there are exceptions to rules.  But in general I would say
that if an application needs to know about the configuration of the
processors, then its compensating for shortcommings in the kernel.

Thanks,

Jim

-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
