Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSHXVWM>; Sat, 24 Aug 2002 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHXVWJ>; Sat, 24 Aug 2002 17:22:09 -0400
Received: from keen.esi.ac.at ([193.170.117.2]:44810 "EHLO keen.esi.ac.at")
	by vger.kernel.org with ESMTP id <S316753AbSHXVWH>;
	Sat, 24 Aug 2002 17:22:07 -0400
Date: Sat, 24 Aug 2002 23:26:20 +0200 (CEST)
From: Gerald Teschl <gerald@esi.ac.at>
To: linux-kernel@vger.kernel.org
cc: linux-sound@vger.kernel.org
Subject: [PATCH] ad1848 infinite loop fix
Message-ID: <Pine.LNX.4.44.0208242324450.29094-100000@keen.esi.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I found the problem which causes the infinite loop
when the activation fails:

--- linux-2.4.19/drivers/sound/ad1848.c.orig    Sat Aug 24 23:19:54 2002
+++ linux-2.4.19/drivers/sound/ad1848.c Sat Aug 24 23:20:58 2002
@@ -3058,7 +3058,7 @@
        else
                printk(KERN_INFO "ad1848: Failed to initialize %s\n", 
devname);

-       return 0;
+       return -ENODEV;
 }

 static int __init ad1848_isapnp_probe(struct address_info *hw_config)


