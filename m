Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSAPTa2>; Wed, 16 Jan 2002 14:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSAPTaR>; Wed, 16 Jan 2002 14:30:17 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:3602 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S287307AbSAPTaA>; Wed, 16 Jan 2002 14:30:00 -0500
Date: Wed, 16 Jan 2002 20:29:58 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Greg KH <greg@kroah.com>
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116202958.E18039@devcon.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	David Garfield <garfield@irving.iisd.sra.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <20020115233437.GC29020@kroah.com> <15428.49056.652466.414438@irving.iisd.sra.com> <20020116000117.GD29020@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116000117.GD29020@kroah.com>; from greg@kroah.com on Tue, Jan 15, 2002 at 04:01:17PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:01:17PM -0800, Greg KH wrote:
> 
> This also solves the "coldplug" problem, where you need to load
> pci/usb/foobus drivers _after_ init has started.  To do this you need to
> rely on scanning the busses from userspace and loading the needed
> drivers.  Why reimplement this scanning logic, as the kernel already did
> all of this (and usually did a much better job at it) during the boot
> process before init started.

Hmm. AFAICS this also implies that one would have to put /all/ drivers
for /any/ hardware possibly plugged in at boot time on the initramfs.
Or will /sbin/hotplug provide the ability to just put requests it
can't resolve with the modules on the initramfs into some sort of
queue file, which is read by /sbin/coldplug (or whatever) later on in
the boot process to load drivers for those from the real root fs?

> And this allows lots of horrible "boot over NFS" and other network
> code/hacks in the kernel to be moved out of kernel space, and into
> userspace, where it really belongs.

Having to put all drivers for all PCI/USB/whatever stuff on the
initramfs will likely be a problem (regarding disk space) for people
who need to boot the kernel from a floppy disk without having to
change disks during boot (think of nfsroot without etherboot).

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
