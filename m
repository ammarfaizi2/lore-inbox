Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131910AbQL0VzX>; Wed, 27 Dec 2000 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131834AbQL0VzO>; Wed, 27 Dec 2000 16:55:14 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:52288 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S131807AbQL0Vyx>; Wed, 27 Dec 2000 16:54:53 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Gnea" <gnea@rochester.rr.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: more VIA chipset weirdness...
X-Mailer: Pronto v2.2.2
Date: 27 Dec 2000 16:17:48 EST
Reply-To: "Gnea" <gnea@rochester.rr.com>
Message-ID: <20001227211334.AAA24006@mail2.nyroc.rr.com@celery>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andre, you do an outstanding job and I hope you can help point me
in the proper direction on this one...

the basic deal here is that i've got an ASUS A7V motherboard (with the
dip switch to overclock too.. too bad it's not mine tho heh) with an
AMD Duron 600 cpu and 128 megs of pc133 ram.. i've disconnected
everything from ide0 and ide1 (only had that pesky toshiba cdrom
attached to ide0/hda for awhile... seems to be really problematic with
VIA chipsets... i'm about ready to toss the fucker against the cement
wall here... but i won't) and so the only device connected would be the
IBM-DJNA-371800 hard drive (sound familiar? it's the same one from last
time) ata66 on the ata100 controller (kt133 iirc)... now, 2.2.17 won't
detect anything off the bat... so i compiled a 240t11 kernel for it...
worked GREAT! then i decided that it would be easier to share files in
this dual-boot environment (i'm having it boot debian linux and
win98se) by converting one of the non-volitale partitions to fat32...
well, in attempting to do so, it appears i have hosed the partition
table... now i can't even boot a rescue image to fix it!  what's even
STRANGER is that, for some really odd reason, the kernel attempts to
probe for hda-hdf when it boots and gets nothing for them because
there's nothing there... it SEEMS to find hde just fine, then halfway
through the fsck, i get the following now:

/dev/hde6: Inode 373609 has illegal block(s).

/dev/hde6: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
	(i.e., without -a or -p options)
fsck.ext2: No such file or directory while trying to open /dev/hde7
(null):
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and no swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate
superblock:
    e2fsck -b 8193 <device>

fsck failed.  Please repair manually.

and it tells me to do the ^D or root pw dilly...

so then i'll go ahead and attempt a e2fsck -y /dev/hde6... i've done
this before so it's no real big deal for me.. but i got a lot of really
interesting messages that i don't recall seeing before such as REALLY
LARGE Inode bitmap differences tables.... literally pages and pages of
them... possibly because it is an 18gig hard drive? i'm thinking that
is the case... but also suppose the fact that the kernel DOES call it
an ata(33) device while it is indeed an ata(66) device that is even
connected to an ata(100) controller makes my head spin.. i've tried
looking at docs and previous posts and i just can't find anything that
pertains to this situation... maybe i didn't look hard enough?	if not,
could someone else possibly point me to the proper post(s)?  i
apologize ahead of time if this post seems foolish... i'm nearly ready
to start a complete boycott of anything that has a VIA chipset on it,
but I'm not THAT desperate or crazy ;)

finally, fdisk -l /dev/hde just does not work at all anymore.  like i
said, i can't even boot a rescue floppy for this sort of thing... even
after fixing hde6, a reboot still causes it to mount things read-only,
so things like /dev/urandom don't work and a boot is utterly
impossible.. even win98 can't boot... i suppose the only thing left is
a low-level format on the hd, but that is impossible since the promise
chipset on there doesn't allow it.


-- 
	.oO gnea at rochester dot rr dot com Oo.
	    .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish" -unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
