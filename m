Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbUKYBK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbUKYBK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUKYBK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:10:28 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:13709 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262878AbUKYBIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:08:41 -0500
Subject: Re: Suspend 2 merge: 31/51: Export tlb flushing
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <181630000.1101310366@[10.10.2.4]>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101297506.5805.314.camel@desktop.cunninghams>
	 <181630000.1101310366@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1101330297.3895.22.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:04:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 02:32, Martin J. Bligh wrote:
> --Nigel Cunningham <ncunningham@linuxmail.org> wrote (on Wednesday, November 24, 2004 23:59:50 +1100):
> 
> > This patch adds a do_flush_tlb_all function that does the
> > SMP-appropriate thing for suspend after the image is restored.
> 
> Is software suspend only designed for i386, or is that the only arch that 
> didn't have such a function already? Seems like too low a level to be 
> exporting to me.

There's lowlevel code for x86 and ppc at the moment, more arch specific
code can be added. This function is used from the x86 restoration of the
original kernel (arch/i386/power/suspend2.c).

Regards,

Nigel

> M.
>  
> > diff -ruN 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c
> > --- 818-tlb-flushing-functions-old/arch/i386/kernel/smp.c	2004-11-06 09:27:19.225681536 +1100
> > +++ 818-tlb-flushing-functions-new/arch/i386/kernel/smp.c	2004-11-04 16:27:41.000000000 +1100
> > @@ -476,7 +476,7 @@
> >  	preempt_enable();
> >  }
> >  
> > -static void do_flush_tlb_all(void* info)
> > +void do_flush_tlb_all(void* info)
> >  {
> >  	unsigned long cpu = smp_processor_id();
> >  
> > diff -ruN 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h
> > --- 818-tlb-flushing-functions-old/include/asm-i386/tlbflush.h	2004-11-03 21:55:01.000000000 +1100
> > +++ 818-tlb-flushing-functions-new/include/asm-i386/tlbflush.h	2004-11-04 16:27:41.000000000 +1100
> > @@ -82,6 +82,7 @@
> >  #define flush_tlb() __flush_tlb()
> >  #define flush_tlb_all() __flush_tlb_all()
> >  #define local_flush_tlb() __flush_tlb()
> > +#define local_flush_tlb_all() __flush_tlb_all();
> >  
> >  static inline void flush_tlb_mm(struct mm_struct *mm)
> >  {
> > @@ -114,6 +115,10 @@
> >  extern void flush_tlb_current_task(void);
> >  extern void flush_tlb_mm(struct mm_struct *);
> >  extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
> > +extern void do_flush_tlb_all(void * info);
> > +
> > +#define local_flush_tlb_all() \
> > +	do_flush_tlb_all(NULL);
> >  
> >  #define flush_tlb()	flush_tlb_current_task()
> >  
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

