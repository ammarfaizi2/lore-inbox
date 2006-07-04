Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWGDV7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWGDV7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGDV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:59:40 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:3778 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932308AbWGDV7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:59:39 -0400
Date: Tue, 4 Jul 2006 14:51:17 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704215117.GC7078@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607041719_MC3-1-C420-EC5A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607041719_MC3-1-C420-EC5A@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Tue, Jul 04, 2006 at 05:19:02PM -0400, Chuck Ebbert wrote:
> 
> > +	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP) == 0) {
> 
> preferred:
> 
> 	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
> 
Ok, I will fix that.

> And this should be added to the patch:
> 
> --- 2.6.17-nb.orig/arch/i386/kernel/process.c
> +++ 2.6.17-nb/arch/i386/kernel/process.c
> @@ -360,13 +360,12 @@ EXPORT_SYMBOL(kernel_thread);
>   */
>  void exit_thread(void)
>  {
> -	struct task_struct *tsk = current;
> -	struct thread_struct *t = &tsk->thread;
> -
>  	/* The process may have allocated an io port bitmap... nuke it. */
> -	if (unlikely(NULL != t->io_bitmap_ptr)) {
> +	if (unlikely(test_thread_flag(TIF_IO_BITMAP))) {
>  		int cpu = get_cpu();
>  		struct tss_struct *tss = &per_cpu(init_tss, cpu);
> +		struct task_struct *tsk = current;
> +		struct thread_struct *t = &tsk->thread;
>  
>  		kfree(t->io_bitmap_ptr);
>  		t->io_bitmap_ptr = NULL;

Yes, I missed that test. Thanks for catching it.

-- 

-Stephane
