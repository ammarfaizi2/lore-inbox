Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVCIFl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVCIFl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCIFl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:41:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:29112 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261414AbVCIFlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:41:53 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910503082035318e9d23@mail.gmail.com>
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
	 <1110340398.32557.36.camel@gaston>
	 <9e4733910503082035318e9d23@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 16:37:13 +1100
Message-Id: <1110346634.32556.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 23:35 -0500, Jon Smirl wrote:
> This is from /linux-2.5/Documentation/filesystems/sysfs-pci.txt. It
> describes how ia64 is achieving legacy IO.  The VGA control code
> probably needs to be coordinated with this.

This is a different thing, and I will implement it on ppc one of these
days. This is for issuing the IO cycles on the bus. It has nothing
to do with the actual arbitration work.

> --------------------------------------------------------------------------
> 
> Accessing legacy resources through sysfs
> 
> Legacy I/O port and ISA memory resources are also provided in sysfs if the
> underlying platform supports them.  They're located in the PCI class heirarchy,
> e.g.
> 
>         /sys/class/pci_bus/0000:17/
>         |-- bridge -> ../../../devices/pci0000:17
>         |-- cpuaffinity
>         |-- legacy_io
>         `-- legacy_mem
> 
> The legacy_io file is a read/write file that can be used by applications to
> do legacy port I/O.  The application should open the file, seek to the desired
> port (e.g. 0x3e8) and do a read or a write of 1, 2 or 4 bytes.  The legacy_mem
> file should be mmapped with an offset corresponding to the memory offset
> desired, e.g. 0xa0000 for the VGA frame buffer.  The application can then
> simply dereference the returned pointer (after checking for errors of course)
> to access legacy memory space.
> 
> Supporting PCI access on new platforms
> 
> In order to support PCI resource mapping as described above, Linux platform
> code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
> Platforms are free to only support subsets of the mmap functionality, but
> useful return codes should be provided.
> 
> Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
> wishing to support legacy functionality should define it and provide
> pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.
> 
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

