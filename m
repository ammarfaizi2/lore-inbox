Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263623AbRFARPc>; Fri, 1 Jun 2001 13:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263624AbRFARPX>; Fri, 1 Jun 2001 13:15:23 -0400
Received: from idiom.com ([216.240.32.1]:17680 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S263623AbRFARPQ>;
	Fri, 1 Jun 2001 13:15:16 -0400
Message-ID: <3B17CC8E.64AA2BDE@namesys.com>
Date: Fri, 01 Jun 2001 10:10:38 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: 
 kernel-2.4.5
In-Reply-To: <E155a3W-00084H-00@the-village.bc.nu> <3B16C002.E615CB80@home.com> <20010601105611.A3610@middle.of.nowhere>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

known VFS bug, ask viro for details, 2.4.5 is not stable because of it, use
2.4.4

Hans

thunder7@xs4all.nl wrote:
> 
> On Thu, May 31, 2001 at 05:04:50PM -0500, Jordan wrote:
> > Alan Cox wrote:
> > >
> > > > I'm staying on 2.4.5-ac5 for whatever it's worth (putting my life on the
> > > > line for the community? kidding...) and will report anything new. I will
> > > > be on the lookout for later ac patches, 2.4.6 ... and hopefully anything
> > > > anybody can share with me about this. I hope we'll see an end to these
> > >
> > > Can you tell me if 2.4.5-ac4 is ok. ac5 has a small 'obviously correct'
> > > reiserfs module unload change that seems the first suspect
> > >
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > I have seen this same problem with unmounting in 2.4.5-ac5, it was
> > perfectly fine in 2.4.5-ac3 and ac4.  I would guess the module unload is
> > what did it.
> >
> 2.4.5-ac4 was fine, 2.4.5-ac5:
> 
> /space in /etc/fstab:
> 
> /dev/hda10      /space1                 reiserfs        defaults 1 2
> 
> strace umount /space1:
> 
> open("/usr/lib/locale/en_US/LC_TIME", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=2441, ...}) = 0
> old_mmap(NULL, 2441, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001f000
> close(3)                                = 0
> open("/usr/lib/locale/en_US/LC_NUMERIC", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
> old_mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40020000
> close(3)                                = 0
> open("/usr/lib/locale/en_US/LC_CTYPE", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=104804, ...}) = 0
> old_mmap(NULL, 104804, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40137000
> close(3)                                = 0
> SYS_199(0x40131ad8, 0, 0x40132760, 0x40130210, 0) = 0
> semop(1074993880, 0x40130210, 0)        = 0
> brk(0x8056000)                          = 0x8056000
> readlink("/space1", 0xbfffe51c, 4095)   = -1 EINVAL (Invalid argument)
> open("/etc/mtab", O_RDONLY)             = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=680, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
> read(3, "/dev/hde1 / ext2 rw 0 0\nproc /pr"..., 4096) = 680
> read(3, "", 4096)                       = 0
> close(3)                                = 0
> munmap(0x40021000, 4096)                = 0
> oldumount("/space1"
> 
> and there it hangs. The kernel doesn't hang, but while 'mount' displays
> /space1 as mounted, ls /space1/ says nothing. df -m reveals:
> 
> Filesystem           1M-blocks      Used Available Use% Mounted on
> /dev/hda10                2015       907      1005  48% /space1
> 
> Good luck,
> Jurriaan
> --
> The music in my heart I bore long after it was heard no more.
>         William Wordsworth
> GNU/Linux 2.4.5-ac5 SMP/ReiserFS 2x1402 bogomips load av: 5.60 2.71 1.16
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
