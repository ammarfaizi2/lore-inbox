Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277654AbRJIAPG>; Mon, 8 Oct 2001 20:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277655AbRJIAO5>; Mon, 8 Oct 2001 20:14:57 -0400
Received: from [208.178.176.216] ([208.178.176.216]:64675 "EHLO
	wizardsworks.org") by vger.kernel.org with ESMTP id <S277654AbRJIAOm>;
	Mon, 8 Oct 2001 20:14:42 -0400
Date: Mon, 8 Oct 2001 17:15:12 -0700 (PDT)
From: Sir Ace <chandleg@wizardsworks.org>
To: linux-kernel@vger.kernel.org
Subject: Error in Documentation 
Message-ID: <Pine.LNX.4.21.0110081714100.6095-100000@wizardsworks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aparently I posted this in the wrong place the first time:



  I noticed that in the documentation in the kernel setup
{menuconfig/xconfig} on the alpha platform, under "General Setup",
the option "Use SRM as bootloader" has an error..  {long sentance}

Anyway there is at least one mistake in it:

----------------------------------------------------------------------------

"If MILO doesn't work on your system (true for Jensen motherboards), you
can bypass it altogether and boot Linux directly from an SRM console; say
Y here in order to do that."

--Semi-false
  correction:
Way 1:  Using a boot loader like aboot {recommended} you can boot from SRM
	to linux, and pass flags just like milo. The SRM variables are:
	BOOTDEF_DEV=
	BOOT_FILE=
	BOOT_OSFLAGS=
	The aboot.conf is the place where all the kernel parameters can be
	set, however by just loading the aboot bootstrap you can manually
        type everything in, in a pinch.

Way 2:  {Very cool, but HYPER-Not recomended}  You can load the linux
	kernel directly into the ROM, and boot it directly from there.
	This is not supported on a few of the platforms, but I have seen
	it done, and it is pretty cool.  However, It becomes a pain when
	you have 120 alphas to reflash, no to mention you could error
	and it would render the box useless...

---------------------------------------------------------------------------

"Note that you won't be able to boot from an IDE disk using SRM."

--Way-false

correction:
	If your SRM is current, and the board has IDE, it will boot it..
	OSF/Tru 64 will not recognize the IDE port, SRM however sees it
	fine.  I know this works scince I boot off of a 20 Gig IDE now.

---------------------------------------------------------------------------

using a "show config" in the srm, you will get a listing of all
attached/integrated devices.

SCSI   is normally dka*
IDE    is normally dqa*
Floppy is normally dva*

known issues:  The place that aboot.conf and the kernel live needs to be
on a partition that lives completly withing the first 2 gig of the disk.
I hate seporating /boot out, but if you have a 20 gig root, it will not
work, unless you do so.  The modules for the kernel can reside anywhere,
once the kernel loads far enough to need them, then you already should
have the support for the filesystems that they reside on.  If not you will
be recomiling the damn thing again anyway.

Issue 2, You MUST MUST use bsd partitioning, on a disk not using milo.
If you migrated from a Tru 64/OSF system, you need not blow away the OSF/
disk label, however you do have to turn on the support for OSF in the
advanced filesystem area of the kernel config. Just remember to make sure
the bsd label exists..

Issue 3, You have to waste disk.. With PC partitioning, you can use lilo
without wasting disk..  No such luck with aboot.  You need to loose the
first cylinder of the disk so you can boot. {yes this equates to a lot on
big disks, maybe 2-5 Meg or more} It is necessary.  You partition should
look something like this:

BSD disklabel command (m for help): p
4 partitions:
#	start       end      size     fstype   [fsize bsize   cpg]
a:        1         2         2     unused        0     0
b:        3      1043      1041       ext2
c:        1     39560     39560     unused        0     0
d:     1042     39560     38519       ext2  

where "a" is wasted space for the aboot loader, "b" is /boot or something
useful residing < 2 Gig., "c" is the BSD disklabel, and d-{blahness} are
the rest of your normal partitions.




I've been asked a few times to re-write the alpha/SRM/booting Howto, but
no one has ever told me who to contact about it...  Anyway, I just thought
I should post this long winded thing... :)  Just in case anyone is
wondering, I'm the guy that maintained and ran the 120 node alpha
render farm at Digital Domain {the place that titanic was rendered}, and
helped Chris a little with the alpha port of Slackware. I hope I didn't
step on anyones toes in this. {grin}  

In any event I still have no clue what this option does in the kernel,
scince it can all be done anyway, I just figured I would send this in.

Sir Ace

