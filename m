Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270218AbUJSXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbUJSXmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270061AbUJSXlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:41:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:58761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269883AbUJSWqS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:18 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257391349@kroah.com>
Date: Tue, 19 Oct 2004 15:42:20 -0700
Message-Id: <10982257403791@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2069, 2004/10/19 14:48:04-07:00, greg@kroah.com

PCI: fix up pci_save/restore_state in via-agp due to api change.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/agp/via-agp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
--- a/drivers/char/agp/via-agp.c	2004-10-19 15:20:55 -07:00
+++ b/drivers/char/agp/via-agp.c	2004-10-19 15:20:55 -07:00
@@ -442,7 +442,7 @@
 
 static int agp_via_suspend(struct pci_dev *pdev, u32 state)
 {
-	pci_save_state (pdev, pdev->saved_config_space);
+	pci_save_state (pdev);
 	pci_set_power_state (pdev, 3);
 
 	return 0;
@@ -453,7 +453,7 @@
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
 	pci_set_power_state (pdev, 0);
-	pci_restore_state(pdev, pdev->saved_config_space);
+	pci_restore_state(pdev);
 
 	if (bridge->driver == &via_agp3_driver)
 		return via_configure_agp3();

