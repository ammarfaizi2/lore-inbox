Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbUKXPqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUKXPqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXPp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:45:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42400 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262764AbUKXPnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:43:32 -0500
Date: Wed, 24 Nov 2004 07:32:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 31/51: Export tlb flushing
Message-ID: <181630000.1101310366@[10.10.2.4]>
In-Reply-To: <1101297506.5805.314.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101297506.5805.314.camel@desktop.cunninghams>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Nigel Cunningham <ncunningham@linuxmail.org> wrote (on Wednesday, November 24, 2004 23:59:50 +1100):

> This patch adds a do_flush_tlb_all function that does the
> SMP-appropriate thing for suspend after the image is restored.

Is software suspend only designed for i386, or is that the only arch that 
didn't have such a function already? Seems like too low a level to be 
exporting to me.

M.
 
> diff -ruN 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c
> --- 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c	2004-11-06 09:27:19.225681536 +1100
> +++ 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c	2004-11-04 16:27:41.000000000 +1100
> @@ -476,7 +476,7 @@
>  	preempt_enable();
>  }
>  
> -static void do_flush_tlb_all(void* info)
> +void do_flush_tlb_all(void* info)
>  {
>  	unsigned long cpu = smp_processor_id();
>  
> diff -ruN 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h
> --- 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h	2004-11-03 21:55:01.000000000 +1100
> +++ 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h	2004-11-04 16:27:41.000000000 +1100
> @@ -82,6 +82,7 @@
>  #define flush_tlb() __flush_tlb()
>  #define flush_tlb_all() __flush_tlb_all()
>  #define local_flush_tlb() __flush_tlb()
> +#define local_flush_tlb_all() __flush_tlb_all();
>  
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
> @@ -114,6 +115,10 @@
>  extern void flush_tlb_current_task(void);
>  extern void flush_tlb_mm(struct mm_struct *);
>  extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
> +extern void do_flush_tlb_all(void * info);
> +
> +#define local_flush_tlb_all() \
> +	do_flush_tlb_all(NULL);
>  
>  #define flush_tlb()	flush_tlb_current_task()
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


