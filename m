Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756604AbWKVTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbWKVTJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756678AbWKVTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:09:22 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:64426 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1756604AbWKVTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:09:22 -0500
Date: Wed, 22 Nov 2006 14:09:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5: modular USB rebuilds vmlinux?
In-Reply-To: <20061122105454.aa5c0f3d.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.44L0.0611221407070.4272-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006, Randy Dunlap wrote:

> On Wed, 22 Nov 2006 21:45:55 +0300 Andrey Borzenkov wrote:
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > I was under impression that I have fully modular USB. Still:
> > 
> > {pts/1}% make -C ~/src/linux-git O=$HOME/build/linux-2.6.19
> > make: Entering directory `/home/bor/src/linux-git'
> >   GEN     /home/bor/build/linux-2.6.19/Makefile
> > scripts/kconfig/conf -s arch/i386/Kconfig
> >   Using /home/bor/src/linux-git as source for kernel
> >   GEN     /home/bor/build/linux-2.6.19/Makefile
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CHK     include/linux/compile.h
> >   CC [M]  drivers/usb/core/usb.o
> >   CC [M]  drivers/usb/core/hub.o
> >   CC [M]  drivers/usb/core/hcd.o
> >   CC [M]  drivers/usb/core/urb.o
> >   CC [M]  drivers/usb/core/message.o
> >   CC [M]  drivers/usb/core/driver.o
> >   CC [M]  drivers/usb/core/config.o
> >   CC [M]  drivers/usb/core/file.o
> >   CC [M]  drivers/usb/core/buffer.o
> >   CC [M]  drivers/usb/core/sysfs.o
> >   CC [M]  drivers/usb/core/endpoint.o
> >   CC [M]  drivers/usb/core/devio.o
> >   CC [M]  drivers/usb/core/notify.o
> >   CC [M]  drivers/usb/core/generic.o
> >   CC [M]  drivers/usb/core/hcd-pci.o
> >   CC [M]  drivers/usb/core/inode.o
> >   CC [M]  drivers/usb/core/devices.o
> >   LD [M]  drivers/usb/core/usbcore.o
> >   CC      drivers/usb/host/pci-quirks.o
> >   LD      drivers/usb/host/built-in.o
> >  
> > Sorry? How comes it still compiles something into main kernel?
> 
> It's just a quirk of the build machinery.
> The built-in.o file should be 8 bytes or so, with nothing
> really in it.

Not so.  Randy, you missed the line for pci-quirks.o.  It really is a 
non-trivial object file and it really goes into the main kernel.

That's because it actually is a PCI driver, living in a USB source 
directory.  It handles the quirks needed by various PCI-based USB host 
controllers.

Alan Stern

