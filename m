Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSG2Sqg>; Mon, 29 Jul 2002 14:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSG2Sqg>; Mon, 29 Jul 2002 14:46:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38827 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317620AbSG2Sqf>; Mon, 29 Jul 2002 14:46:35 -0400
Message-ID: <3D458E4B.4030702@us.ibm.com>
Date: Mon, 29 Jul 2002 11:49:47 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: christopher.leech@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix e1000 after irq craziness
Content-Type: multipart/mixed;
 boundary="------------020009010406050401060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009010406050401060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I just duplicated the method used in:
drivers/net/tulip/de2104x.c

Compiles for me.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------020009010406050401060500
Content-Type: text/plain;
 name="e1000-irqfix-2.5.29-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e1000-irqfix-2.5.29-0.patch"

diff -ur linux-2.5.29-clean/drivers/net/e1000/e1000_main.c linux-2.5.29/drivers/net/e1000/e1000_main.c
--- linux-2.5.29-clean/drivers/net/e1000/e1000_main.c	Fri Jul 26 19:58:36 2002
+++ linux-2.5.29/drivers/net/e1000/e1000_main.c	Mon Jul 29 11:43:18 2002
@@ -1699,7 +1699,7 @@
 {
 	atomic_inc(&adapter->irq_sem);
 	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
-	synchronize_irq();
+	synchronize_irq(adapter->netdev->irq);
 }
 
 /**

--------------020009010406050401060500--

