Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVEQVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVEQVwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEQVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:52:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:64155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261999AbVEQVo5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:57 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: add MODALIAS to hotplug event for pci devices
In-Reply-To: <11163663063114@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:07 -0700
Message-Id: <11163663073831@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: add MODALIAS to hotplug event for pci devices

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d1ded203adf16b42ca90e9041120ae465ca5c4a6
tree 59c3218467807e1793fb4fc5d90141e072ab2212
parent 9888549e0507cc95d1d7ade1595c00ff8e902659
author Greg KH <gregkh@suse.de> Thu, 05 May 2005 11:57:25 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:12 -0700

 drivers/pci/hotplug.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: drivers/pci/hotplug.c
===================================================================
--- 9c31d2b34ef9b747733f7f39916a8031f89c3d1e/drivers/pci/hotplug.c  (mode:100644)
+++ 59c3218467807e1793fb4fc5d90141e072ab2212/drivers/pci/hotplug.c  (mode:100644)
@@ -52,6 +52,16 @@
 	if ((buffer_size - length <= 0) || (i >= num_envp))
 		return -ENOMEM;
 
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length,
+			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
+			    pdev->vendor, pdev->device,
+			    pdev->subsystem_vendor, pdev->subsystem_device,
+			    (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
+			    (u8)(pdev->class));
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+
 	envp[i] = NULL;
 
 	return 0;

