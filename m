Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbULVIjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbULVIjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULVIjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:39:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:62138 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261889AbULVIjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:39:44 -0500
Subject: Re: [PATCH] add legacy resources to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, willy@debian.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20041221214623.GB10362@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com>
	 <20041221214623.GB10362@kroah.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 09:38:59 +0100
Message-Id: <1103704739.28670.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 13:46 -0800, Greg KH wrote:
> On Tue, Dec 21, 2004 at 12:47:44PM -0800, Jesse Barnes wrote:
> > Here's a rediff against Greg's current tree.  It adds legacy_io and legacy_mem 
> > files to each PCI bus directory in sysfs for use by applications that want to 
> > do old school ISA style programming from userspace.
> > 
> > I'm not sure I've got the sysfs file creation correct, Greg?  Am I passing the 
> > wrong thing around?  The compile warnings in pci-sysfs.c for the new routines 
> > seem to indicate that...  Basically I need to get to a pci_bus structure from 
> > the read/write/mmap routines, and that should be accessible from the kobject 
> > somewhere, right?
> 
> You are passing the wrong things around :)
> 
> A struct pci_bus is a struct class_device, not a struct device.  I think
> you need to rethink your goal of putting the files into the pci device
> directory, or just put the files into the proper /sys/class/pci_bus/*
> directory as your code assumes is happening.

It makes no sense in /sys/class/pci_bus/* since we need the files to be
in a bus _instance_ 

Ben.


