Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbRAWP3F>; Tue, 23 Jan 2001 10:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131120AbRAWP2z>; Tue, 23 Jan 2001 10:28:55 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:16634 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131099AbRAWP2p>; Tue, 23 Jan 2001 10:28:45 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101231528.f0NFSbb30649@webber.adilger.net>
Subject: Re: Marking sectors on IDE drives as bad
In-Reply-To: <E7D21F6C2128D41199B600508BCF8D54A9AD67@nosexc01.nwo.cpqcorp.net>
 "from Wahlman, Petter at Jan 23, 2001 11:34:11 am"
To: "Wahlman, Petter" <Petter.Wahlman@compaq.com>
Date: Tue, 23 Jan 2001 08:28:37 -0700 (MST)
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> I'm experiencing some fscking problems due to a defective IDE drive.
> 
> exerpt from /var/log/messages:
> Jan 22 09:31:29 evil kernel: hda: read_intr: status=0x59 { DriveReady
> SeekComplete DataRequest Error }
> Jan 22 09:31:29 evil kernel: hda: read_intr: error=0x01 { AddrMarkNotFound
> }, LBAsect=10262250, sector=1311147
> Jan 22 09:31:29 evil kernel: ide0: reset: success
> Jan 22 09:31:29 evil kernel: hda: read_intr: status=0x59 { DriveReady
> SeekComplete DataRequest Error }
> Jan 22 09:31:29 evil kernel: hda: read_intr: error=0x40 { UncorrectableError
> }, LBAsect=10262250, sector=1311147
> Jan 22 09:31:29 evil kernel: end_request: I/O error, dev 03:05 (hda), sector
> 1311147
> 
> Is it possible to somehow mark the above sector as bad (in ll_rw_block.c or
> similar) to circumvent the problem?

Chances are, you should replace the drive, because this sort of problem
usually gets worse as time goes on.

That said, it is possible for ext2 to mark the sectors bad (assuming you
use ext2 and not reiserfs), and then they will never be used.  You can
use the "badblocks" program in conjunction with e2fsck or mke2fs to mark
the blocks bad in the filesystem.

I would suggest keeping good backups after that.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
