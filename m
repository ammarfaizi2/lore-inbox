Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756682AbWKVTMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbWKVTMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbWKVTMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:12:51 -0500
Received: from mx6.mail.ru ([194.67.23.26]:5460 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1756682AbWKVTMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:12:50 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [linux-usb-devel] 2.6.19-rc5: modular USB rebuilds vmlinux?
Date: Wed, 22 Nov 2006 22:12:43 +0300
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200611222145.59560.arvidjaar@mail.ru> <20061122105454.aa5c0f3d.randy.dunlap@oracle.com>
In-Reply-To: <20061122105454.aa5c0f3d.randy.dunlap@oracle.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611222212.44360.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 22 November 2006 21:54, Randy Dunlap wrote:
> On Wed, 22 Nov 2006 21:45:55 +0300 Andrey Borzenkov wrote:
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
>

yes, but it still costs extra vmlinuz build when just to rebuild of a single 
module (or subsystem as was in this case) is needed. And this implies also 
reboot - how should one know if this is safe to leave current kernel with new 
modules?

> >  {pts/0}% grep USB build/linux-2.6.19/.config | grep -v '^#'
> > CONFIG_USB_ARCH_HAS_HCD=y
> > CONFIG_USB_ARCH_HAS_OHCI=y
> > CONFIG_USB_ARCH_HAS_EHCI=y
> > CONFIG_USB=m
> > CONFIG_USB_DEBUG=y
> > CONFIG_USB_DEVICEFS=y
> > CONFIG_USB_BANDWIDTH=y
> > CONFIG_USB_DYNAMIC_MINORS=y
> > CONFIG_USB_SUSPEND=y
> > CONFIG_USB_OHCI_HCD=m
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_ACM=m
> > CONFIG_USB_PRINTER=m
> > CONFIG_USB_STORAGE=m
> > CONFIG_USB_STORAGE_DATAFAB=y
> > CONFIG_USB_STORAGE_FREECOM=y
> > CONFIG_USB_STORAGE_ISD200=y
> > CONFIG_USB_STORAGE_DPCM=y
> > CONFIG_USB_STORAGE_USBAT=y
> > CONFIG_USB_STORAGE_SDDR09=y
> > CONFIG_USB_STORAGE_SDDR55=y
> > CONFIG_USB_STORAGE_JUMPSHOT=y
> > CONFIG_USB_KBD=m
> > CONFIG_USB_MOUSE=m
> > CONFIG_USB_SERIAL=m
> > CONFIG_USB_SERIAL_GENERIC=y
> > CONFIG_USB_SERIAL_PL2303=m
>
> ---
> ~Randy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFZKEsR6LMutpd94wRAugsAJ9aGrMgXmRXwSHPsg7CVPHXLUSc2QCdFoij
akMXiiVn6VJJ653qvL8w0f8=
=qvQ4
-----END PGP SIGNATURE-----
