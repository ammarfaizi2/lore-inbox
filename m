Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUAHCDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAHCDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:03:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:16279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263166AbUAHCDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:03:42 -0500
Date: Wed, 7 Jan 2004 18:03:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040107205237.GB16832@suse.de>
Message-ID: <Pine.LNX.4.58.0401071801310.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107205237.GB16832@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Olaf Hering wrote:
> > 
> > Then, user space can just access "/dev/sda1" or whatever, and the act of 
> > accessing it will force the re-scan.
> 
> How would that work? I mean, what will a tool that cares about a block
> event do? It will run a fdisk/parted -l /udev/sda to figure out what partitions
> are there (just to skip an extended partition sda5, as example) and
> finds no media. That tool will never run again on sda, unless a new
> block add event comes in. So some sort of polling is required for that
> class of devices.

What is your problem?

I'll use a very common and simple case that I do myself: use any USB media 
reader to read a camera card. It will be a FAT filesystem on the first 
partition, so your fstab might look like this:

	/dev/sda1               /mnt/smartmedia         vfat    noauto,user,ro  0 0

and then you just do "mount /mnt/smartmedia", and you're done.

This works. I do it all the time. You just stick in your card, and mount 
it, and off it foes. No "fdisk" or "parted" _anywhere_.

		Linus
