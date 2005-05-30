Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVE3QJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVE3QJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVE3QJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:09:46 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:2731 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261634AbVE3QJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:09:37 -0400
Date: Mon, 30 May 2005 18:09:36 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
In-Reply-To: <1117454144.2685.174.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net> 
 <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
 <1117454144.2685.174.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Alan Cox wrote:

> On Llu, 2005-05-30 at 03:47, Mikulas Patocka wrote:
> > > In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz> you wrote:
> > > > I think Linux should stop accessing all disks in RAID-5 array if two disks
> > > > fail and not write "this array is dead" in superblocks on remaining disks,
> > > > efficiently destroying the whole array.
>
> It discovered the disks had failed because they had outstanding I/O that
> failed to complete and errorred.

I think that's another problem --- when RAID-5 is operating in degraded
mode, the machine must not crash or volume will be damaged (sectors
that were not written may be damaged this way). Did anybody develop some
method to care about this (i.e. something like journaling on raid)? What
do hardware RAID controllers do in this situation?

> At that point your stripes *are*
> inconsistent. If it didn't mark them as failed then you wouldn't know it
> was corrupted after a power restore. You can then clean it fsck it,
> restore it,
> use mdadm as appropriate to restore the volume and check it.

I can't because mdadm is on that volume ... I solved it by booting from
floppy and editing raid superblocks with disk hexeditor but not every user
wants to do it; there should be at least kernel boot parameter for it.

> > But root disk might fail too... This way, the system can't be taken down
> > by any single disk crash.
>
> It only takes on disk in an array to short 12v and 5v due to a component
> failure to total the entire disk array, and with both IDE and SCSI a
> drive fail can hang the entire bus anyway.

I meant mechanical failure which is more common. Of course --- everything
can happen in case of electrical failure in disk/controller/bus/mainboard
...

Mikulas

> Alan
>
