Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289795AbSAPAfH>; Tue, 15 Jan 2002 19:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290300AbSAPAe6>; Tue, 15 Jan 2002 19:34:58 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:35716 "EHLO
	aldebaran.sra.com") by vger.kernel.org with ESMTP
	id <S289795AbSAPAek>; Tue, 15 Jan 2002 19:34:40 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.51789.430278.700907@irving.iisd.sra.com>
Date: Tue, 15 Jan 2002 19:33:17 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <20020116000117.GD29020@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
	<20020115233437.GC29020@kroah.com>
	<15428.49056.652466.414438@irving.iisd.sra.com>
	<20020116000117.GD29020@kroah.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > But how do you always know what is "needed"?  Wouldn't it be nice to
 > just select "compile all SCSI PCI and IEEE1394 and USB drivers as
 > modules" and then have your "real" root partition's controller be
 > automatically found before you try to mount your "real" root partition?

One knows what is needed because one knows or determines what it takes
to access ones real root partition.

 > Say your SCSI PCI controller dies, and you buy a new one.  Plop it in,
 > reboot, and everything works.  No having to build a new initrd, or build
 > in _all possible_ SCSI PCI drivers.

Except that what you have just proposed requires that you "build in
_all possible_ SCSI PCI drivers" as modules in the initramfs.  Little
gain, except that some things won't be retained.

Further, I don't thing I would expect a system with a changed SCSI PCI
controller to boot on a kernel specifically built for the previous
controller.  I don't think I would even want it to boot.  Better I
think to get out a rescue disk of some sort, boot from that,
reconfigure a built kernel for the new hardware (in the new case,
simply reconstructing the initramfs), and reboot from that.



 > Right now you can't have your "real" root partition on a USB drive,
 > without a horrible "let's wait forever" patch to your kernel.
 > 
 > This also solves the "coldplug" problem, where you need to load
 > pci/usb/foobus drivers _after_ init has started.  To do this you need to
 > rely on scanning the busses from userspace and loading the needed
 > drivers.  Why reimplement this scanning logic, as the kernel already did
 > all of this (and usually did a much better job at it) during the boot
 > process before init started.
 > 
 > And this allows lots of horrible "boot over NFS" and other network
 > code/hacks in the kernel to be moved out of kernel space, and into
 > userspace, where it really belongs.

Well, I agree that the new solution does solve some problems.


What I am worried about is not *allowing* user mode code in the
initramfs, but *requiring* it.


--David Garfield
