Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVAYVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVAYVlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVAYVkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:40:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31642
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262174AbVAYVjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:39:47 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <3f250c7105012513136ae2587e@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 22:39:39 +0100
Message-Id: <1106689179.4538.22.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 17:13 -0400, Mauricio Lin wrote:
> Hi Andrea,
> 
> Your OOM Killer patch was tested and a strange behaviour was found.
> Basically as normal user we started some applications as openoffice,
> mozilla and emacs.
> And as a root (in another tty) we started a simple program that uses
> malloc in a forever loop as below:
> 
> int main (void)
> {
>   int * mem;
>   for (;;)
>         mem = (int *) malloc(sizeof(int));
>   return 0;
> }
> 
> 
> Using the original OOM Killer, malloc is the first killed application
> and the sytem is restored in a useful state. After applying your patch
> and accomplish the same experiment, the OOM Killer it does not kill
> malloc program and it enters in a kind of forever loop as below:
> 
> 1) out_of_memory is invoked;
> 2) select_bad_process is invoked;

Which process is selected ?

> 3) the following condition is fullfied;
> if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags &
> PF_EXITING)) &&
> 			    !(p->flags & PF_DEAD))
> 				return ERR_PTR(-1UL);

???

Can you please show the kernel messages ?

tglx


