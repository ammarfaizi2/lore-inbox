Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbSK3BSr>; Fri, 29 Nov 2002 20:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbSK3BSr>; Fri, 29 Nov 2002 20:18:47 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:3712 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267197AbSK3BSp>; Fri, 29 Nov 2002 20:18:45 -0500
Date: Sat, 30 Nov 2002 12:25:55 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x, 2.4.y / pcmcia xircom serial doesn't work
Message-ID: <20021130012555.GA612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure when this stopped working. I know that I've successfully
used the port in the past with some version of 2.4.x that is now WAY old
but that's the best I can come up with as I no longer have those kernel
compiles around. :/ Under 2.4.x I used the pcmcia-cs package rather then
the kernel modules. The end result though is thesame and I'll
concentrate on 2.5.x (primarily 2.5.49 but it doesn't work under 47
either).

Under 2.5.x the problem is that whilst the serial side of my Xircom
RealPort is detected as ttyS15:

Nov 18 22:58:27 theirongiant kernel: PCI: Enabling device 02:00.1 (0000 -> 0003)
Nov 18 22:58:27 theirongiant kernel: ttyS15 at I/O 0x4080 (irq = 10) is a 16550A

It does not work and any access to it results in an I/O error as can be
seen from this minicom strace:

...
open("/dev/ttyS15", O_RDWR|O_NONBLOCK)  = 3
fcntl64(3, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(3, F_SETFL, O_RDWR)             = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff6a8) = -1 EIO (Input/output error)
ioctl(3, 0x5415, [0])                   = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff638) = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_START, {c_iflags=0x1, c_oflags=0, c_cflags=0x40013cb2, c_lflags=0, c_line=1, c_cc[VMIN]=1, c_cc[VTIME]=5, c_cc="\x00\x00\x00\x48\x0e\x05\x01\x08\xae\x07\x08\x00\x00\x00\x00\x00\x00\x00\x00\xcc\xf6\xff\xbf\x86\x1a\x06\x08\x03\x00\x00\x00\x00"}) = -1 EIO (Input/output error)
ioctl(3, 0x5415, [0])                   = -1 EIO (Input/output error)
ioctl(3, 0x5418, [TIOCM_RTS])           = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff5d8) = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_START, {c_iflags=0x31000000, c_oflags=0x40000860, c_cflags=0x88072030, c_lflags=0x40013420, c_line=25, c_cc[VMIN]=64, c_cc[VTIME]=23, c_cc="\x23\x07\x40\x48\x0e\x17\x40\x5c\xf6\xff\xbf\x94\x30\x12\x40\x05\x00\x00\x00\x5c\xf6\xff\xbf\x3b\x15\x06\x08\x03\x00\x00\x00\x00"}) = -1 EIO (Input/output error)
alarm(0)                                = 4
rt_sigaction(SIGALRM, {SIG_IGN}, {0x8062744, [ALRM], SA_RESTART|0x4000000}, 8) = 0
stat64("/dev/ttyS15", {st_dev=makedev(3, 6), st_ino=7471, st_mode=S_IFCHR|0660, st_nlink=1, st_uid=0, st_gid=20, st_blksize=4096, st_blocks=0, st_rdev=makedev(4, 79), st_atime=2002/11/18-15:45:59, st_mtime=2002/11/18-15:45:59, st_ctime=2002/11/30-12:04:26}) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff668) = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_START, {c_iflags=0, c_oflags=0x3de80e9a, c_cflags=0x800, c_lflags=0x1d2f, c_line=0, c_cc="\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\xf6\xff\xbf\xf3\x16\x06\x08\x03\x00\x00\x00\x00"}) = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff668) = -1 EIO (Input/output error)
ioctl(3, SNDCTL_TMR_START, {c_iflags=0, c_oflags=0x3de80e9a, c_cflags=0xc00, c_lflags=0x1d2f, c_line=0, c_cc="\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\xf6\xff\xbf\x36\x17\x06\x08\x03\x00\x00\x00\x00"}) = -1 EIO (Input/output error)
ioctl(3, 0x540b, 0x2)                   = -1 EIO (Input/output error)
...

My /dev/ttyS15 entry is:

0 crw-rw----    1 root     dialout    4,  79 Nov 18 15:45 /dev/ttyS15

All this was done as root.

Now I'm sure I got the minor/major right as devices.txt defines ttyS0 as
64 and ttyS191 as 255 (64+191) and as such ttyS15 should be 79 (64+15).

Again, if you need any extra info, yell. I'm not quite sure what to give
and I don't want to spam.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
