Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSBZPCL>; Tue, 26 Feb 2002 10:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBZPCB>; Tue, 26 Feb 2002 10:02:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284933AbSBZPBk> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 10:01:40 -0500
Date: Tue, 26 Feb 2002 06:59:41 -0800 (PST)
Message-Id: <20020226.065941.39167730.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020226145730.A20268@stud.ntnu.no>
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
	<20020226145730.A20268@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 26 Feb 2002 14:57:30 +0100
   
   tg3.c:v0.90 (Feb 25, 2002)
   tg3: Problem fetching invariants of chip, aborting.
   
Please apply this patch and tell me what it spits
out, thanks.

--- drivers/net/tg3.c.~1~	Mon Feb 25 17:50:17 2002
+++ drivers/net/tg3.c	Tue Feb 26 06:58:39 2002
@@ -4424,12 +4424,20 @@
 	if (grc_misc_cfg != GRC_MISC_CFG_BOARD_ID_5700 &&
 	    grc_misc_cfg != GRC_MISC_CFG_BOARD_ID_5701 &&
 	    grc_misc_cfg != GRC_MISC_CFG_BOARD_ID_5703 &&
-	    grc_misc_cfg != GRC_MISC_CFG_BOARD_ID_5703S)
+	    grc_misc_cfg != GRC_MISC_CFG_BOARD_ID_5703S) {
+		printk("DEBUG: Yikes grc_misc_cfg is %08x\n",
+		       grc_misc_cfg);
 		return -ENODEV;
+	}
 
 	err = tg3_phy_probe(tp);
-	if (!err)
+	if (err)
+		printk("DEBUG: phy_probe returns with %d\n", err);
+	if (!err) {
 		err = tg3_read_partno(tp);
+		if (err)
+			printk("DEBUG: read_partno returns with %d\n", err);
+	}
 
 	if (tp->phy_id == PHY_ID_SERDES) {
 		tp->tg3_flags &= ~TG3_FLAG_USE_PHY_IRQ;
