Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUGCUXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUGCUXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUGCUXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:23:19 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:64953 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265241AbUGCUXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:23:14 -0400
Date: Sat, 3 Jul 2004 22:15:15 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040703221515.B3275@electric-eye.fr.zoreil.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040703010709.A22334@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Jul 03, 2004 at 01:07:09AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[drivers/net/wireless/orinoco_tmd.c:orinoco_tmd_init_one]
        err = pci_enable_device(pdev);
-       if (err)
-               return -EIO;
-
-       printk(KERN_DEBUG "TMD setup\n");
-       pccard_ioaddr = pci_resource_start(pdev, 2);
-       pccard_iolen = pci_resource_len(pdev, 2);
-       if (! request_region(pccard_ioaddr, pccard_iolen, dev_info)) {
-               printk(KERN_ERR PFX "I/O resource at 0x%lx len 0x%lx busy\n",
-                       pccard_ioaddr, pccard_iolen);
-               pccard_ioaddr = 0;
-               err = -EBUSY;
-               goto fail;
+       if (err) {
+               printk(KERN_ERR PFX "Cannot enable PCI device\n");
+               return -err;

-> translates into
   err = pci_enable_device(dev);
   if (err) {
           printk(KERN_ERR PFX "Cannot enable PCI device\n");
           return -err;

i.e. incorrectly returns > 0 

--
Ueimor
