Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTJZRIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTJZRIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:08:13 -0500
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:26375 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S263325AbTJZRII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:08:08 -0500
Subject: Re: PowerMac 8500 (summary)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1ABctv-0002Jd-00@penngrove.fdns.net>
References: <E1ABctv-0002Jd-00@penngrove.fdns.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067131929.3484.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 26 Oct 2003 02:32:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 18:28, John Mock wrote:

> PowerMac 8500 (PPC) has more serious problems, its console display is broken
> and it currently cannot come up multi-user, making it difficult to examine 
> the problem.  Eventually, i'll hook up a serial console and at least look 
> at that problem.  Since 2.4.21 works fine for me, this isn't a major issue 
> for me personally.  Given our winter power and summer heat, i wish software
> suspend worked for the PPC...
> 
> Attached is a summary of the current issues for me, please write if you
> would like additional details on any of these, especially those not yet
> reported on.

Regarding the pmac 8500, I'd appreciate some tests with the kernel
at bk://ppc.bkbits.net/linuxppc-2.5-benh

Also, please CC me issues relative to PowerMacs in general, or at
least CC them to linuxppc-dev, as I may miss them in the lkml traffic.

> Outstanding issues for PowerMac 8500
> 
>   'drivers/block/swim3.c' won't compile, seems to be missing a couple of
> 	#includes's (and still gets a couple of warnings).  Bug report filed,
> 	temporary patch suggested.

Real patch on the way. Right now, Linus tree is frozen regarding my
driver updates though, and it's ok as far as I'm concerned, I think
we'll have pmac support fully merged with 2.6.0.
 
>   Many other modules get compilation warnings.  Bug report filed.

CC me please, and test my tree as it's where the patches will come
from ultimately ;)

>   PPC gets one 'oops' per SCSI disk during boot up.  Bug report filed.

Known problem. Seem to be a HW bug triggered by the slab debug code,
I need to spend more time figuring out exactly what's going on in the
chip.

>   Contrary to earlier reports, RAID5 seems to work fine on PPC (on -test7 at
> 	least).

Good.

>   Console comes up in an unusable video mode, specifically, sync is good, but
> 	it appears to have wrong number of bits per scanline.

There are several problems with controlfb and the new fbcon that I
haven't fully figured out yet. Though it works for me when I boot
(but strangely fails when I switch back to VT from X).

>   X eventually resets it to good video mode on test7-bk7, but X doesn't work
> 	with an ADB keyboard (and it even doesn't get that far under -test8)

Ah ? Works fine here.

>   Currently can only test over network (and as noted, test7-bk7 was last
> 	kernel i tried that even got that far.
> 
>   May no longer fit on floppy, somewhat dangerous given i can't boot from CD
> 	(not even MacOS) and have RAID5 root/usr.

I fixed vmlinux.coff so it boots from network at least, quik should work
with small kernels, but I posted a quik patch that may help with larger
kernels. I plan to add yaboot support for oldworld sooner or later that
will deal with that issue as well.
