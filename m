Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281189AbRKHAgp>; Wed, 7 Nov 2001 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281188AbRKHAgf>; Wed, 7 Nov 2001 19:36:35 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:53399 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S281189AbRKHAgV>; Wed, 7 Nov 2001 19:36:21 -0500
Date: Thu, 8 Nov 2001 01:39:51 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Cc: "Sartorelli, Kevin" <SarKev@topnz.ac.nz>
Subject: Re: [linux-kernel] What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108013951.A1471@zodiak.ecademix.com>
In-Reply-To: <4B2093FFC31B7A45862B62A376EA717690CE00@mickey.topnz.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4B2093FFC31B7A45862B62A376EA717690CE00@mickey.topnz.ac.nz>; from SarKev@topnz.ac.nz on Thu, Nov 08, 2001 at 07:58:05AM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I tried your tip, but it did not help in my case, sorry....
I do not think it is an easy ulimit case, see output of getrlimit(RLIMIT_FSIZE).
Cheers
Peter

On Thu, Nov 08, 2001 at 07:58:05AM +1300, Sartorelli, Kevin wrote:
> I struck the same error, and found it was a limit of the shell.  using
> bash and doing ulimit -f 10240000 (unlimited) fixed the problem for me.
> I think that if you su from one user to another, the underlying shell
> can still affect things (like ulimit).
> 
> Cheers
> Kevin
> 
> -----Original Message-----
> From: Peter Seiderer [mailto:Peter.Seiderer@ciselant.de]
> Sent: Thursday, 8 November 2001 6:47 a.m.
> To: linux-kernel@vger.kernel.org
> Subject: [linux-kernel] What is the difference between 'login: root' and
> 'su -' ?
> 
> 
> Hello,
> tried today to mkfs.ext2 a partition of my disk and detected there is
> a little difference between 'login: root' and 'su -'.
> 
> First I tried it this way:
> 
> 	Welcome to SuSE Linux 7.0 (i386) - Kernel 2.4.14 (tty1).
> 
> 	zodiak login: seiderer
> 	Password:
> 	seiderer@zodiak:~ > su -
> 	Password:
> 	zodiak:~ #
> 	zodiak:~ # mkfs.ext2 /dev/hdc4
> 	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> 	Filesystem label=
> 	OS type: Linux
> 	Block size=4096 (log=2)
> 	Fragment size=4096 (log=2)
> 	716672 inodes, 1432116 blocks
> 	71605 blocks (5.00%) reserved for the super user
> 	First data block=0
> 	44 block groups
> 	32768 blocks per group, 32768 fragments per group
> 	16288 inodes per group
> 	Superblock backups stored on blocks:
> 	        32768, 98304, 163840, 229376, 294912, 819200, 884736
> 
> 	Writing inode tables: 16/44File size limit exceeded
> 
> strace showed that write returned wit EFBIG and the process ended with
> SIGXFSZ:
> 
> 	write(1, "\10\10\10\10\10", 5)          = 5
> 	write(1, "16/44", 5)                    = 5
> 	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
> 	write(4,
> "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = -1
> EFBIG (File too large)
> 	--- SIGXFSZ (File size limit exceeded) ---
> 	+++ killed by SIGXFSZ +++
> 
> When login in directly from the console as root everything went right:
> 	Welcome to SuSE Linux 7.0 (i386) - Kernel 2.4.14 (tty1).
> 
> 	zodiak login: root
> 	Password:
> 	zodiak:~ # mkfs.ext2 /dev/hdc4
> 	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> 	Filesystem label=
> 	OS type: Linux
> 	Block size=4096 (log=2)
> 	Fragment size=4096 (log=2)
> 	716672 inodes, 1432116 blocks
> 	71605 blocks (5.00%) reserved for the super user
> 	First data block=0
> 	44 block groups
> 	32768 blocks per group, 32768 fragments per group
> 	16288 inodes per group
> 	Superblock backups stored on blocks:
> 	        32768, 98304, 163840, 229376, 294912, 819200, 884736
> 
> 	Writing inode tables: done
> 	Writing superblocks and filesystem accounting information: done
> 	zodiak:~ #
> 
> The RLIMIT_FSIZE showed in both cases the same values:
> getrlimit(RLIMIT_FSIZE) rlim_cur: 2147483647 rlim_max: 2147483647
> 
> Can anybody point me out what went wrong? Is it a kernel limit?
> 
> Peter
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

