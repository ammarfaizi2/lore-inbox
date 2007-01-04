Return-Path: <linux-kernel-owner+w=401wt.eu-S932204AbXADAMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXADAMd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbXADAMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:12:33 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:34848
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbXADAMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:12:32 -0500
Date: Wed, 3 Jan 2007 16:12:26 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104001225.GA31434@gnuppy.monkey.org>
References: <20070103074124.GA25594@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C01A4FB27@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C01A4FB27@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 03:59:28PM -0800, Chen, Tim C wrote:
> Bill Huey (hui) wrote:
> http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.2.lock_stat.patch
> 
> This version is much better and ran stablely.  
> 
> If I'm reading the output correctly, the locks are listed by 
> their initialization point (function, file and line # that a lock is
> initialized).  
> That's good information to identify the lock.  

Yes, that's correct.

Good to know that. What did the output reveal ?

It can be extended by pid/futex for userspace app that has yet to be done.
It might require changes to glibc or a some kind of dynamic tracing to
communicate to kernel space information about that lock. There are other
kernel uses as well. It's just a basic mechanisms for a variety of uses.
This patch has some LTT and Dtrace-isms to it.

What's your intended use again summarized ? futex contention ? I'll read
the first posting again.

> However, it will be more useful if there is information about where the
> locking
> was initiated from and who was trying to obtain the lock.

It would add quite a bit more overhead, but it could be done with lockdep
directly I believe in conjunction with this patch. However, it should be
specific enough though that a kernel code examination at the key points
of all users of the lock would show where the problem places are as well
as users.

bill

