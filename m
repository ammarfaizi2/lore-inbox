Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSL1QJw>; Sat, 28 Dec 2002 11:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSL1QJw>; Sat, 28 Dec 2002 11:09:52 -0500
Received: from host194.steeleye.com ([66.206.164.34]:59663 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264628AbSL1QJv>; Sat, 28 Dec 2002 11:09:51 -0500
Message-Id: <200212281618.gBSGI7Q02415@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Fri, 27 Dec 2002 17:29:54 PST." <3E0CFE92.7060902@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:18:07 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> The indirection is getting from the USB device (or interface) to the
> object representing the USB controller.  All USB calls need that, at
> least for host-side APIs, since the controller driver is multiplexing
> up to almost 4000 I/O channels.  (127 devices * 31 endpoints, max; and
> of course typical usage is more like dozens of channels.) 

This sounds like a mirror of the problem of finding the IOMMU on parisc (there 
can be more than one).

The way parisc solves this is to look in dev->platform_data and if that's null 
walk up the dev->parent until the IOMMU is found and then cache the IOMMU ops 
in the current dev->platform_data.  Obviously, you can't use platform_data, 
but you could use driver_data for this.  The IOMMU's actually lie on a parisc 
specific bus, so the ability to walk up the device tree without having to know 
the device types was crucial to implementing this.

James


