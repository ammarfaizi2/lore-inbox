Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVBQOj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVBQOj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVBQOj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:39:59 -0500
Received: from fsmlabs.com ([168.103.115.128]:61624 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262187AbVBQOjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:39:54 -0500
Date: Thu, 17 Feb 2005 07:40:48 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod while module is in use
In-Reply-To: <4214926B.3030707@roma1.infn.it>
Message-ID: <Pine.LNX.4.61.0502170739530.26742@montezuma.fsmlabs.com>
References: <4214926B.3030707@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, Davide Rossetti wrote:

> maybe RTFM...
> a module:
> - char device driver for..
> - a PCI device
> 
> any clue as to how to protect from module unloading while there is still some
> process opening it??? have I to sleep in the remove_one() pci driver function
> till last process closes its file descriptor???
> 
> static void __devexit apedev_remove_one(struct pci_dev *pdev)
> {
>    ApeDev* apedev = pci_get_drvdata(pdev);
> 
>    if(test_bit(APEDEV_FLAG_OPEN, &apedev->flags)) {
>        PERROR("still open flag on!!! (flags=0x%08x)\n", apedev->flags);
> 
>        // sleep here till it gets closed...
> 
>    }
>    ...
> }
> 
> static struct pci_driver apedev_driver = {
>    .name     =  DEVNAME,
>    .id_table =  apedev_pci_tbl,
>    .probe    =  apedev_init_one,
>    .remove   =  __devexit_p(apedev_remove_one),
> };

Add .module = THIS_MODULE to your file_operations.

