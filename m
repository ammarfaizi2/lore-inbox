Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132265AbRAASoo>; Mon, 1 Jan 2001 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132230AbRAASoe>; Mon, 1 Jan 2001 13:44:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132265AbRAASoY>; Mon, 1 Jan 2001 13:44:24 -0500
Date: Mon, 1 Jan 2001 10:13:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10101011011350.2892-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andre, what's the idea behind the following change:

--- linux-2.4.0-prerelease-pristine/drivers/ide/ide-features.c  Mon Oct 16 12:21:40 2000
+++ linux-2.4.0-prerelease/drivers/ide/ide-features.c   Sun Dec 31 21:53:17 2000
@@ -224,7 +224,7 @@
 #ifndef CONFIG_IDEDMA_IVB
                if ((drive->id->hw_config & 0x6000) == 0) {
 #else /* !CONFIG_IDEDMA_IVB */
-               if (((drive->id->hw_config & 0x2000) == 0) ||
+               if (((drive->id->hw_config & 0x2000) == 0) &&
                    ((drive->id->hw_config & 0x4000) == 0)) {
 #endif /* CONFIG_IDEDMA_IVB */
                        printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);

as it apparently makes CONFIG_IDEDMA_IVB a complete no-op?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
