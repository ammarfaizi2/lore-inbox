Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVACN2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVACN2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVACN2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:28:11 -0500
Received: from verein.lst.de ([213.95.11.210]:48790 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261445AbVACN16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:27:58 -0500
Date: Mon, 3 Jan 2005 14:27:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: mikael.starvik@axis.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove bogus double softirq processing in cris
Message-ID: <20050103132748.GA22372@lst.de>
References: <20041114104327.GA32182@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114104327.GA32182@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
