Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTI3XB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbTI3Wrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:47:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:35291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261821AbTI3WrV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:21 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10649613493963@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <10649613491242@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1344, 2003/09/26 16:33:35-07:00, mochel@osdl.org

[PATCH] Remove ->save_state() in nsp32.c

Remove the uncalled and unneeded struct pci_driver::save_state() in
drivers/scsi/nsp32.c


 drivers/scsi/nsp32.c |   10 ----------
 1 files changed, 10 deletions(-)


diff -Nru a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
--- a/drivers/scsi/nsp32.c	Tue Sep 30 15:20:57 2003
+++ b/drivers/scsi/nsp32.c	Tue Sep 30 15:20:57 2003
@@ -3435,15 +3435,6 @@
  * Power Management
  */
 #ifdef CONFIG_PM
-/* Save Device Context */
-static int nsp32_save_state(struct pci_dev *pdev, u32 state)
-{
-	struct Scsi_Host *host = pci_get_drvdata(pdev);
-
-	nsp32_msg(KERN_INFO, "pci-save_state: stub, pdev=0x%p, state=%ld, slot=%s, host=0x%p", pdev, state, pci_name(pdev), host);
-
-	return 0;
-}
 
 /* Device suspended */
 static int nsp32_suspend(struct pci_dev *pdev, u32 state)
@@ -3573,7 +3564,6 @@
 	.probe		= nsp32_probe,
 	.remove		= __devexit_p(nsp32_remove),
 #ifdef CONFIG_PM
-	.save_state     = nsp32_save_state,
 	.suspend	= nsp32_suspend, 
 	.resume		= nsp32_resume, 
 	.enable_wake    = nsp32_enable_wake,

