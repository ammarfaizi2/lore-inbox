Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268362AbUHXVhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268362AbUHXVhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUHXVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:37:49 -0400
Received: from gobio2.net ([82.225.138.2]:10176 "EHLO gobio.gobio2.net")
	by vger.kernel.org with ESMTP id S268362AbUHXVfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:35:46 -0400
Subject: Problem with SiS900 - Unknown PHY
From: Laurent <laurent@gobio2.net>
To: linux-kernel@vger.kernel.org
Cc: webvenza@libero.it
Content-Type: text/plain
Date: Tue, 24 Aug 2004 23:36:07 +0200
Message-Id: <1093383367.11744.0.camel@caribou.gobio2.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago, I sent on this list a mail about my strange problem with
my SiS900 network card (Subject was Sluggish performances with FreeBSD)

To sum up, when my card is in 100Mb mode, I have poor throughput but in
10Mb, all seems normal.

After some tests, it seems these results was due to a misdetection of
the PHY device. mii-tool reports :
 product info: vendor 08:00:17, model 3 rev 0

and after some search on the web, I found it's a NS DP83847 which is
very similar

Here is the patch :

--- linux/drivers/net/sis900.c.old      2004-08-24 20:51:43.865086208
+0200
+++ linux/drivers/net/sis900.c  2004-08-24 20:21:48.000000000 +0200
@@ -124,6 +124,7 @@
        { "AMD 79C901 HomePNA PHY",             0x0000, 0x6B90, HOME},
        { "ICS LAN PHY",                        0x0015, 0xF440, LAN },
        { "NS 83851 PHY",                       0x2000, 0x5C20, MIX },
+       { "NS 83847 PHY",                       0x2000, 0x5C30, MIX },
        { "Realtek RTL8201 PHY",                0x0000, 0x8200, LAN },
        { "VIA 6103 PHY",                       0x0101, 0x8f20, LAN },
        {NULL,},

Hope it can help some people

Laurent Goujon

