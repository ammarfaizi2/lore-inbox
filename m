Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTG1NAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTG1NAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:00:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9116 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267576AbTG1NAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:00:10 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 28 Jul 2003 15:15:24 +0200 (MEST)
Message-Id: <UTC200307281315.h6SDFOY08368.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, gtoumi@laposte.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.6.0-test1 on alpha : disk label numbering trouble
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: "Ghozlane Toumi" <gtoumi@laposte.net>

	> > I'm trying to run 2.6.0-test1 on an alpha box, 
	> > and  apparently, the osf partition numbering is wrong:

	2.4:
	 sda: sda3 sda4 sda5

	2.6:
	 sda: sda1 sda2 sda3

OK, I see what happened - viro changed things a little,
maybe by mistake.

I suppose the below will give you your original numbering again.
(Please confirm.)

Andries

--- osf.c~	Wed Mar  5 04:29:32 2003
+++ osf.c	Mon Jul 28 16:13:03 2003
@@ -67,9 +67,10 @@
 		if (slot == state->limit)
 		        break;
 		if (le32_to_cpu(partition->p_size))
-			put_partition(state, slot++,
+			put_partition(state, slot,
 				le32_to_cpu(partition->p_offset),
 				le32_to_cpu(partition->p_size));
+		slot++;
 	}
 	printk("\n");
 	put_dev_sector(sect);
