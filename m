Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVKXRsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVKXRsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKXRsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:48:32 -0500
Received: from nm02mta.dion.ne.jp ([61.117.3.75]:44557 "HELO
	nm02omta026.dion.ne.jp") by vger.kernel.org with SMTP
	id S932432AbVKXRsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:48:32 -0500
Date: Fri, 25 Nov 2005 02:49:19 +0900
From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] fix to clock running too fast
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051124144613.GC1060@elte.hu>
References: <20051123035256.684C.AKIRA-T@s9.dion.ne.jp> <20051124144613.GC1060@elte.hu>
Message-Id: <20051125024530.88F8.AKIRA-T@s9.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar <mingo@elte.hu> mentioned:
> 
> * Akira Tsukamoto <akira-t@s9.dion.ne.jp> wrote:
> 
> > This one line patch adds upper bound testing inside timer_irq_works() 
> > when evaluating whether irq timer works or not on boot up.
> > 
> > It fix the machines having problem with clock running too fast.
> > 
> > What this patch do is, if  timer interrupts running too fast through 
> > IO-APIC IRQ then false back to i8259A IRQ.
> 
> thanks - looks good to me.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> 	Ingo

Thanks,
I regenerated my patch to the latest kernel.

Signed-off-by: Akira Tsukamoto <akira-t@s9.dion.ne.jp>

--- linux-2.6.15-rc2-atiix/arch/i386/kernel/io_apic.c.orig	2005-11-20 12:25:03.000000000 +0900
+++ linux-2.6.15-rc2-atiix/arch/i386/kernel/io_apic.c	2005-11-25 02:43:40.000000000 +0900
@@ -1877,7 +1877,7 @@ static int __init timer_irq_works(void)
 	 * might have cached one ExtINT interrupt.  Finally, at
 	 * least one tick may be lost due to delays.
 	 */
-	if (jiffies - t1 > 4)
+	if (jiffies - t1 > 4 && jiffies - t1 < 16)
 		return 1;
 
 	return 0;




-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <>


