Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWCTD1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCTD1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 22:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCTD1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 22:27:12 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:22990 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1751356AbWCTD1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 22:27:11 -0500
Date: Sun, 19 Mar 2006 20:26:42 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, James.Bottomley@steeleye.com, erich@areca.com.tw
Subject: New Areca driver in 2.6.16-rc6-mm2
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2006, Andrew Morton wrote:

> SCSI fixes
>
> +areca-raid-linux-scsi-driver-update4.patch
>
> Update areca-raid-linux-scsi-driver.patch

Has anyone had a chance to review this new update to see if it now passes 
muster for mainline inclusion?

As a owner of Areca hardware I sure appreciate the responsiveness and work 
they have done in respects to Linux support. Thanks to Randy, Christoph, 
Randy and others for their work as well!

Dax Kelson

===========

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/areca-raid-linux-scsi-driver.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/areca-raid-linux-scsi-driver-update4.patch


From: Erich Chen <erich@areca.com.tw>

   1- remove internal queueing
   2- remove odd ioctls
   3- remove useless forward prototypes
   4- give types like ACB useful names
   5- give variable useful names, especially follow kernel conventions,
      e.g. a struct pci_dev is usually named pdev
   6- kill ->proc_info method
   7- use normal comment style even for comments not fitting into the
      kernel-doc item above.  kill useless separator comments without
      text
   8- convert arcmsr_show_firmware_info to useful one value per
      file attributes.
   9- convert arcmsr_show_driver_state to useful one value per
      file attributes.
  10- remove never called release method in the host template
  11- remove shutdown notifier, add pci_driver ->shutdown method instead
  12- remove CameCase PCI Ids.  The vendor Id should go into pci_ids.h,
      the device ids either removed or spelled the normal linux way
  13- arcmsr_do_interrupt should stop walking the global host list
      and use the private data passed to request_irq
  14- the global host list go away completely
  15- locking to be redone.
  16- arcmsr_device_probe rewritten to do goto-based
      error unwinding.
  17- remove msi options
  18- remove arcmsr_scsi_host_template_init
  19- the hardware documentation move from arcmsr.h
      into a separate file (Documentation/scsi/arcmsr_spec.txt)
  20- remove the SCSISTAT_* defines
  21- split arcmsr.c into arcmsr_attr.c from arcmsr_hba.c
