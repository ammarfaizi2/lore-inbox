Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135684AbREHFNw>; Tue, 8 May 2001 01:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136742AbREHFNl>; Tue, 8 May 2001 01:13:41 -0400
Received: from 200191137058-dial-user-UOL.acessonet.com.br ([200.191.137.58]:14499
	"EHLO pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S135684AbREHFN0>; Tue, 8 May 2001 01:13:26 -0400
Date: Tue, 8 May 2001 02:13:44 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXT2-fs error with 2.4.4 (using CVS)
Message-ID: <20010508021344.Q15636@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200105080445.f484jxL6000663@webber.adilger.int>
User-Agent: Mutt/1.3.18i
X-Mailer: Mutt/1.3.18i - Linux 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 10:45:59PM -0600, Andreas Dilger wrote:

<skip>

> > May  8 01:11:29 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
> > directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
> > name_len=9

> Since it is always the same inode, I would say it is corrupt.  You need to
> run e2fsck to fix it.  It looks like it is a single-bit error on the disk.
> The rec_len=16404=0x4014.  One (of many possible) valid rec_len would be
> 0x14=20.  To be valid we need name_len <= rec_len <= block size.

OK, I ran.

# fsck -v /dev/ide/host0/bus0/target0/lun0/part3
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/ide/host0/bus0/target0/lun0/part3 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

  159689 inodes used (31%)
    1363 non-contiguous inodes (0.9%)
         # of inodes with ind/dind/tind blocks: 3884/1/0
  408910 blocks used (79%)
       0 bad blocks
			
  145848 regular files
   13624 directories
       0 character device files
       0 block device files
       0 fifos
       2 links
       208 symbolic links (208 fast symbolic links)
       0 sockets
--------
  159682 file

> Chances are, when you run e2fsck, it will fix this dirent, but the rest of
> the directory entries in that block will be moved to lost+found.

Nothing in /usr/local/src/lost+found

> I would suspect a hardware problem, to create a single-bit error (if it
> is such).

I hope not. I know at least my RAM is OK. I installed 256Mb
before booting with 2.4.4 and tested all with memtest86.

CVS couldn't remove mozilla/xpinstall/wizard/windows/nszip
after the process terminated, but
mozilla/xpinstall/wizard/windows/nszip/Entries and
mozilla/xpinstall/wizard/windows/nszip/Tag were updated after
the first EXT2-fs error messages.

Well, everything seems OK for now. Thanks.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
