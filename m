Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRHTMbK>; Mon, 20 Aug 2001 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269770AbRHTMbC>; Mon, 20 Aug 2001 08:31:02 -0400
Received: from mout1.freenet.de ([194.97.50.132]:23970 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S267852AbRHTMas>;
	Mon, 20 Aug 2001 08:30:48 -0400
Message-ID: <3B8102D3.846C64A7@athlon.maya.org>
Date: Mon, 20 Aug 2001 14:30:11 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.8-ac5 and earlier] fatal mount-problem
In-Reply-To: <Pine.GSO.4.21.0108200732190.1313-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 20 Aug 2001, Alan Cox wrote:
> 
> > > > (as modules) and you do the same mount again on the same (not unmounted)
> > > > device, the mount-programm hangs up and never comes back. It doesn't
> > > > recognize, that the device is allready mounted.
> > >
> > > strace, please. -ac5 and 2.4.9 have the same code in fs/super.c, so
> 
> Aha. They actually don't (sorry - I was thinking of 2.4.7-ac5), but...
> > > I really wonder what the hell is happening...
> >
> > Duplicated here with 2.4.8-ac6
> > Booted with ide-scsi as the cd driver
> 
> I can't reproduce it with /dev/hda and /dev/hdd (ide-disk and ide-cd resp.)
> here. I'll build kernel with ide-scsi and see what's going on with that.

andreas@athlon:~ > mount
/dev/hda1 on / type reiserfs (rw)
proc on /proc type proc (rw)
/dev/hda6 on /opt type reiserfs (rw)
/dev/hda9 on /usr type reiserfs (rw)
/dev/hda8 on /Daten type reiserfs (rw)
/dev/hda7 on /home type reiserfs (rw)
/dev/hda5 on /var type reiserfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/sr1 on /cdrom type iso9660 (ro,noexec,nosuid,nodev)


Now the strace after /cdrom has allready been mounted (with ide-scsi
turned on)

145   execve("/bin/mount", ["mount", "/cdrom"], [/* 54 vars */]) = 0
145   uname({sys="Linux", node="athlon", ...}) = 0
145   brk(0)                            = 0x8057840
145   shmat(0, 0x400151b8, 0x1)         = ?
145   shmat(1, 0x400151b8, 0x1)         = 0xbffff424
145   shmat(2, 0x400151b8, 0x1)         = ?
145   access("/etc/suid-debug", F_OK)   = -1 ENOENT (No such file or
directory)
145   open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or
directory)
145   open("/etc/ld.so.cache", O_RDONLY) = 4
145   SYS_197(0x4, 0xbfffebe4, 0x40014f40, 0x40015164, 0x4) = 0
145   mmap(NULL, 62282, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40016000
145   close(4)                          = 0
145   open("/lib/libc.so.6", O_RDONLY)  = 4
145   read(4,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0X\331\1"..., 1024) =
1024
145   SYS_197(0x4, 0xbfffec2c, 0x40014f40, 0x40015164, 0x4) = 0
145   mmap(NULL, 1195044, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) =
0x40026000
145   mprotect(0x40140000, 39972, PROT_NONE) = 0
145   mmap(0x40140000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 4, 0x119000) = 0x40140000
145   mmap(0x40146000, 15396, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40146000
145   close(4)                          = 0
145   munmap(0x40016000, 62282)         = 0
145   brk(0)                            = 0x8057840
145   brk(0x8057860)                    = 0x8057860
145   brk(0x8058000)                    = 0x8058000
145   open("/share/locale/locale.alias", O_RDONLY) = 4
145   SYS_197(0x4, 0xbfffb414, 0x40145a60, 0x4014942c, 0x4) = 0
145   mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40016000
145   read(4, "# Locale name alias data base.\n#"..., 4096) = 2601
145   brk(0x8059000)                    = 0x8059000
145   read(4, "", 4096)                 = 0
145   close(4)                          = 0
145   munmap(0x40016000, 4096)          = 0
145   open("/lib/locale/de_DE/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT
(No such file or directory)
145   open("/lib/locale/de/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No
such file or directory)
145   open("/dev/null", O_RDWR|O_LARGEFILE) = 4
145   close(4)                          = 0
145   SYS_199(0x40144d40, 0x2, 0x40145a60, 0x40143490, 0xbffff898) =
1001
145   semop(0x40144d40, 0x2, 0x40145a60, 0x40143490) = 0
145   SYS_196(0x8053c40, 0xbffff79c, 0x40145a60, 0x4014942c, 0x8053c40)
= 0
145   brk(0x805b000)                    = 0x805b000
145   readlink("/cdrom", 0xbfffe7dc, 4095) = -1 EINVAL (Invalid
argument)
145   open("/etc/fstab", O_RDONLY|O_LARGEFILE) = 4
145   SYS_197(0x4, 0xbffff588, 0x40145a60, 0x4014942c, 0x4) = 0
145   mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40016000
145   read(4, "/dev/hda2       /boot           "..., 4096) = 1702
145   read(4, "", 4096)                 = 0
145   close(4)                          = 0
145   munmap(0x40016000, 4096)          = 0
145   SYS_195(0xbffff670, 0xbffff610, 0x40145a60, 0x4014942c,
0xbffff670) = -1 ENOENT (No such file or directory)
145   rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
145   SYS_195(0x8059bb8, 0xbfffe3b0, 0x40145a60, 0x4014942c, 0x8059bb8)
= 0
145   open("/dev/sr1", O_RDONLY|O_LARGEFILE) = 4
145   _llseek(4, 1024, [1024], SEEK_SET) = 0
145   read(4,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 228) = 228
145   _llseek(4, 65536, [65536], SEEK_SET) = 0
145   read(4,
"~\0\301\360\0\0\0\0\360\301K\7\t\0\0\t\7Ke\5\20\2\25;\10"..., 228) =
228
145   _llseek(4, 8192, [8192], SEEK_SET) = 0
145   read(4,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 228) = 228
145   _llseek(4, 0, [0], SEEK_SET)      = 0
145   read(4,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 576) = 576
145   _llseek(4, 8192, [8192], SEEK_SET) = 0
145   read(4,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1376) =
1376
145   _llseek(4, 32768, [32768], SEEK_SET) = 0
145   read(4, "\1CD001\1\0LINUX                   "..., 2048) = 2048
145   close(4)                          = 0
145   mount("/dev/sr1", "/cdrom", "iso9660",
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|0xc0ed0000, 0x8059c18

sorry, but I couldn't get any more output.


Regards,
Andreas Hartmann
