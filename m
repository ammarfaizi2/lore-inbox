Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUAKTfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUAKTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:35:16 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:25289 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265966AbUAKTfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:35:04 -0500
Subject: Re: [dm-devel] kernel 2.6 biosraid via device mapper - partition
	support
From: Christophe Saout <christophe@saout.de>
To: dm-devel@sistina.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <40016A11.90605@gmx.at>
References: <40016A11.90605@gmx.at>
Content-Type: text/plain
Message-Id: <1073849697.24036.11.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 20:34:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 11.01.2004 schrieb Wilfried Weissmann um 16:21:

> i just started to investigate how biosraid support for the HPT37X 
> IDE-chipsets can be implemented in the 2.6 kernel. implementing the 
> basic raid levels (0, 1, 0+1, JBOD) seems to be pretty straight forward.

Yepp.

> this can be done by reading the raid signatures of the disks and then 
> pipeing the configuration through dmsetup or using the libdevmapper 
> library directly. what bothers me is the partition support. the number 
> of minor device nodes that are registered per mapped block device is 1. 
> this means that there is no way that the kernel does the 
> partition-handling by itself.

Yepp.

> the alternative is to do the partition 
> scanning in userspace and to use another device mapper layer to create 
> the partition device nodes. it appears that this was already suggested 
> by Christophe Varoqui ( http://lwn.net/Articles/13958/ ) but this 
> project is now idle.

Some people have written scripts to run in initrd for this the last
time. Using sfdisk -ld and shell scripts is very simple though not a
solution for everything, just for now.

> this also has the disadvantage that any changes in 
> the partitioning of the raid volume (e.g. by using *fdisk, distribution 
> installers, ...) require a manual re-invocation of the biosraid setup 
> tool. plus the whole code under linux/fs/partitions/... has to be 
> duplicated so that not only the dos partitioning scheme is supported, 
> but also BSD slices, x86 solaris, windows dynamic disks, ...

The plan for Linux 2.7 is to rip out partition detection from the kernel
and do everything in userspace (probably initramfs). So someone could
start by making the partition detection code a library.

The detection script/program could then be run from udev (the hotplug
interface) when a new block device is created.

I don't know what can be done about the ioctl that tells the kernel to
reread the partition table. It could either be dropped or make the
kernel create a hotplug event but that seems rather ugly.

> which way to go? is there another solution that i have missed?

I think you're on the right way. But you see there are still a lot of
issues to be discussed.


