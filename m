Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWHCRbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWHCRbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWHCRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:31:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:63975 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964808AbWHCRbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:31:06 -0400
Date: Thu, 3 Aug 2006 19:31:04 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jukka Partanen <jspartanen@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Message-ID: <20060803173104.GA22317@pingi.kke.suse.de>
Mail-Followup-To: Jukka Partanen <jspartanen@gmail.com>,
	linux-kernel@vger.kernel.org
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.13-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that should be go in.

AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
(they are there in 2.6.17.7 too), to fix module initialization
problems appearing with at least some newer Celerons and
Pentium III.

Acked-by: Karsten Keil <kkeil@suse.de>
Signed-off-by: Jukka Partanen <jspartanen@gmail.com>

--- drivers/isdn/avmb1/c4.c.orig	2006-08-03 19:32:17.000000000 +0000
+++ drivers/isdn/avmb1/c4.c	2006-08-03 19:32:55.000000000 +0000
@@ -151,6 +151,7 @@
 	while (c4inmeml(card->mbase+DOORBELL) != 0xffffffff) {
 		if (!time_before(jiffies, stop))
 			return -1;
+		mb();
 	}
 	return 0;
 }
@@ -305,6 +306,7 @@
 		if (!time_before(jiffies, stop))
 			return;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
+		mb();
 	}

 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);
@@ -328,6 +330,7 @@
 		if (!time_before(jiffies, stop))
 			return 2;
 		c4outmeml(card->mbase+DOORBELL, DBELL_ADDR);
+		mb();
 	}

 	c4_poke(card, DC21285_ARMCSR_BASE + CHAN_1_CONTROL, 0);

-- 
Karsten Keil
SuSE Labs
ISDN development
