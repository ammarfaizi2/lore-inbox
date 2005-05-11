Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVEKOmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVEKOmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVEKOjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:39:02 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:20096 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261980AbVEKOiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:38:22 -0400
Date: Wed, 11 May 2005 10:38:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <akpm@osdl.org>,
       <jgarzik@pobox.com>, <cramerj@intel.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <20050511053327.GA28791@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0505111031550.16579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Vivek Goyal wrote:

> > I looked into the possibility of having the PCI core disable interrupt
> > generation and DMA on each new device as it is discovered.  Unfortunately
> > there is no dependable, universal way to do this for IRQs.  (A notable gap
> > in the original PCI specification, IMHO.)  
> 
> PCI specification 2.3 onwards, command register bit 10 can be used for
> disabling the interrupts from respective device. And the very reason for
> introducing this bit seems to be to not allow the device issue interrupts
> until a suitable driver for the device has been loaded. Have a look at
> following message.
> 
> http://www.pcisig.com/reflector/msg05302.html
> 
> Probably this feature can be used to disable the interrupts from the devices
> and enable these back when respective driver is loaded. This will resolve
> the problem of drivers not getting initialized in second kernel due to shared
> interrupts in kdump and reliability of capturing dump can be increased. 

That's good, and it's certainly a step in the right direction.  It won't
help with any pre-PCI-2.3 devices out there but it might be worth trying
to implement.

Alan Stern

