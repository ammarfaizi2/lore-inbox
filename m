Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSHYOZx>; Sun, 25 Aug 2002 10:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHYOZx>; Sun, 25 Aug 2002 10:25:53 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:31243 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316569AbSHYOZw>; Sun, 25 Aug 2002 10:25:52 -0400
Date: Sun, 25 Aug 2002 15:30:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  apm cannot be compiled as a module in 2.5.31
Message-ID: <20020825153004.A7730@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter T. Breuer" <ptb@it.uc3m.es>, linux-kernel@vger.kernel.org
References: <200208251321.g7PDL9v09118@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208251321.g7PDL9v09118@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Sun, Aug 25, 2002 at 03:21:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 03:21:09PM +0200, Peter T. Breuer wrote:
> --- kernel/ksyms.c.orig	Sun Aug 25 15:15:02 2002
> +++ kernel/ksyms.c	Thu Aug 22 19:11:07 2002
> @@ -428,6 +428,10 @@
>  EXPORT_SYMBOL(__br_write_unlock);
>  #endif
>  
> +#ifdef CONFIG_X86
> +EXPORT_SYMBOL(cpu_gdt_table);
> +#endif

I think arch/i386/kernel/i386_ksysm.c is a better place for this

> Hurrr .. the xtime_lock is harder. Have to EXPORT from the file where
> it is defined. Locks only make sense in SMP so only export if compiled
> for SMP.
> 
> 
> --- kernel/timer.c.orig	Sun Aug 25 15:17:09 2002
> +++ kernel/timer.c	Thu Aug 22 19:13:15 2002
> @@ -635,6 +635,9 @@
>   * playing with xtime and avenrun.
>   */
>  rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
> +#ifdef CONFIG_SMP
> +EXPORT_SYMBOL(xtime_lock);
> +#endif

you could aswell include the matching header in ksyms.c..

