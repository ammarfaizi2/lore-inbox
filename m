Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUFNRWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUFNRWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUFNRWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:22:39 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:60296 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S263665AbUFNRWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:22:36 -0400
Date: Mon, 14 Jun 2004 19:22:25 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Fix off-by-one in pci_enable_wake
Message-ID: <20040614172225.GA23014@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.7-rc3-bk6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix off-by-one in pci_enable_wake.
Bit field location determined by mask, not value.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.7-rc3-bk6/drivers/pci/pci.c.orig	2004-06-14 18:42:09.561442345 +0200
+++ linux-2.6.7-rc3-bk6/drivers/pci/pci.c	2004-06-14 18:43:15.083670484 +0200
@@ -442,7 +442,7 @@
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 
 	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(value);   /* First bit of mask */
+	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
 
 	/* Check if it can generate PME# from requested state. */
 	if (!value || !(value & (1 << state))) 
