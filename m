Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUHWTIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUHWTIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUHWTGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:06:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:7876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267283AbUHWSg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:56 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860862730@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <10932860863820@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.17, 2004/08/04 18:34:36-07:00, greg@kroah.com

PCI: oops, forgot to check in the pci.h changes so that the quirk cleanups will work

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-08-23 11:05:43 -07:00
+++ b/include/linux/pci.h	2004-08-23 11:05:43 -07:00
@@ -1005,8 +1005,10 @@
 	void (*hook)(struct pci_dev *dev);
 };
 
-#define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
-#define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+enum pci_fixup_pass {
+	pci_fixup_header,	/* Called immediately after reading configuration header */
+	pci_fixup_final,	/* Final phase of device fixups */
+};
 
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)					\
@@ -1019,8 +1021,7 @@
 	__attribute__((__section__(".pci_fixup_final"))) = {				\
 		vendor, device, hook };
 
-
-void pci_fixup_device(int pass, struct pci_dev *dev);
+void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1

