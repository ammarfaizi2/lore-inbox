Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVHZKEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVHZKEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 06:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVHZKEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 06:04:13 -0400
Received: from sdcrelbas03.europe.hp.net ([15.203.169.189]:38090 "EHLO
	sdcrelbas03.sdc.hp.com") by vger.kernel.org with ESMTP
	id S1750765AbVHZKEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 06:04:13 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: FW: e1000 set netdev irq patch
Date: Fri, 26 Aug 2005 11:04:06 +0100
Message-ID: <575D0CDD99F591478ADD639EF4E36E7E034ACC2C@iloexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 set netdev irq patch
Thread-Index: AcWqJCMdQMA2nkU2TTmtte6QIbcmHQAASC7w
From: "Sullivan, Jon Paul" <JonPaul.Sullivan@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Aug 2005 10:04:08.0045 (UTC) FILETIME=[7F8DF9D0:01C5AA25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a patch that enables the e1000 driver to set the netdev->irq field.  This is useful if you are trying to balance irqs between cpus.

--- linux-orig/drivers/net/e1000/e1000_main.c   Tue Jun 28 14:16:19 2005
+++ linux-new/drivers/net/e1000/e1000_main.c    Tue Jun 28 13:51:46 2005
@@ -285,6 +285,8 @@ e1000_up(struct e1000_adapter *adapter)
      mod_timer(&adapter->watchdog_timer, jiffies);
      e1000_irq_enable(adapter);
 
+     netdev->irq = adapter->pdev->irq;
+
      return 0;
 }
 


