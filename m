Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbUAGUxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUAGUxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:53:05 -0500
Received: from ns.suse.de ([195.135.220.2]:42216 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265612AbUAGUwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:52:51 -0500
Date: Wed, 7 Jan 2004 21:52:37 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107205237.GB16832@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 07, Linus Torvalds wrote:

> 
> 
> On Fri, 2 Jan 2004, Greg KH wrote:
> > 
> > Doesn't the kernel always create the main block device for this device?
> > If so, udev will catch that.
> 
> But udev should probably also create all the sub-nodes if it doesn't 
> already.
> 
> And it really has to create _all_ of them, exactly because there's no way
> to know ahead-of-time which of them will be available.
> 
> Then, user space can just access "/dev/sda1" or whatever, and the act of 
> accessing it will force the re-scan.

How would that work? I mean, what will a tool that cares about a block
event do? It will run a fdisk/parted -l /udev/sda to figure out what partitions
are there (just to skip an extended partition sda5, as example) and
finds no media. That tool will never run again on sda, unless a new
block add event comes in. So some sort of polling is required for that
class of devices.

If we create sda1 - sda15, you mean a mount /udev/sda15 /mnt is supposed
to fail with -ENODEV instead of -ENOENT? 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
