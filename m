Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130769AbRAGLqa>; Sun, 7 Jan 2001 06:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130760AbRAGLqU>; Sun, 7 Jan 2001 06:46:20 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:19727 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130486AbRAGLqA>; Sun, 7 Jan 2001 06:46:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: oliver.kowalke@t-online.de (Oliver Kowalke)
Date: Sun, 7 Jan 2001 22:45:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14936.22249.574655.722591@notabene.cse.unsw.edu.au>
Cc: <linux-raid@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.0 + software RAID causes problems
In-Reply-To: message from Oliver Kowalke on Sunday January 7
In-Reply-To: <001b01c0789c$f10398f0$0201a8c0@p3x2nt>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday January 7, oliver.kowalke@t-online.de wrote:
> Hi,
> 
> on my machine (x86) I've debian2.2r2 with kernel 2.2.16 + raidtools 0.9
> running. No problems. Yesterday I installed kern 2.4.0 with the same
> configuration like 2.2.16. I added following to the boot params:
> 
> root=/dev/md0 md=0,/dev/hde1,/dev/hdg1
> 
> If I boot 2.4.0 I can see following:
> 
> ...
> <init of raid>
> raid:0 md-size is 249728 blocks
> raid0: conf->smallest->size is 249728 blocks
> raid0: nb_zone is 1
> raid0: blocking 8 bytes for hash
> md: updating md0 RAID superblock on device                <<<------
> <...>
> ... autorun DONE
> md: loading md0
> ... md0 already autodetected -use raid=noautodetect
> <...>
> Parallelizing fsck version 1.18
> fsck.ext2: No such file or directory while trying to open /dev/md0 (null):
> The superblock could not be read or does not describe a correct ext2
> filesystem.
> 
> 
> The filessystem is clean because I can mount it with kernel 2.2.16 without
> problems. Maybe kernel 2.4.0 does the wrong in updating the RAIS superblock
> on md0.
> Please help!
> 

My guess - based on incomplete info - is that you have compiled in
devfs and told it to automount /dev.
If this could be the case, try booting with the extra option:

   devfs=nomount

The problem would be that /etc/fstab expects to find /dev/md0, but
devfs only provides /dev/md/0 - until devfsd is running, which
presumbly isn't until after fsck completes.

If that isn't the case I need more detail:

1/ I assume that your root filesystem is a raid0 array of /dev/hde1
   and /dev/hdg1.   Is that correct?
2/ What happens when you add the "raid=noautodetect" boot option as
   suggested in the log?
3/ What happens if you boot *without* the md=0,.... option?

NeilBrown


> with regards,
> Oliver
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
