Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbVKXR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVKXR7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVKXR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:59:18 -0500
Received: from nm02mta.dion.ne.jp ([61.117.3.75]:12305 "HELO
	nm02omta026.dion.ne.jp") by vger.kernel.org with SMTP
	id S932639AbVKXR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:59:17 -0500
Date: Fri, 25 Nov 2005 03:00:05 +0900
From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2.4] fix for clock running too fast
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20051124144613.GC1060@elte.hu>
References: <20051123035256.684C.AKIRA-T@s9.dion.ne.jp> <20051124144613.GC1060@elte.hu>
Message-Id: <20051125025617.88FE.AKIRA-T@s9.dion.ne.jp>
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

This patch is against kernel 2.4.

Signed-off-by: Akira Tsukamoto <akira-t@s9.dion.ne.jp>

--- linux-2.4.32-atifix/arch/i386/kernel/io_apic.c.orig	2004-11-17 20:54:21.000000000 +0900
+++ linux-2.4.32-atifix/arch/i386/kernel/io_apic.c	2005-11-25 02:27:32.000000000 +0900
@@ -1194,7 +1194,7 @@ static int __init timer_irq_works(void)
 	 * might have cached one ExtINT interrupt.  Finally, at
 	 * least one tick may be lost due to delays.
 	 */
-	if (jiffies - t1 > 4)
+	if (jiffies - t1 > 4 && jiffies - t1 < 16)
 		return 1;
 
 	return 0;



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <>


