Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRKHPUK>; Thu, 8 Nov 2001 10:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRKHPUB>; Thu, 8 Nov 2001 10:20:01 -0500
Received: from [212.65.238.182] ([212.65.238.182]:45065 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S273261AbRKHPTr> convert rfc822-to-8bit; Thu, 8 Nov 2001 10:19:47 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA10955B8@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: Peter.Seiderer@ciselant.de
Cc: linux-kernel@vger.kernel.org
Subject: FW: What is the difference between 'login: root' and 'su -' ?
Date: Thu, 8 Nov 2001 16:19:56 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>correction follows

> Hi,
> 
> BTW, /dev/hdc4, is that a regular hard disk partition? I was always used
> to
> create /dev/hda1, /dev/hda5, /dev/hda6 etc.  as normal partitions (via
> fdisk). 
> 
> Is your /dev/hda hard disk drive or some other device?
> 
[> ]  ^^^^^ of course not /dev/hda but /dev/hdc. Oops: concentration of
blood in my cofein is increasing :)

> Just for my curiosity :)
> 
> Regards
> Petr
> 
> 
> > -----Pùvodní zpráva-----
> > Od:	Peter Seiderer [SMTP:Peter.Seiderer@ciselant.de]
> > Odesláno:	8. listopadu 2001 9:47
> > Komu:	linux-kernel@vger.kernel.org
> > Kopie:	Ville Herva
> > Pøedmìt:	Re: What is the difference between 'login: root' and 'su -'
> > ?
> > 
> > Hello,
> > in both cases file descriptor 4 is from 'open("/dev/hdc4", O_RDWR) = 4'
> > ....
> > Peter
> > 
> > On Thu, Nov 08, 2001 at 08:10:07AM +0200, Ville Herva wrote:
> > > On Wed, Nov 07, 2001 at 11:40:25PM +0100, you [Peter Seiderer]
> claimed:
> > > > Mhhh,
> > > > the strace output from the 'login: root' one (the one which was
> good)
> > > > looks the same till the EFBIG place:
> > > > 
> > > > 	write(1, "\10\10\10\10\10", 5)          = 5
> > > > 	write(1, "16/44", 5)                    = 5
> > > > 	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
> > > > 	write(4,
> > "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) =
> > 32768
> > > > 	_llseek(4, 18446744071562117120, [2147532800], SEEK_SET) = 0
> > > > 	write(4,
> > "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) =
> > 32768
> > > > 	_llseek(4, 18446744071562149888, [2147565568], SEEK_SET) = 0
> > > > 	write(4,
> > "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) =
> > 32768
> > > > 	_llseek(4, 18446744071562182656, [2147598336], SEEK_SET) = 0
> > > > 	write(4,
> > "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) =
> > 32768
> > > 
> > > Weird. Perhaps strace gets that wrong and the problem is elsewhere.
> > > 
> > > Did you make sure that fd 4 is the same _partition_ in both cases
> (using
> > > strace)? The only thing I could imagine exposing 2GB limit is writing
> to
> > a
> > > file.
> > > 
> > > > > > 	zodiak login: seiderer
> > > > > > 	Password:
> > > > > > 	seiderer@zodiak:~ > su -
> > > > > > 	Password:
> > > > > > 	zodiak:~ #
> > > > > > 	zodiak:~ # mkfs.ext2 /dev/hdc4
> > > > > > 	mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> > > > > > 	Filesystem label=
> > > > > > 	OS type: Linux
> > > > > > 	Block size=4096 (log=2)
> > > > > > 	Fragment size=4096 (log=2)
> > > > > > 	716672 inodes, 1432116 blocks
> > > > > > 	71605 blocks (5.00%) reserved for the super user
> > > > > > 	First data block=0
> > > > > > 	44 block groups
> > > > > > 	32768 blocks per group, 32768 fragments per group
> > > > > > 	16288 inodes per group
> > > > > > 	Superblock backups stored on blocks:
> > > > > > 	        32768, 98304, 163840, 229376, 294912, 819200, 884736
> > > > > > 
> > > > > > 	Writing inode tables: 16/44File size limit exceeded
> > > > > > 
> > > > > > strace showed that write returned wit EFBIG and the process
> ended
> > with SIGXFSZ:
> > > > > > 
> > > > > > 	write(1, "\10\10\10\10\10", 5)          = 5
> > > > > > 	write(1, "16/44", 5)                    = 5
> > > > > > 	_llseek(4, 18446744071562084352, [2147500032], SEEK_SET) = 0
> > > > > > 	write(4,
> > "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768) = -1
> > EFBIG (File too large)
> > > > > > 	--- SIGXFSZ (File size limit exceeded) ---
> > > > > > 	+++ killed by SIGXFSZ +++
> > > > > 
> > > > > Hmm, 18446744071562084352 = 0xffffffff80004000, 2147500032 =
> > 0x80004000...
> > > > > It looks a tad like llseek's offset_high would have been
> > corrupted...
> > > > > Strange.
> > > > > 
> > > > > 1432116 blocks * 4096 bytes/block * 16/44 written =
> 2133071685.81818
> > so
> > > > > 2147500032 looks sane(ish).
> > > 
> > > -- v --
> > > 
> > > v@iki.fi
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
