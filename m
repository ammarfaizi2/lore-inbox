Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCIEfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCIEfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCIEfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:35:17 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:30541 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261506AbVCIEfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:35:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FHJzEgs6aqCEGfR4JccuvFRQQYx9XpGor+q8ksfNVDiJiXdxJ5fnmdXx5FgurYjKmGZmuR0jADmrTABS+KIPWq8Tw1bYznp1oif1zprFD8Ri1s8DxGFTgRXB87ENvrVT3TjEBAVFgPwjQGeg6OpMRKXfExWdyMQ4yfjNKWu+EyM=
Message-ID: <9e4733910503082035318e9d23@mail.gmail.com>
Date: Tue, 8 Mar 2005 23:35:09 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110340398.32557.36.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
	 <1110340398.32557.36.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from /linux-2.5/Documentation/filesystems/sysfs-pci.txt. It
describes how ia64 is achieving legacy IO.  The VGA control code
probably needs to be coordinated with this.

--------------------------------------------------------------------------

Accessing legacy resources through sysfs

Legacy I/O port and ISA memory resources are also provided in sysfs if the
underlying platform supports them.  They're located in the PCI class heirarchy,
e.g.

        /sys/class/pci_bus/0000:17/
        |-- bridge -> ../../../devices/pci0000:17
        |-- cpuaffinity
        |-- legacy_io
        `-- legacy_mem

The legacy_io file is a read/write file that can be used by applications to
do legacy port I/O.  The application should open the file, seek to the desired
port (e.g. 0x3e8) and do a read or a write of 1, 2 or 4 bytes.  The legacy_mem
file should be mmapped with an offset corresponding to the memory offset
desired, e.g. 0xa0000 for the VGA frame buffer.  The application can then
simply dereference the returned pointer (after checking for errors of course)
to access legacy memory space.

Supporting PCI access on new platforms

In order to support PCI resource mapping as described above, Linux platform
code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
Platforms are free to only support subsets of the mmap functionality, but
useful return codes should be provided.

Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
wishing to support legacy functionality should define it and provide
pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.


-- 
Jon Smirl
jonsmirl@gmail.com
