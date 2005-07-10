Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVGJQOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVGJQOF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVGJQOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 12:14:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:63618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261968AbVGJQOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 12:14:00 -0400
Date: Sun, 10 Jul 2005 18:13:58 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050710161358.GE9068@wotan.suse.de>
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel> <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel> <p73ll4f29m7.fsf@verdi.suse.de> <20050709194220.GA20791@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709194220.GA20791@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 09:42:20PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Ingo Molnar <mingo@elte.hu> writes:
> > >  
> > > +static void force_sig_info_fault(int si_signo, int si_code,
> > > +				 unsigned long address, struct task_struct *tsk)
> > 
> > This won't work with a unit-at-a-time compiler which happily inlines 
> > everything static with only a single caller. Use noinline
> 
> this function has two callers.

Even then it's still better to mark it noinline, otherwise
a different inlining algorithm in a new compiler might do the wrong
thing.  It's also useful documentation.

-Andi
