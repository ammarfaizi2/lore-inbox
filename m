Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRKGWjH>; Wed, 7 Nov 2001 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281037AbRKGWi6>; Wed, 7 Nov 2001 17:38:58 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:17836 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S281024AbRKGWip>; Wed, 7 Nov 2001 17:38:45 -0500
Date: Wed, 7 Nov 2001 23:40:25 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011107234025.A602@zodiak.ecademix.com>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com> <20011107224824.G26218@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107224824.G26218@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Nov 07, 2001 at 10:48:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mhhh,
the strace output from the 'login: root' one (the one which was good)
looks the same till the EFBIG place:

	write(1, "\10\10\10\10\10", 5)          = 5
	write(1, "16/44", 5)                    = 5
	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768
	_llseek(4, 18446744071562117120, [2147532800], SEEK_SET) = 0
	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768
	_llseek(4, 18446744071562149888, [2147565568], SEEK_SET) = 0
	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768
	_llseek(4, 18446744071562182656, [2147598336], SEEK_SET) = 0
	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = 32768

Peter

On Wed, Nov 07, 2001 at 10:48:24PM +0200, Ville Herva wrote:
> On Wed, Nov 07, 2001 at 06:47:10PM +0100, you [Peter Seiderer] claimed:
> > Hello,
> > tried today to mkfs.ext2 a partition of my disk and detected there is
> > a little difference between 'login: root' and 'su -'.
> > 
> > First I tried it this way:
> > 
> > 	Welcome to SuSE Linux 7.0 (i386) - Kernel 2.4.14 (tty1).
> > 
> > 	zodiak login: seiderer
> > 	Password:
> > 	seiderer@zodiak:~ > su -
> > 	Password:
> > 	zodiak:~ #
> > 	zodiak:~ # mkfs.ext2 /dev/hdc4
> > 	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> > 	Filesystem label=
> > 	OS type: Linux
> > 	Block size=4096 (log=2)
> > 	Fragment size=4096 (log=2)
> > 	716672 inodes, 1432116 blocks
> > 	71605 blocks (5.00%) reserved for the super user
> > 	First data block=0
> > 	44 block groups
> > 	32768 blocks per group, 32768 fragments per group
> > 	16288 inodes per group
> > 	Superblock backups stored on blocks:
> > 	        32768, 98304, 163840, 229376, 294912, 819200, 884736
> > 
> > 	Writing inode tables: 16/44File size limit exceeded
> > 
> > strace showed that write returned wit EFBIG and the process ended with SIGXFSZ:
> > 
> > 	write(1, "\10\10\10\10\10", 5)          = 5
> > 	write(1, "16/44", 5)                    = 5
> > 	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
> > 	write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = -1 EFBIG (File too large)
> > 	--- SIGXFSZ (File size limit exceeded) ---
> > 	+++ killed by SIGXFSZ +++
> 
> Hmm, 18446744071562084352 = 0xffffffff80004000, 2147500032 = 0x80004000...
> It looks a tad like llseek's offset_high would have been corrupted...
> Strange.
> 
> 1432116 blocks * 4096 bytes/block * 16/44 written = 2133071685.81818 so
> 2147500032 looks sane(ish).
> 
> 
> -- v --
> 
> v@iki.fi

