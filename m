Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVDLTGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVDLTGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVDLTGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:06:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:48585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbVDLKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:36 -0400
Message-Id: <200504121032.j3CAWNuQ005577@shell0.pdx.osdl.net>
Subject: [patch 110/198] fix u32 vs. pm_message_t in drivers/message
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes u32 vs. pm_message_t in drivers/message.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/message/fusion/mptbase.c  |    2 +-
 25-akpm/drivers/message/fusion/mptbase.h  |    2 +-
 25-akpm/drivers/message/fusion/mptscsih.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/message/fusion/mptbase.c~fix-u32-vs-pm_message_t-in-drivers-message drivers/message/fusion/mptbase.c
--- 25/drivers/message/fusion/mptbase.c~fix-u32-vs-pm_message_t-in-drivers-message	2005-04-12 03:21:29.942584936 -0700
+++ 25-akpm/drivers/message/fusion/mptbase.c	2005-04-12 03:21:29.952583416 -0700
@@ -1429,7 +1429,7 @@ mptbase_shutdown(struct device * dev)
  *
  */
 static int
-mptbase_suspend(struct pci_dev *pdev, u32 state)
+mptbase_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	u32 device_state;
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
diff -puN drivers/message/fusion/mptbase.h~fix-u32-vs-pm_message_t-in-drivers-message drivers/message/fusion/mptbase.h
--- 25/drivers/message/fusion/mptbase.h~fix-u32-vs-pm_message_t-in-drivers-message	2005-04-12 03:21:29.943584784 -0700
+++ 25-akpm/drivers/message/fusion/mptbase.h	2005-04-12 03:21:29.954583112 -0700
@@ -215,7 +215,7 @@ struct mpt_pci_driver{
 	void (*shutdown) (struct device * dev);
 #ifdef CONFIG_PM
 	int  (*resume) (struct pci_dev *dev);
-	int  (*suspend) (struct pci_dev *dev, u32 state);
+	int  (*suspend) (struct pci_dev *dev, pm_message_t state);
 #endif
 };
 
diff -puN drivers/message/fusion/mptscsih.c~fix-u32-vs-pm_message_t-in-drivers-message drivers/message/fusion/mptscsih.c
--- 25/drivers/message/fusion/mptscsih.c~fix-u32-vs-pm_message_t-in-drivers-message	2005-04-12 03:21:29.945584480 -0700
+++ 25-akpm/drivers/message/fusion/mptscsih.c	2005-04-12 03:21:29.958582504 -0700
@@ -220,7 +220,7 @@ static int  mptscsih_probe (struct pci_d
 static void mptscsih_remove(struct pci_dev *);
 static void mptscsih_shutdown(struct device *);
 #ifdef CONFIG_PM
-static int mptscsih_suspend(struct pci_dev *pdev, u32 state);
+static int mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 static int mptscsih_resume(struct pci_dev *pdev);
 #endif
 
@@ -1389,7 +1389,7 @@ mptscsih_shutdown(struct device * dev)
  *
  */
 static int
-mptscsih_suspend(struct pci_dev *pdev, u32 state)
+mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	mptscsih_shutdown(&pdev->dev);
 	return 0;
_
