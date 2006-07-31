Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWGaSSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWGaSSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGaSSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:18:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46351 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030301AbWGaSSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:18:02 -0400
Date: Mon, 31 Jul 2006 14:18:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Aleksey Gorelov <dared1st@yahoo.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier
 in case of failure in ehci hcd
In-Reply-To: <20060731172327.9269.qmail@web81206.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0607311414360.8047-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Aleksey Gorelov wrote:

>   If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
> tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to crash on
> reboot/poweroff. The following patch resolves this problem by not using reboot notifiers anymore,
> but instead making ehci/ohci driver get its own shutdown method. For PCI, it is done through pci
> glue, for everything else through platform driver glue.

Why do you need to change the bus glue?  Wouldn't it be a lot simpler just 
to add ehci_shutdown as a member of ehci_pci_driver, for instance, with 
similar changes to ehci_hcd_au1xxx_driver and ehci_hcd_fsl_driver?

Alan Stern

