Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280749AbRKJWzS>; Sat, 10 Nov 2001 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKJWzI>; Sat, 10 Nov 2001 17:55:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19980 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280749AbRKJWy6>;
	Sat, 10 Nov 2001 17:54:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] final cur of tr based current for -ac8 
In-Reply-To: Your message of "Sat, 10 Nov 2001 17:33:31 CDT."
             <20011110173331.F17437@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Nov 2001 09:54:48 +1100
Message-ID: <23114.1005432888@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001 17:33:31 -0500, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c v2.4.13-ac8+tr.4/arch/i386/kernel/nmi.c
>--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c	Tue Nov  6 20:43:22 2001
>+++ v2.4.13-ac8+tr.4/arch/i386/kernel/nmi.c	Sat Nov 10 14:00:33 2001
>@@ -264,7 +264,7 @@
> 	/*
> 	 * NMI can interrupt page faults, use hard_get_current.
> 	 */
>-	int sum, cpu = hard_get_current()->processor;
>+	int sum, cpu = hard_smp_processor_id();
> 
> 	sum = apic_timer_irqs[cpu];

I am still unhappy with that NMI code.  The NMI handler can use generic
code including printk, the generic code will use the standard
get_current.  Why does nmi.c not do set_current(hard_get_current());

