Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWHCQxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHCQxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWHCQxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:53:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:60905 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932085AbWHCQxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:53:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nJuPwnkH1aIWC4uC10+B6IqYPp3e6hb55GbRGjJf2nhxs8NJDFBEFfT9Sj3gCdWh1wdAli7Gq+v9sDiGTF+jr/CDwqcsznzvoH+Obf6bpfTo7WhU76ChO6IhW+UezBtP7qyaNrAIDD7OJlX/pgU/wA7GpuBP76FoXnFY3adRyq4=
Message-ID: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
Date: Thu, 3 Aug 2006 19:53:33 +0300
From: "Jukka Partanen" <jspartanen@gmail.com>
To: kkeil@suse.de
Subject: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
(they are there in 2.6.17.7 too), to fix module initialization
problems appearing with at least some newer Celerons and
Pentium III.

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
