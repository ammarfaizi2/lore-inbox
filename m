Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRAaWV1>; Wed, 31 Jan 2001 17:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRAaWVH>; Wed, 31 Jan 2001 17:21:07 -0500
Received: from mdmgrp1-167.accesstoledo.net ([207.43.106.167]:15620 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129237AbRAaWVD>;
	Wed, 31 Jan 2001 17:21:03 -0500
Date: Tue, 30 Jan 2001 17:20:41 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: William Knop <w_knop@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <F148MamEWkeMEwuwi7N000015ef@hotmail.com>
Message-ID: <Pine.LNX.4.21.0101301704290.1832-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, William Knop wrote:
> 
> Correct me if I'm wrong, but DevFS only makes /dev entries when a device is 
> present, and the device is not present until the module is loaded. So if I 
> want to access /dev/hda and the IDE module has not been loaded yet, I will 
>

One thing that I've noticed with devfs is that all the old-style names are
symlinks.  Documentation/filesystems/devfs/README, I think is the file
that describes this.  The actual device file for /dev/hda now is:

/dev/ide/hd/c0b0t0u0

OR

/dev/ide/host0/bus0/target0/lun0/disc

I use the shorter one in my fstab, it makes things neater.  It's also a
symlink, but I would think that symlink will stay longer than /dev/hda
will, anyway.  When I rebuild my system, or get a completely new one,
everything will probably wind up using /dev/ide/host0... etc.

>
> I realize modularizing the entire IDE subsystem is not really good anyway, 
> because every time it reloads it will rescan the bus... But what about USB? 
> Suppose I don't have any IDE or USB devices, but want support so I can use 
> them later. Especially in the case of USB, plugability is a must for desktop 
> "home" systems.
>

Everything is modularized here, including ppp and such, and modprobe is
loading everything quite nicely for me.  I don't like to run one big
kernel, it wastes too much memory, and so I use pretty much *everything*
that I can in modules (IDE I can't, because I boot from IDE, but I leave
SCSI in a module, becuase I use ide-scsi to burn my CDs and it's not
*reqired*).
 
[clipped]
> 
> I read all the FAQs and stuff and found nothing that really addresses this, 
> so here I ask if anyone has any idea as to a solution. No doubt I screwed 
> something up somewhere along the line... If my kernel or XF86 config files 
> are needed, I can pull 'em up and post 'em. Also, please CC responses to me 
> because I'm not currently subscribed.
> 

I can't help you much more than what I've already said, but best of wishes
and luck to you.  I would advise that you traverse through /dev/ though,
and find out how the new organization is... it's *quite* different from
the old method.  The symlinks are only there for backwards compatability
for the time being - however, I'd expect those to be moved out when pretty
much all Linux software is using the new arrangement.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
