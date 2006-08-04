Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWHDVKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWHDVKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWHDVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:10:22 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:45983
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1161466AbWHDVKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:10:20 -0400
Date: Fri, 4 Aug 2006 14:10:11 -0700
To: Darren Hart <dvhltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG -rt] Double OOPs - thread_info free race / printk recursive lock
Message-ID: <20060804211011.GA20342@gnuppy.monkey.org>
References: <200608041043.06446.dvhltc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608041043.06446.dvhltc@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:43:05AM -0700, Darren Hart wrote:
> We've seen very rarely over the last few months, on various -rt kernels.  The 
> latest reproduction is on 2.6.16-rt22 (+some minor fixups).  Analysis of the 
> vmcore produced by kdump suggests two problems: 
> 1) An invalid pointer dereference in cache_flusharray() which causes the page
> fault.  

My guess is that this is after some bogus stuff going on after the real event.

> 2) Then printk calls kmalloc when trying to print the oops, which grabs a
> recursive lock and prints a different oops.  

Can't say for sure, but this sounds a lot like the problem I've been dealing
with in free_task(). The stack trace is pretty contorted and it's been difficult
to unwind it in any meaningful manner, although I'm making progress.  Writing
some tools to deal with this now.

bill

