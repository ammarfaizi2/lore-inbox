Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVHUJeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVHUJeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVHUJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:34:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750900AbVHUJeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:34:16 -0400
Date: Sun, 21 Aug 2005 02:32:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050821023249.0e143030.akpm@osdl.org>
In-Reply-To: <430848F5.3040308@yahoo.com.au>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
	<20050821021616.6bbf2a14.akpm@osdl.org>
	<430848F5.3040308@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> >>How about we give each arch a printk_clock()?
> > 
> > 
> > Which might be as simple as this..
> > 
> > 
> 
> sched_clock() shouldn't really be taken outside kernel/sched.c,
> especially for things like this.
> 
> It actually has some fundamental problems even in its current
> use in the scheduler (which need to be fixed). But basically it
> is a very nasty interface with a rather tenuous relationship to
> time.

yup.

> Why not use something like do_gettimeofday? (or I'm sure one
> of our time keepers can suggest the right thing to use).

do_gettimeofday() takes locks, so a) we can't do printk from inside it and
b) if you do a printk-from-interupt and the interrupted code was running
do_gettimeofday(), deadlock.
