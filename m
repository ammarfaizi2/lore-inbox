Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQJaEIg>; Mon, 30 Oct 2000 23:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQJaEIQ>; Mon, 30 Oct 2000 23:08:16 -0500
Received: from web2103.mail.yahoo.com ([128.11.68.247]:21515 "HELO
	web2103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130108AbQJaEIH>; Mon, 30 Oct 2000 23:08:07 -0500
Message-ID: <20001031040805.24819.qmail@web2103.mail.yahoo.com>
Date: Mon, 30 Oct 2000 20:08:05 -0800 (PST)
From: Steven Walter <srwalter@yahoo.com>
Subject: UDMA/66 Data Corruption on SiS530
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently, when trying to use UDMA/66 on my SiS 530 and
WD84AA, I got some data corruption.  At first, I tried
with "UDMA Enabled" set to off in the BIOS, because I
had known this to previously cause problems.  However,
like this, I couldn't set the harddrive to use UDMA
mode4 (-X68).  I would set it, it would appear
successful, check with hdparm -i, and it would still
say mode2.  Additionally, there was no speed increase
after the -X68.

Before, on a 40-conductor cable, I was getting 11MB/s
with hdparm -t .  I bought an 80-conductor cable
today, and saw no speed improvement in mode2, which is
the only mode I can set it to.  Something that striked
me as odd about the cable, though, is that the red
wire was broken between the Drive 1 socket and the
Drive 0 socket.  Is this to differentiate the two?

Anyway, what's interesting is what happens after I
turned "UDMA Enabled" on in the BIOS.  Upon booting,
everything appeared normal until just before X
started.  At this point, I got a

dma_intr: hda: status=0x58 { DriveReady SeekComplete
Error}
error=0x0 { }

I'm not sure about the numbers, but I am sure about
the texts.  The drive said there was an error, but no
error was set.  After fooling around with hdparm
(setting the drive to -X68, timing it, etc) I got a
few more identical errors.  Then, I started getting
errors from EXT3-fs regarding invalid/corrupt data. 
This concerned me, so I tried a "shutdown -r now", but
to no avail.  I instead did a SysRq
Sync-Unmount-reBoot.  Upon rebooting, I could no
longer mount my root fs due to "Invalid track type or
session number," or something to that effect.  I tried
using e2fsck, but I can't find a valid superblock on
the root partition.  Other partitions on the drive
remain intact, however.

If anyone can shed any light on this problem, it would
be much appreciated.  I wonder whether this is a linux
bug, or a hardware problem, and if a hardware problem, where?

=====
-Steven
====================================================
"The most foolish mistake we could possibly make would be to allow the subject races to possess arms. History shows that all conquerors who have allowed their subject races to carry arms have prepared their own downfall by doing so."
Adolph Hitler

__________________________________________________
Do You Yahoo!?
Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
