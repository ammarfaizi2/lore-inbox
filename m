Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVACNeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVACNeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVACNep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:34:45 -0500
Received: from miranda.se.axis.com ([193.13.178.2]:41885 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261443AbVACNe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:34:28 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
       "Mikael Starvik" <mikael.starvik@axis.com>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remove bogus double softirq processing in cris
Date: Mon, 3 Jan 2005 14:34:07 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C75F3@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66802055E59@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Go ahead and submit it. This was removed locally quite a while ago and I'm
rewriting the IRQ handling to use the new consolidate IRQ stuff in 2.6.10 as
I write this. So don't bother that your patch breaks CRIS in the current 2.6
tree. 

/Mikael

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Monday, January 03, 2005 2:28 PM
To: Mikael Starvik; akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove bogus double softirq processing in cris


On Sun, Nov 14, 2004 at 11:43:28AM +0100, Christoph Hellwig wrote:
> I sent this out long ago already, but it's still not in:
> 
>   These days irq_exit does all softirq processing, so there's no need to
>   call do_softirq again in cris.
> 
> Also is there any chance you could switch cris to use the new
> CONFIG_GENERIC_HARDIRQS code in 2.6.10-rc that would replace most of
> arch/cris/kernel/irq.c with generic code from kernel/irq/* ?

ping?  the broken code this patch removes really gets in the way of the
softirq_pending() removal I plan to submit soon..

--- 1.17/arch/cris/kernel/irq.c	2004-10-20 10:37:14 +02:00
+++ edited/arch/cris/kernel/irq.c	2004-11-14 11:39:14 +01:00
@@ -158,11 +158,6 @@ asmlinkage void do_IRQ(int irq, struct p
 		local_irq_disable();
         }
         irq_exit();
-
-	if (softirq_pending(cpu))
-                do_softirq();
-
-        /* unmasking and bottom half handling is done magically for us. */
 }
 
 /* this function links in a handler into the chain of handlers for the

