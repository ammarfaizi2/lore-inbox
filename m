Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSBMO0O>; Wed, 13 Feb 2002 09:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBMOZ5>; Wed, 13 Feb 2002 09:25:57 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:19218 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S284933AbSBMOZq>; Wed, 13 Feb 2002 09:25:46 -0500
Date: Wed, 13 Feb 2002 15:25:44 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <E16axOE-0004zX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202131414270.21300-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:

> > Is it supposed to detect a failed disk and *stop* using it?
> 
> Yes, it will stop using it and if appropriate try and do a rebuild

So I guess something went wrong in my case. 
The disk died bad. You could hear (from outsite the rack the PC was
mounted on) a repeated sound of "Ziing -> TOC!". There's no way now to make
a BIOS (or a DOS test tool) detect it.

> > I had a raid1 IDE system, and it was continuosly raising hard errors on
> > hdc (the disk was dead, non just some bad blocks): the net result was that
> > it was unusable - too slow, too busy on IDE errors (a lot of them - even
> > syslog wasn't happy).
> 
> Don't try and do "hot pluggable" IDE raid it really doesn't work out. With
> scsi the impact of a sulking drive is minimal unless you get unlucky

Does the above apply to ATA HW RAID controllers, too? I mean, is it
something strictly related to electrical specs of the interface or
is it possible to find workarounds? (whether a vendor apply them with
success it's another story - I wonder if it's possible in theory)

Anyway, the problem is not replacing the disk, is to have the system
stop using it - automatically, without human action. If you say it is so,
then I just must have been unlucky.

> (I have here a failed SCSI SCA drive that hangs the entire bus merely by
> being present - I use it to terrify HA people 8))

the topic here is data safety, what do HA people know about it? B-)

Again, do HW RAID ATA controllers have an hope to handle a failure better
than the average IDE controllers you find integrated into a typical MB?

Right now, to implement a 2+ disks RAID (sw) with IDE/ATA, I'd put
one disk per channel, on some multi-channel controllers (i.e. some
HPTs you've mentioned below). I'm just curious if RAID HW support brings
something new into the game...  Here I'm considering resilience, not
performance: I know (by experience) that 2 disks in the same channel
is a small gain performance-wise.  I'm tempted to buy an HPT RocketRAID
133 (just to name one): it supports (on paper / web) "disk mirroring,
hot-spare options for automatic array-rebuilds, hot-swap support for
swapping failed disks on the fly [...], and disk failure notification".
I still think SW RAID is better, since I don't really like relying
on a black box (read: some unknown firmware).

> > BTW, given a 2 disks IDE raid1 setup (hda / hdc), does it pay to put a
> > third disk in (say hdb) and configure it as "spare disk"? I've got 
> > concerns about the slave not actually beeing able to operate if the
> > master (hda) fails badly.
> 
> Well placed concerns. I don't know what Andre thinks but IMHO spend the
> extra $20 to put an extra highpoint controller in the machine for the third
> IDE bus.
> 
> Alan
> 

TIA,
.TM.

