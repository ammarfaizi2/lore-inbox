Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVCRRIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVCRRIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVCRRIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:08:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:59805 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261899AbVCRRHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:07:32 -0500
Date: Fri, 18 Mar 2005 09:07:09 -0800
From: Greg KH <gregkh@suse.de>
To: Toralf Lund <toralf@procaptura.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
Message-ID: <20050318170709.GD14952@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <423A9B65.1020103@procaptura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423A9B65.1020103@procaptura.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 10:12:05AM +0100, Toralf Lund wrote:
> Am I seeing an issue with the PCI functions here, or is it just that I 
> fail to spot an obvious mistake in the module itself?

I think it's a problem in your code.  I built and ran the following
example module just fine (based on your example, which wasn't the
smallest or cleanest...), with no oops.  Does this code work for you?

Oh, and the pci_find* functions are depreciated, do not use them, they
are going away in the near future.  Please use the pci_get* functions
instead.

thanks,

greg k-h

-----------------
#include <linux/pci.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");

	
static void __exit exit(void)
{  
}

static __init int init(void)
{
	struct pci_dev *dev;
 
	printk(KERN_DEBUG "Scanning all devices...\n");
 
	dev = NULL;
	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
		printk(KERN_DEBUG "Device %04hx:%04hx\n",
			dev->vendor, dev->device);
	}
	return 0;
}

module_init(init);
module_exit(exit);

