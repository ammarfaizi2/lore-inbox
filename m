Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUHNLOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUHNLOF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUHNLOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:14:05 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:40912 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S268314AbUHNLOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:14:00 -0400
Message-ID: <411DF42E.5030504@kmlinux.fjfi.cvut.cz>
Date: Sat, 14 Aug 2004 13:14:54 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040812
X-Accept-Language: en-us, en, cs
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] HPT374 kernel panic - regression in 2.6.8
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

HighPoint 374 driver in 2.6.8 can cause kernel panic on boot with 
non-33MHz timings because some lines from an older version have been 
included in the source again. After removing the check, HPT374 works 
just fine using internal PLL.

--- old/hpt366.c	2004-08-14 13:06:12.000000000 +0200
+++ new/hpt366.c	2004-08-14 12:59:25.000000000 +0200
@@ -991,11 +991,6 @@
  	if (pci_get_drvdata(dev))
  		goto init_hpt37X_done;
  	
-	if (hpt_minimum_revision(dev,8))
-	{
-		printk(KERN_ERR "HPT374: Only 33MHz PCI timings are supported.\n");
-		return -EOPNOTSUPP;
-	}
  	/*
  	 * adjust PLL based upon PCI clock, enable it, and wait for
  	 * stabilization.

Regards,
-- 
Jindrich Makovicka
