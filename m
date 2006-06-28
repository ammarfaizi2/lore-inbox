Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWF1HHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWF1HHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWF1HHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:07:04 -0400
Received: from www.osadl.org ([213.239.205.134]:25047 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932604AbWF1HHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:07:01 -0400
Subject: Re: 2.6.17-mm3: arm: *_irq_wake compile error
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, rmk@arm.linux.org.uk
In-Reply-To: <20060627224038.GF13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
	 <20060627224038.GF13915@stusta.de>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 09:09:04 +0200
Message-Id: <1151478544.25491.485.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 00:40 +0200, Adrian Bunk wrote:
> genirq-add-irq-wake-power-management-support.patch causes the following 
> compile error on arm:
> 
> <--  snip  -->
> 
> ...
>   CC      init/main.o
> In file included from include/linux/rtc.h:102,
>                  from include/linux/efi.h:19,
>                  from init/main.c:47:
> include/linux/interrupt.h:108: error: conflicting types for 'enable_irq_wake'
> include/asm/irq.h:47: error: previous declaration of 'enable_irq_wake' was here
> include/linux/interrupt.h:113: error: conflicting types for 'disable_irq_wake'
> include/asm/irq.h:46: error: previous declaration of 'disable_irq_wake' was here
> make[1]: *** [init/main.o] Error 1

Thats a mismerge with LOCKDEP

This section was originally inside #ifdef CONFIG_GENERIC_HARDIRQS

/* IRQ wakeup (PM) control: */
extern int set_irq_wake(unsigned int irq, unsigned int on);

static inline int enable_irq_wake(unsigned int irq)
{
        return set_irq_wake(irq, 1);
}

static inline int disable_irq_wake(unsigned int irq)
{
        return set_irq_wake(irq, 0);
}

The patch is:

lockdep-add-disable-enable_irq_lockdep-api.patch

	tglx


