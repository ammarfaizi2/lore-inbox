Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVGKCdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVGKCdU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVGKCdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 22:33:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29622 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262193AbVGKCdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 22:33:19 -0400
Date: Mon, 11 Jul 2005 04:32:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050711023252.GA31591@elte.hu>
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel> <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel> <p73ll4f29m7.fsf@verdi.suse.de> <20050709194220.GA20791@elte.hu> <20050710161358.GE9068@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710161358.GE9068@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Sat, Jul 09, 2005 at 09:42:20PM +0200, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > > Ingo Molnar <mingo@elte.hu> writes:
> > > >  
> > > > +static void force_sig_info_fault(int si_signo, int si_code,
> > > > +				 unsigned long address, struct task_struct *tsk)
> > > 
> > > This won't work with a unit-at-a-time compiler which happily inlines 
> > > everything static with only a single caller. Use noinline
> > 
> > this function has two callers.
> 
> Even then it's still better to mark it noinline, otherwise a different 
> inlining algorithm in a new compiler might do the wrong thing.  It's 
> also useful documentation.

ok, agreed. Delta patch below.

	Ingo

----
make force_sig_info_fault() noinline, suggested by Andi Kleen.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/fault.c.orig
+++ linux/arch/i386/mm/fault.c
@@ -199,8 +199,8 @@ static inline int is_prefetch(struct pt_
 	return 0;
 } 
 
-static void force_sig_info_fault(int si_signo, int si_code,
-				 unsigned long address, struct task_struct *tsk)
+static noinline void force_sig_info_fault(int si_signo, int si_code,
+	unsigned long address, struct task_struct *tsk)
 {
 	siginfo_t info;
 
