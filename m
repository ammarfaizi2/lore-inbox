Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSE3OYG>; Thu, 30 May 2002 10:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSE3OYF>; Thu, 30 May 2002 10:24:05 -0400
Received: from spook.vger.org ([213.204.128.210]:24803 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316662AbSE3OYD>; Thu, 30 May 2002 10:24:03 -0400
Date: Thu, 30 May 2002 17:01:25 +0200 (CEST)
From: me@vger.org
To: linux-lvm@sistina.com, lvm-devel@sistina.com
cc: Lionel Bouton <Lionel.Bouton@inet6.fr>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Strange RAID2 behavier...
In-Reply-To: <Pine.LNX.4.21.0205301458230.20123-100000@kenny.worldonline.se>
Message-ID: <Pine.LNX.4.21.0205301649250.20123-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No worry linux-kernel, this seams to be a lvm problem.

Hi linux-lvm,

In short, I got 4 md devices (md0-4) that I make one device with using
lvm. When I'm going to shutdown this device it seams that lvm locks md2-3.

Booting linux without lvm there is no problem what so ever to start and
stop the raid mds.

Also as you read the futher down, the reason I could stop md3 was because
I hadnt used lvm yet that time and hadnt made any VGs or LVs or mounted
them. Also, the way i stop lvm is as described in the documents "umount,
vgchange -an".

Im using lvm-1.1rc-2, 2.4.19-pre9 and debian testing dist.

Im going to try running lvm as module and unloading the module after
stopping the lvm VGs and see if it still locks the mds.

If you need more info, please send a mail.


On Thu, 30 May 2002 me@vger.org wrote:

> On Thu, 30 May 2002, Lionel Bouton wrote:
> 
> > On jeu, mai 30, 2002 at 02:37:53 +0200, me@vger.org wrote:
> > > I made the md2 a linear raid of one drive, now I can stop the md3.
> > > This means that for example making md0 and md3 will make md3 unstoppable,
> > > has this bug already been reported?
> > 
> > This could be a bug/constraint in raidtools as said in mad raidtab:
> > "the  parsing  code  isn't  overly bright".
> > 
> > I've had small glitches when using comments in raidtab. Try removing all
> > your commented /dev/md2 related lines instead of building a dumb array.
> > 
> 
> Ok, i tought id fixed the problem (parsing problem) but it doesnt seam to
> be that.
> 
> The md's ive got I later make a linear lvm partition from, may have
> something to do with that.
> 
> I can start the raid, get lvm running, mount the lvm partition.
> And then I umount the lvm partition and do vgchange -an to deactivate all
> lvms. Now i can stop md0-1 but not md2-3.
> 
> --- strace raidstop ---
> # strace raidstop /dev/md3
> execve("/sbin/raidstop", ["raidstop", "/dev/md3"], [/* 14 vars */]) = 0
> uname({sys="Linux", node="odd", ...})   = 0
> brk(0)                                  = 0x804fd50
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=9361, ...}) = 0
> old_mmap(NULL, 9361, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
> close(3)                                = 0
> open("/lib/libpopt.so.0", O_RDONLY)     = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\21\0\000"...,
> 1024) = 1024
> fstat64(3, {st_mode=S_IFREG|0644, st_size=20704, ...}) = 0
> old_mmap(NULL, 23828, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40017000
> mprotect(0x4001c000, 3348, PROT_NONE)   = 0
> old_mmap(0x4001c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
> 0x4000) = 0x4001c000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"...,
> 1024) = 1024
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) = 0
> old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 0x4001d000
> mprotect(0x40130000, 40160, PROT_NONE)  = 0
> old_mmap(0x40130000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
> 3, 0x113000) = 0x40130000
> old_mmap(0x40136000, 15584, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40136000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x4013a000
> munmap(0x40014000, 9361)                = 0
> brk(0)                                  = 0x804fd50
> brk(0x804fef8)                          = 0x804fef8
> brk(0x8050000)                          = 0x8050000
> brk(0x8051000)                          = 0x8051000
> open("/etc/raidtab", O_RDONLY)          = 3
> open("/dev/md0", O_RDONLY)              = 4
> ioctl(4, 0x800c0910, 0x804fd3c)         = 0
> close(4)                                = 0
> open("/dev/md3", O_RDWR)                = 4
> fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(9, 3), ...}) = 0
> ioctl(4, 0x932, 0)                      = -1 EBUSY (Device or resource
> busy)
> dup(2)                                  = 5
> fcntl64(5, F_GETFL)                     = 0x8002 (flags
> O_RDWR|O_LARGEFILE)
> fstat64(5, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0), ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x40014000
> _llseek(5, 0, 0xbffff964, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
> write(5, "/dev/md3: Device or resource bus"..., 34/dev/md3: Device or
> resource busy
> ) = 34
> close(5)                                = 0
> munmap(0x40014000, 4096)                = 0
> _exit(1)                                = ?
> ------------------
> 
> Can this be a version problem with raidtool2 ? Im using debian testing
> dist.
> 
> Any way i can check why/who has that device? lsof shows no md3.
> 
> Im clueless right now, sure the raid work even if md2 md3 are in use under
> reboot but this not correct.
> 
> 
> 

