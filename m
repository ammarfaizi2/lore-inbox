Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDBVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDBVsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDBViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:38:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50892 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261392AbVDBV0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:26:23 -0500
Date: Sat, 2 Apr 2005 23:26:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in drivers/message
Message-ID: <20050402212608.GA2140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t in drivers/message. [These patches are
independend and change no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/message/fusion/mptbase.c	2005-03-29 13:29:59.000000000 +0200
+++ linux-cvs/drivers/message/fusion/mptbase.c	2005-03-31 23:54:45.000000000 +0200
@@ -1429,7 +1429,7 @@
  *
  */
 static int
-mptbase_suspend(struct pci_dev *pdev, u32 state)
+mptbase_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	u32 device_state;
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
--- clean-cvs/drivers/message/fusion/mptbase.h	2005-03-31 23:33:38.000000000 +0200
+++ linux-cvs/drivers/message/fusion/mptbase.h	2005-03-31 23:54:45.000000000 +0200
@@ -215,7 +215,7 @@
 	void (*shutdown) (struct device * dev);
 #ifdef CONFIG_PM
 	int  (*resume) (struct pci_dev *dev);
-	int  (*suspend) (struct pci_dev *dev, u32 state);
+	int  (*suspend) (struct pci_dev *dev, pm_message_t state);
 #endif
 };
 
--- clean-cvs/drivers/message/fusion/mptscsih.c	2005-03-31 23:33:38.000000000 +0200
+++ linux-cvs/drivers/message/fusion/mptscsih.c	2005-03-31 23:54:45.000000000 +0200
@@ -220,7 +220,7 @@
 static void mptscsih_remove(struct pci_dev *);
 static void mptscsih_shutdown(struct device *);
 #ifdef CONFIG_PM
-static int mptscsih_suspend(struct pci_dev *pdev, u32 state);
+static int mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 static int mptscsih_resume(struct pci_dev *pdev);
 #endif
 
@@ -1389,7 +1389,7 @@
  *
  */
 static int
-mptscsih_suspend(struct pci_dev *pdev, u32 state)
+mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	mptscsih_shutdown(&pdev->dev);
 	return 0;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
