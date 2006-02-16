Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWBPDSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWBPDSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBPDSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:18:30 -0500
Received: from ozlabs.org ([203.10.76.45]:25270 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751376AbWBPDS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:18:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.61187.693245.267767@cargo.ozlabs.ibm.com>
Date: Thu, 16 Feb 2006 14:18:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick
 length
In-Reply-To: <20060215191146.126c052d.akpm@osdl.org>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
	<20060215173545.43a7412d.akpm@osdl.org>
	<17395.56186.238204.312647@cargo.ozlabs.ibm.com>
	<20060215180848.4556e501.akpm@osdl.org>
	<17395.59762.126398.423546@cargo.ozlabs.ibm.com>
	<20060215191146.126c052d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Is that enough to be worth factoring out?  Note that
> > update_wall_time_one_tick() needs both time_adjust_step and
> > delta_nsec, so to share more, we would have to have a function
> > returning two values and it would start to get ugly.
> > 
> 
> update_wall_time_one_tick() gets:
> 
> 	long delta_nsec = new_function();
> 
> and your new function becomes
> 
> 	return (u64)new_function() << (SHIFT_SCALE - 10)) + time_adj;

and update_wall_time_one_tick misses out on this bit:

		/* Reduce by this step the amount of time left  */
		time_adjust -= time_adjust_step;

That's why I said that update_wall_time_one_tick needs both
time_adjust_step and delta_nsec.  If you have a nice way to return
both values, please let me know...

Paul.
