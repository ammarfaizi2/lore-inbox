Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266999AbUAXTAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 14:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267001AbUAXTAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 14:00:38 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63161 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266999AbUAXTAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 14:00:36 -0500
Date: Sat, 24 Jan 2004 19:59:51 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
Message-ID: <20040124195951.A1304@electric-eye.fr.zoreil.com>
References: <4012A738.2060009@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4012A738.2060009@gmx.net>; from c-d.hailfinger.kernel.2004@gmx.net on Sat, Jan 24, 2004 at 06:11:20PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
[current version of forcedeth]

+static int __devinit probe_nic(struct pci_dev *pci_dev, const struct pci_device_id *id)
+{
[...]
+       dev = alloc_etherdev(sizeof(struct fe_priv));
+       np = get_nvpriv(dev);
+       err = -ENOMEM;
+       if (!dev)
+               goto out;

-> get_npriv() can still dereference a NULL pointer.

[...]
+       err = pci_request_regions(pci_dev, dev->name);
+       if (err < 0)
+               goto out_disable;
[...]
+       if (i == DEVICE_COUNT_RESOURCE) {
+               printk(KERN_INFO "forcedeth: Couldn't find register window for device %s.\n",
+                                       pci_name(pci_dev));
+               goto out_relreg;
[...]
+       if (!dev->base_addr)
+               goto out_disable;
                     ^^^^^^^^^^^
-> shouldn't it be out_relreg ?

--
Ueimor
