Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUIWSRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUIWSRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUIWSOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:14:01 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:27266 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268214AbUIWSL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:11:29 -0400
Date: Thu, 23 Sep 2004 19:12:20 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.8.1 doesn't boot on x86_64
In-Reply-To: <Pine.LNX.4.44.0409231827580.2275-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0409231908070.2756-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have now reverted kdb patches and the system boots fine, both as smp and
as nosmp. The kdb patches which I applied to 2.6.8.1 were:

kdb-v4.4-2.6.8-common-1.bz2
kdb-v4.4-2.6.8-x86-64-1.bz2

downloaded from oss.sgi.com. It may still be a problem with base kernel 
which kdb just triggered --- who knows...

Kind regards
Tigran

On Thu, 23 Sep 2004, Tigran Aivazian wrote:

> booting with nosmp panics dereferencing NULL pointer and the stack trace 
> (ignoring offsets) looks like this:
> 
> sysfs_hash_and_remove
> sysfs_remove_link
> class_device_dev_unlink
> class_device_del
> class_device_unregister
> scsi_remove_host
> ata_host_remove
> ata_device_add
> ata_pci_init_one
> piix_init_one
> pci_device_probe_static
> __pci_device_probe
> bus_match
> driver_attach
> bus_add_driver
> driver_register
> pci_register_driver
> piix_init
> child_rip
> 
> Btw, in this context I noticed something interesting earlier (with Fedora 
> Core 2 kernels) --- if I plug in the second SATA disk to the 3 
> channel then Linux only detects the first SATA disk and the second host 
> thread just exists. I didn't know if it's a bug or expected behaviour so I 
> just plugged in the second SATA disk into the first controller so I get 
> sda and sdb disks and everything works fine (with FC2 kernel, not 
> 2.6.8.1).
> 
> I cc'd Jeff Garzik as the functions on the stack (ata bits) seem to belong
> to his area. Jeff, this is booting 2.6.8.1 with "nosmp" on an x86_64 with
> two SATA disks (sda and sdb). Booting without "nosmp" hangs as described
> below. Booting with "nosmp" panics as described above.
> 
> Kind regards
> Tigran
> 
> On Thu, 23 Sep 2004, Tigran Aivazian wrote:
> 
> > Hello,
> > 
> > I haven't heard about it on x86_64 discuss list so I thought it is worth 
> > asking if someone else has encountered this. When I boot 2.6.8.1 kernel 
> > (patched with kdb) the last thing I see is:
> > 
> > Freeing unused kernel memory: 160k f
> > 
> > I don't get the whole word "freed", only the first letter "f". This is SMP 
> > kernel. I will try recompiling without kdb and also booting as "nosmp" to 
> > see if it makes any difference.
> > 
> > Fedora Core 2 smp kernel boots fine, btw.
> > 
> > Kind regards
> > Tigran
> > 
> > 
> > 
> 
> 
> 

