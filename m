Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbULUVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbULUVqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbULUVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:46:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:13241 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261864AbULUVqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:46:39 -0500
Date: Tue, 21 Dec 2004 13:46:23 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Message-ID: <20041221214623.GB10362@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211247.44883.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 12:47:44PM -0800, Jesse Barnes wrote:
> Here's a rediff against Greg's current tree.  It adds legacy_io and legacy_mem 
> files to each PCI bus directory in sysfs for use by applications that want to 
> do old school ISA style programming from userspace.
> 
> I'm not sure I've got the sysfs file creation correct, Greg?  Am I passing the 
> wrong thing around?  The compile warnings in pci-sysfs.c for the new routines 
> seem to indicate that...  Basically I need to get to a pci_bus structure from 
> the read/write/mmap routines, and that should be accessible from the kobject 
> somewhere, right?

You are passing the wrong things around :)

A struct pci_bus is a struct class_device, not a struct device.  I think
you need to rethink your goal of putting the files into the pci device
directory, or just put the files into the proper /sys/class/pci_bus/*
directory as your code assumes is happening.

thanks,

greg k-h
