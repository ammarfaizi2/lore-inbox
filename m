Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbUBDUpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUBDUYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:24:33 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:44079 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S266522AbUBDUXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:23:30 -0500
Message-ID: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net>
Date: Wed, 4 Feb 2004 15:23:29 -0500 (GMT-05:00)
From: Oliver Dain <odain2@mindspring.com>
Reply-To: Oliver Dain <odain2@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: proper place for devfs_register_chrdev with pci_module_init
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Earthlink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a char driver for a PCI card.  Looking at examples of such things I've found that most have a module_init like this:

int foo_init(void)
{
	/* stuff... */
	devfs_register_chrdev(...);
	/* more stuff... */
	pci_module_init(...);
}

This seems strange to me.  The devfs_register_chrdev call will register the module and cause it to be held in memory even if the associated PCI device isn't present on the system.  It seems like a better way to do this is to have the init method just call pci_module_init(...) and then in that method, after the PCI device has been initialized, call devfs_register_chrdev to associate the driver with the device.  That way the kernel can unload the module if no such device is present, but if the device is present (or if one appears via hotplug) the module will be loaded and can then register itself.  Will this work?  Is there a reason people don't do this?

I'm not subscribed to the LKML so please CC me on any responses.

Thanks,
Oliver
