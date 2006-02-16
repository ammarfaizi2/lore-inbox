Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWBPDM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWBPDM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBPDM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:12:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWBPDM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:12:56 -0500
Date: Wed, 15 Feb 2006 19:11:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick
 length
Message-Id: <20060215191146.126c052d.akpm@osdl.org>
In-Reply-To: <17395.59762.126398.423546@cargo.ozlabs.ibm.com>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
	<20060215173545.43a7412d.akpm@osdl.org>
	<17395.56186.238204.312647@cargo.ozlabs.ibm.com>
	<20060215180848.4556e501.akpm@osdl.org>
	<17395.59762.126398.423546@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> > Can we share that code?
> 
> We could share the code that computes time_adjust_step, i.e. this
> much:
> 
> 	if ((time_adjust_step = time_adjust) != 0) {
> 		/*
> 		 * We are doing an adjtime thing.  Prepare time_adjust_step to
> 		 * be within bounds.  Note that a positive time_adjust means we
> 		 * want the clock to run faster.
> 		 *
> 		 * Limit the amount of the step to be in the range
> 		 * -tickadj .. +tickadj
> 		 */
> 		time_adjust_step = min(time_adjust_step, (long)tickadj);
> 		time_adjust_step = max(time_adjust_step, (long)-tickadj);
> 	}
>

And the next line!

> Is that enough to be worth factoring out?  Note that
> update_wall_time_one_tick() needs both time_adjust_step and
> delta_nsec, so to share more, we would have to have a function
> returning two values and it would start to get ugly.
> 

update_wall_time_one_tick() gets:

	long delta_nsec = new_function();

and your new function becomes

	return (u64)new_function() << (SHIFT_SCALE - 10)) + time_adj;


