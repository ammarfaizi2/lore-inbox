Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135587AbRANWHi>; Sun, 14 Jan 2001 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135594AbRANWH3>; Sun, 14 Jan 2001 17:07:29 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:61733 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S135587AbRANWHM>;
	Sun, 14 Jan 2001 17:07:12 -0500
Date: Sun, 14 Jan 2001 23:07:04 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Filesystem corruption with 2.4.1-pre3 and raid5
Message-Id: <Pine.LNX.4.30.0101142259180.8354-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Doing some test where lots of small files get copied (and some large
ones) around, I experienced filesystem corruption with 2.4.1-pre3.

The system has a ASUS P2B-DS (onboard adaptec controller) with two P2-350,
256MB (one module) PC-100 222 SDRAM with ECC, with 4 SCSI disk and one IDE
disk put together as one big SW Raid5 disk, SuSE 6.4 with the following:
    Linux cube 2.4.1-pre3 #3 SMP Sun Jan 14 14:19:02 CET 2001 i686 unknown
    Kernel modules    2.3.24
    Gnu C             2.95.2
    Gnu Make          3.78.1
    Binutils          2.9.5.0.24
    Linux C Library   x   1 root     root      4061504 Mar 11  2000 /lib/libc.so.6
    Dynamic linker    ldd (GNU libc) 2.1.3
    Procps            2.0.6
    Mount             2.10r
    Net-tools         1.54
    Kbd               0.99
    Sh-utils          2.0
    Modules Loaded

I know my modutilities are not up to date, but all relevant things (SCSI,
filesystem, raid) where compiled in.
Here are some messages from syslog:

    Jan 14 18:50:00 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (613512), 0
    Jan 14 18:56:19 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (613533), 0
    Jan 14 18:56:20 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (613510), 0
    Jan 14 18:57:14 cube kernel: attempt to access beyond end of device
    Jan 14 18:57:14 cube kernel: 09:01: rw=1, want=1753106892, limit=8449536
    Jan 14 18:57:14 cube kernel: attempt to access beyond end of device
    Jan 14 18:57:14 cube kernel: 09:01: rw=1, want=1635361196, limit=8449536
        .
        .
        .
    Jan 14 18:57:14 cube kernel: attempt to access beyond end of device
    Jan 14 18:57:14 cube kernel: 09:01: rw=1, want=127799040, limit=8449536
    Jan 14 18:57:14 cube kernel: attempt to access beyond end of device
    Jan 14 18:57:14 cube kernel: 09:01: rw=1, want=1004451972, limit=8449536
    Jan 14 19:09:05 cube -- MARK --
    Jan 14 19:29:05 cube -- MARK --
    Jan 14 19:32:55 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (145947), 0
    Jan 14 19:32:55 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (145948), 0
    Jan 14 19:32:55 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (145949), 0
        .
        .
        .
    Jan 14 19:33:18 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (145945), 0
    Jan 14 19:33:18 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (145946), 0
    Jan 14 19:49:06 cube -- MARK --
    Jan 14 19:53:36 cube kernel: __alloc_pages: 2-order allocation failed.
    Jan 14 19:53:39 cube last message repeated 8 times
    Jan 14 20:09:06 cube -- MARK --
    Jan 14 20:10:52 cube kernel: EXT2-fs error (device md(9,1)): ext2_readdir: bad entry in directory #929061: rec_len is smaller than minimal - offset=4056, inode=0, rec_len=0, name_len=0
    Jan 14 20:10:52 cube kernel: EXT2-fs error (device md(9,1)): empty_dir: bad entry in directory #929061: rec_len is smaller than minimal - offset=4056, inode=0, rec_len=0, name_len=0
    Jan 14 20:30:20 cube -- MARK --
    Jan 14 20:50:24 cube -- MARK --
    Jan 14 21:10:06 cube kernel: EXT2-fs error (device md(9,1)): ext2_free_blocks: bit already cleared for block 1402395
    Jan 14 21:10:06 cube kernel: EXT2-fs error (device md(9,1)): ext2_free_blocks: bit already cleared for block 1438368
    Jan 14 21:11:57 cube kernel: EXT2-fs error (device md(9,1)): ext2_free_blocks: bit already cleared for block 1439021
    Jan 14 21:11:57 cube kernel: EXT2-fs error (device md(9,1)): ext2_free_blocks: bit already cleared for block 1435690
    Jan 14 21:27:01 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (698429), 0
        .
        .
        .
    Jan 14 21:27:03 cube kernel: EXT2-fs warning (device md(9,1)): ext2_unlink: Deleting nonexistent file (698429), 0
    Jan 14 21:30:02 cube nscd: 175: cannot stat() file `/etc/group': No such file or directory
    Jan 14 21:35:38 cube /usr/sbin/gpm[113]: oops() invoked from gpm.c(508)
    Jan 14 21:35:38 cube /usr/sbin/gpm[113]: get_shift_state: Inappropriate ioctl for device

At this point I could still log into the system.
I noticed after killing all process with SysRQ+i that something (I assume
the kernel) was eating my memory:

    ps aux

    USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
    root         1  0.0  0.0   344  200 ?        S    14:48   0:09 init
    root         2  0.0  0.0     0    0 ?        SW   14:48   0:00 [keventd]
    root         4  0.0  0.0     0    0 ?        SW   14:48   0:23 [kswapd]
    root         5  0.0  0.0     0    0 ?        SW   14:48   0:03 [kreclaimd]
    root         6  0.7  0.0     0    0 ?        SW   14:48   2:59 [bdflush]
    root         7  0.3  0.0     0    0 ?        SW   14:48   1:19 [kupdate]
    root         8  0.0  0.0     0    0 ?        SW<  14:48   0:00 [mdrecoveryd]
    root         9  2.2  0.0     0    0 ?        SW<  14:48   9:16 [raid5d]
    root        10  0.0  0.0     0    0 ?        SW<  14:48   0:00 [raid1d]
    root     11847  0.0  0.2  1160  524 tty6     S    21:38   0:00 /sbin/mingetty tty6
    root     11848  0.0  0.2  1160  528 tty5     S    21:38   0:00 /sbin/mingetty tty5
    root     11854  0.0  0.2  1160  524 tty3     S    21:38   0:00 /sbin/mingetty tty3
    root     11855  0.0  0.2  1160  524 tty4     S    21:38   0:00 /sbin/mingetty tty4
    root     11856  0.0  0.4  1804 1112 tty1     S    21:38   0:00 login -- root
    root     11857  0.0  0.2  1160  524 tty2     S    21:38   0:00 /sbin/mingetty tty2
    root     11858  0.2  0.5  2164 1316 tty1     S    21:39   0:00 -bash
    root     11867  0.0  0.4  2760 1156 tty1     R    21:39   0:00 ps aux

    free

    total       used       free     shared    buffers     cached
    Mem:        255284     226000      29284          0      17828     117788
    -/+ buffers/cache:      90384     164900
    Swap:       267228        540     266688

One ps even just dumped core and I still have the core file. Don't know if
this is of help:

    afdbench@cube:~$ gdb /bin/ps core.ps
    GNU gdb 4.18
    Copyright 1998 Free Software Foundation, Inc.
    GDB is free software, covered by the GNU General Public License, and you are
    welcome to change it and/or distribute copies of it under certain conditions.
    Type "show copying" to see the conditions.
    There is absolutely no warranty for GDB.  Type "show warranty" for details.
    This GDB was configured as "i386-suse-linux"...(no debugging symbols found)...
    Core was generated by `ps x'.
    Program terminated with signal 11, Segmentation fault.
    Reading symbols from /lib/libc.so.6...done.
    Reading symbols from /lib/ld-linux.so.2...done.
    #0  0x80525ac in strcpy () at ../sysdeps/generic/strcpy.c:43
    43      ../sysdeps/generic/strcpy.c: No such file or directory.
    (gdb) where
    #0  0x80525ac in strcpy () at ../sysdeps/generic/strcpy.c:43
    #1  0x81490e0 in __ctype_b ()
    #2  0x8052f28 in strcpy () at ../sysdeps/generic/strcpy.c:43
    #3  0x8050472 in strcpy () at ../sysdeps/generic/strcpy.c:43
    #4  0x80509a5 in strcpy () at ../sysdeps/generic/strcpy.c:43
    #5  0x40034a5e in __libc_start_main () at ../sysdeps/generic/libc-start.c:93

I have this system now for several years and it has always been very
stabel under 2.2.x. In fact this is my first filesystem corruption.

If I forget anything or more information is required please tell me.

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
