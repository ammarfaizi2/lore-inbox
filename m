Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270177AbUJSXXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270177AbUJSXXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270111AbUJSXRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:17:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:22666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270173AbUJSWqo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:44 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257393129@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257393636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.56, 2004/10/06 13:52:57-07:00, greg@kroah.com

[PATCH] PCI: clean up pci_dev_get() to be sane

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 15:22:34 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 15:22:34 -07:00
@@ -504,16 +504,9 @@
  */
 struct pci_dev *pci_dev_get(struct pci_dev *dev)
 {
-	struct device *tmp;
-
-	if (!dev)
-		return NULL;
-
-	tmp = get_device(&dev->dev);
-	if (tmp)        
-		return to_pci_dev(tmp);
-	else
-		return NULL;
+	if (dev)
+		get_device(&dev->dev);
+	return dev;
 }
 
 /**

