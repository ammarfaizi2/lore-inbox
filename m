Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVDBAgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVDBAgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVDBANI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:13:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:45020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262956AbVDAXsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:21 -0500
Cc: eike-kernel@sf-tec.de
Subject: [PATCH] PCI: remove pci_find_device usage from pci sysfs code.
In-Reply-To: <1112399274112@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:54 -0800
Message-Id: <11123992741846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.23, 2005/03/28 15:19:00-08:00, eike-kernel@sf-tec.de

[PATCH] PCI: remove pci_find_device usage from pci sysfs code.

Greg KH wrote:
> On Sun, Mar 20, 2005 at 03:53:58PM +0100, Rolf Eike Beer wrote:
> > Greg KH wrote:
> > > ChangeSet 1.1998.11.23, 2005/02/25 08:26:11-08:00, gregkh@suse.de
> > >
> > > PCI: remove pci_find_device usage from pci sysfs code.

> > Any reasons why you are not using "for_each_pci_dev(pdev)" here?
>
> Nope, I forgot it was there :)

Patch is against 2.6.12-rc1-bk1 and does the same think like your one,
except it uses for_each_pci_dev()

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pci-sysfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-04-01 15:31:47 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-04-01 15:31:47 -08:00
@@ -481,7 +481,7 @@
 	struct pci_dev *pdev = NULL;
 	
 	sysfs_initialized = 1;
-	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
+	for_each_pci_dev(pdev)
 		pci_create_sysfs_dev_files(pdev);
 
 	return 0;

