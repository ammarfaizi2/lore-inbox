Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUKBI4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUKBI4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S455516AbUKBIzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:55:44 -0500
Received: from fmr12.intel.com ([134.134.136.15]:32440 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S269191AbUKBIvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:51:20 -0500
Subject: [PATCH]E1000 stop working after resume
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-hPBh4wdQfbwrVciHjIaA"
Message-Id: <1099385047.2628.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 02 Nov 2004 16:45:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hPBh4wdQfbwrVciHjIaA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
Obviously pci_enable_device should be called after pci_restore_state. 

Shaohua


Signed-off-by: Li Shaohua <shaohua.li@intel.com>
---

 2.6-root/drivers/net/e1000/e1000_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/net/e1000/e1000_main.c~e1000-resume
drivers/net/e1000/e1000_main.c
--- 2.6/drivers/net/e1000/e1000_main.c~e1000-resume	2004-11-02
16:34:31.665692032 +0800
+++ 2.6-root/drivers/net/e1000/e1000_main.c	2004-11-02
16:35:18.095633608 +0800
@@ -2885,9 +2885,11 @@ e1000_resume(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc, ret;
 
-	ret = pci_enable_device(pdev);
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	ret = pci_enable_device(pdev);
+	if (pdev->is_busmaster)
+		pci_set_master(pdev);
 
 	pci_enable_wake(pdev, 3, 0);
 	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
_


--=-hPBh4wdQfbwrVciHjIaA
Content-Disposition: attachment; filename=e1000-resume.patch
Content-Type: text/x-patch; name=e1000-resume.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



---

 2.6-root/drivers/net/e1000/e1000_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/net/e1000/e1000_main.c~e1000-resume drivers/net/e1000/e1000_main.c
--- 2.6/drivers/net/e1000/e1000_main.c~e1000-resume	2004-11-02 16:34:31.665692032 +0800
+++ 2.6-root/drivers/net/e1000/e1000_main.c	2004-11-02 16:35:18.095633608 +0800
@@ -2885,9 +2885,11 @@ e1000_resume(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc, ret;
 
-	ret = pci_enable_device(pdev);
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	ret = pci_enable_device(pdev);
+	if (pdev->is_busmaster)
+		pci_set_master(pdev);
 
 	pci_enable_wake(pdev, 3, 0);
 	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
_

--=-hPBh4wdQfbwrVciHjIaA--

