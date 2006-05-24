Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWEXOHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWEXOHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWEXOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:07:42 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:31544 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751003AbWEXOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:07:41 -0400
Date: Wed, 24 May 2006 16:07:39 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060524140739.GA12022@harddisk-recovery.nl>
References: <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org> <20060512222816.GS27946@ftp.linux.org.uk> <20060512224804.GT27946@ftp.linux.org.uk> <20060512225101.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121559490.3866@g5.osdl.org> <20060512232131.GV27946@ftp.linux.org.uk> <20060512233711.GW27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121647250.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121647250.3866@g5.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 04:50:32PM -0700, Linus Torvalds wrote:
> On Sat, 13 May 2006, Al Viro wrote:
> > 
> > BTW, the best option is to kill bdev_uevent() again.  Short of that,
> > skip PHYSDEV mess if disk doesn't have GENHD_FL_UP.
> 
> I do think the mount/umount events are valid and interesting, so I'd much 
> rather see the second version.
> 
> However, that does beg the question: wouldn't that effectively be what the 
> patch I posted would do? Notably the "disk->driverfs_dev = NULL" part 
> after we've dropped it (the "KOBJ_REMOVE" event move is a separate issue, 
> mixed here into the same patch, but should result in possibly better name 
> generation for the event).
> 
> Basically, onces driverfs_dev has been dropped, we NULL it out, and then 
> the people who use it automatically get the right result.
> 
> Yes? No? "You're a total klutz, Linus, that patch won't actually do 
> anything, because <xyz>"?

Just want to confirm that I can't recreate the SCSI slab error anymore
with your patch (032ebf2620ef99a4fedaa0f77dc2272095ac5863) in the
current -git kernel.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
