Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUBJRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUBJRur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:50:47 -0500
Received: from [217.157.19.70] ([217.157.19.70]:41489 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S266120AbUBJRrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:47:46 -0500
Date: Tue, 10 Feb 2004 17:47:44 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: ATARAID userspace configuration tool
In-Reply-To: <402916F8.8050008@pobox.com>
Message-ID: <Pine.LNX.4.40.0402101743020.28534-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Jeff Garzik wrote:

> > On top of this it would be useful to make the underlying devices
> > inaccessible after the mapped device is created (to prevent people from
> > doing things like fdisk /dev/hda, when what they really wanted was
> > something like fdisk /dev/ataraid/disc).
>
> This would be something to talk with the md maintainer about, I think.
> I'm not sure we want to do this, since the user may have a valid reason
> to access the underlying disk.

That's true of course, one example would be to remove the RAID superblock
with dd. The problem is if this is done by mistake, it could be
catastrophic. It might be enough to remove the wrong partitions (with
BLKPG_DEL_PARTITION, thanks to Matt Domsch for pointing me in the right
direction), it will at least prevent mkfs /dev/hda1 etc, which would have
unforeseeable consequences.

But when the RAID/DM device is up, would it not be possible to generate an
EACCESS or EINUSE error if someone tries to open the underlying device? If
he really wants to do it, he can just stop the DM device first.

// Thomas

