Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265796AbUFXWdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUFXWdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFXWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:33:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:39094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265792AbUFXVr1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:27 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135683007@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <10881135683559@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.6, 2004/06/14 11:11:45-07:00, rl@hellgate.ch

[PATCH] PCI: Fix off-by-one in pci_enable_wake

Fix off-by-one in pci_enable_wake.
Bit field location determined by mask, not value.

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-06-24 13:50:47 -07:00
+++ b/drivers/pci/pci.c	2004-06-24 13:50:47 -07:00
@@ -442,7 +442,7 @@
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 
 	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(value);   /* First bit of mask */
+	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
 
 	/* Check if it can generate PME# from requested state. */
 	if (!value || !(value & (1 << state))) 

