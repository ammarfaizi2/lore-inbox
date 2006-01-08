Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWAHArN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWAHArN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWAHArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:47:13 -0500
Received: from colo.lackof.org ([198.49.126.79]:13546 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1161111AbWAHArM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:47:12 -0500
Subject: [PATCH] CONFIG_AIRO needs CONFIG_CRYPTO
From: dann frazier <dannf@dannf.org>
To: linux-kernel@vger.kernel.org
Cc: 344205@bugs.debian.org, Roland Mas <lolando@debian.org>
In-Reply-To: <877j9cfc4q.fsf@mirexpress.internal.placard.fr.eu.org>
References: <20051220211944.19259.91642.reportbug@mirexpress.internal.placard.fr.eu.org>
	 <87irt1vz4o.fsf@mirexpress.internal.placard.fr.eu.org>
	 <1136588604.16769.55.camel@krebs.dannf>
	 <877j9cfc4q.fsf@mirexpress.internal.placard.fr.eu.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 17:47:14 -0700
Message-Id: <1136681234.11955.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

airo.c currently has MICSUPPORT enabled, which requires CONFIG_CRYPTO.
A user reported a build failure which is due to the lack of a Kconfig
dependency.  See http://bugs.debian.org/344205.

This patch makes Kconfig enforce this dependency.

Signed-off-by: dann frazier <dannf@debian.org>

--- linux-source-2.6.15/drivers/net/wireless/Kconfig~	2006-01-02 20:21:10.000000000 -0700
+++ linux-source-2.6.15/drivers/net/wireless/Kconfig	2006-01-07 17:27:41.000000000 -0700
@@ -243,7 +243,7 @@
 
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
-	depends on NET_RADIO && ISA_DMA_API && (PCI || BROKEN)
+	depends on NET_RADIO && ISA_DMA_API && CRYPTO && (PCI || BROKEN)
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet ISA and
 	  PCI 802.11 wireless cards.


