Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbULVQKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbULVQKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbULVQKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:10:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:33959 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262005AbULVQKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:10:20 -0500
Date: Wed, 22 Dec 2004 08:09:52 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, willy@debian.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Message-ID: <20041222160952.GB9358@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <20041221214623.GB10362@kroah.com> <1103704739.28670.57.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103704739.28670.57.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 09:38:59AM +0100, Benjamin Herrenschmidt wrote:
> On Tue, 2004-12-21 at 13:46 -0800, Greg KH wrote:
> > On Tue, Dec 21, 2004 at 12:47:44PM -0800, Jesse Barnes wrote:
> > > Here's a rediff against Greg's current tree.  It adds legacy_io and legacy_mem 
> > > files to each PCI bus directory in sysfs for use by applications that want to 
> > > do old school ISA style programming from userspace.
> > > 
> > > I'm not sure I've got the sysfs file creation correct, Greg?  Am I passing the 
> > > wrong thing around?  The compile warnings in pci-sysfs.c for the new routines 
> > > seem to indicate that...  Basically I need to get to a pci_bus structure from 
> > > the read/write/mmap routines, and that should be accessible from the kobject 
> > > somewhere, right?
> > 
> > You are passing the wrong things around :)
> > 
> > A struct pci_bus is a struct class_device, not a struct device.  I think
> > you need to rethink your goal of putting the files into the pci device
> > directory, or just put the files into the proper /sys/class/pci_bus/*
> > directory as your code assumes is happening.
> 
> It makes no sense in /sys/class/pci_bus/* since we need the files to be
> in a bus _instance_ 

Hm, what do you mean by "instance"?  My /sys/class/pci_bus has the
individual pci busses:
 $ tree /sys/class/pci_bus/
 /sys/class/pci_bus/
 |-- 0000:00
 |   |-- bridge -> ../../../devices/pci0000:00
 |   `-- cpuaffinity
 |-- 0000:01
 |   |-- bridge -> ../../../devices/pci0000:00/0000:00:01.0
 |   `-- cpuaffinity
 `-- 0000:02
     |-- bridge -> ../../../devices/pci0000:00/0000:00:1e.0
     `-- cpuaffinity


We already have the cpuaffinity stuff in there, why not more, pci bus
specific things?

thanks,

greg k-h
