Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCYLbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCYLbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 06:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYLbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 06:31:19 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:30081 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261614AbVCYLaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 06:30:25 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: Re: PCI: remove pci_find_device usage from pci sysfs code.
Date: Thu, 24 Mar 2005 22:06:11 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <11099696382684@kroah.com> <200503201554.05010.eike-kernel@sf-tec.de> <20050321184020.GA5472@kroah.com>
In-Reply-To: <20050321184020.GA5472@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503242206.12914.eike-kernel@sf-tec.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Eike

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/drivers/pci/pci-sysfs.c	2005-03-21 11:41:56.000000000 +0100
+++ linux-2.6.12-rc1/drivers/pci/pci-sysfs.c	2005-03-24 19:20:50.000000000 
+0100
@@ -481,7 +481,7 @@ static int __init pci_sysfs_init(void)
 	struct pci_dev *pdev = NULL;
 	
 	sysfs_initialized = 1;
-	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
+	for_each_pci_dev(pdev)
 		pci_create_sysfs_dev_files(pdev);
 
 	return 0;
