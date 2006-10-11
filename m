Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161579AbWJKWcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161579AbWJKWcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161581AbWJKWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:32:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161571AbWJKWcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:32:02 -0400
Date: Wed, 11 Oct 2006 15:29:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCMCIA: handle sysfs, PCI errors
Message-Id: <20061011152905.f0c5c067.akpm@osdl.org>
In-Reply-To: <20061011214955.GA22109@havoc.gtf.org>
References: <20061011214955.GA22109@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some of these were already fixed in pcmcia-ds-must_check-fixes.patch and
i82092-wire-up-errors-from-pci_register_driver.patch:

static int __init init_pcmcia_bus(void)
{
	int ret;

	spin_lock_init(&pcmcia_dev_list_lock);

	ret = bus_register(&pcmcia_bus_type);
	if (ret < 0) {
		printk(KERN_WARNING "pcmcia: bus_register error: %d\n", ret);
		return ret;
	}
	ret = class_interface_register(&pcmcia_bus_interface);
	if (ret < 0) {
		printk(KERN_WARNING
			"pcmcia: class_interface_register error: %d\n", ret);
		bus_unregister(&pcmcia_bus_type);
		return ret;
	}

	pcmcia_setup_ioctl();

	return 0;
}


and

static int i82092aa_module_init(void)
{
	return pci_register_driver(&i82092aa_pci_drv);
}

I queued the rest for Dominik-spamming.
