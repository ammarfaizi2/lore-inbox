Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRDUQkn>; Sat, 21 Apr 2001 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDUQke>; Sat, 21 Apr 2001 12:40:34 -0400
Received: from ns.suse.de ([213.95.15.193]:22794 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132742AbRDUQkW>;
	Sat, 21 Apr 2001 12:40:22 -0400
Date: Sat, 21 Apr 2001 18:40:01 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: ville.holma@pp.htv.fi
Subject: Re: a way to restore my hd ?
Message-ID: <20010421184001.C22420@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, ville.holma@pp.htv.fi
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>; from ville.holma@pp.htv.fi on Sat, Apr 21, 2001 at 06:52:01PM +0300
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 06:52:01PM +0300, Ville Holma wrote:
...
> 
> debian:~# e2fsck /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> Corruption found in superblock.  (frags_per_group = 2147516416).
> 
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b -2147450879 <device>
> 
> 
> So I tried to use the huge block size like e2fsck suggests and I get this
> 
> 
> debian:~# e2fsck -b -2147450879 /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> e2fsck: Attempt to read block from filesystem resulted in short read while
> trying to open /dev/hdb7
> Could this be a zero-length partition?
> 
> 
> This is where the human panic occured. There is data on that partition that
> I _really_ do not want to loose. I'm clueless and woud appreciate any
> help/suggestions. If some additonal information is needed I'm more than
> happy to deliver.

I run in similar trouble last week after a power breakage.
My superblock was also corupted and I got also the message to try an other
superbock, but I don't know at which address it was (e2fsck don't show you
the correct addresses, it gives only a syntax example). Remembering that
mke2fs shows it, I use it with the test option "-n" (so it only simulate
the making of a filesystem) and got the addresses for the spare superblocks
and was able to recover the filesystem with no data lost.

example:
pingi:~ # mke2fs -n /dev/sdb3

mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
91392 inodes, 182739 blocks
9136 blocks (5.00%) reserved for the super user
First data block=0
6 block groups
32768 blocks per group, 32768 fragments per group
15232 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840

Don't miss the -n option !!!

e2fsck -b 32768 /dev/sdb3

Here are also some howtos related to restoring data and undelete files.

-- 
Karsten Keil
SuSE Labs
ISDN development
