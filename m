Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280071AbRJaE6o>; Tue, 30 Oct 2001 23:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280072AbRJaE6f>; Tue, 30 Oct 2001 23:58:35 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:1920 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S280071AbRJaE6X>;
	Tue, 30 Oct 2001 23:58:23 -0500
Date: Tue, 30 Oct 2001 20:58:59 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Cc: m.schimschak@gmx.de
Subject: [Danger] 2.4.14pre3-pre5: Queueing changes broken? [Re: [2.4.14-pre3] kernel: attempt to access beyond end of device]
Message-ID: <20011030205858.A571@netnation.com>
In-Reply-To: <87pu76fd2l.fsf@hobbes.masch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pu76fd2l.fsf@hobbes.masch.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is definitely broken with the kernel here.  My box was up and
running fine with 2.4.14pre5 until I just decided to remove hdb from the
box to move it to another box.  I had:

Oct 29 21:17:19 oof kernel: hda: ST360021A, ATA DISK drive
Oct 29 21:17:19 oof kernel: hdb: IBM-DTLA-307045, ATA DISK drive
Oct 29 21:17:19 oof kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 010, ATAPI CD/DVD-ROM drive
Oct 29 21:17:19 oof kernel: hdd: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive

I took out hdb, and I got the looping "Attempt to access beyond end of
device" message, followed by fsck saying the filesystem had errors on the
next boot (in which I entered single-user mode in and tried to fsck
manually).  Every normal bootup had the looping failure message.

My fallback, 2.4.10pre10, boots fine with hdb missing.

Everything seems to be fine on the older kernel (I rebooted it very
quickly after the looping message started, so maybe I avoided
corruption).

Something to do with the queueing changes, perhaps?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

On Mon, Oct 29, 2001 at 08:42:10PM +0100, m.schimschak@gmx.de wrote:

> Hi,
> 
> Shortly after system startup, something tried an "access beyond end of
> device" and left the filesystem on the root partition (/dev/sda3) in
> an strange state. Several files had future timestamps. Others
> were marked as block or character devices (marked with c, b or B).
> Unfortunatley /lib/libext2fs.so.2 was also marked as a block device,
> so the filesystem check aborted on the next reboot. When I tried to remove
> these files, I got a
> 
>       rm: cannot unlink `libext2fs.so.2': Operation not permitted
> 
> Seems, the filesystem was severely broken.
> 
> Anyway, I have no hint what has caused the damage. The only remarkable
> things, I have done recently, were to install a new kernel, play
> around with the sound system and upgrade memory.
> 
> The box is an alpha, the system is Debian.
> 
> Any help is appreciated.
> 
> Thanks,
> 	Martin
> 
> 
> -- excerpt of syslog --
> 
> Oct 28 13:54:24 hobbes syslogd 1.4.1#2: restart.
> Oct 28 13:54:24 hobbes kernel: klogd 1.4.1#2, log source = /proc/kmsg started.
> Oct 28 13:54:24 hobbes kernel: Inspecting /boot/System.map-2.4.14-pre3
> Oct 28 13:54:24 hobbes pppd[181]: Plugin /usr/lib/pppd/2.4.1/pppoe.so loaded.
> Oct 28 13:54:24 hobbes kernel: Loaded 13587 symbols from /boot/System.map-2.4.14-pre3.
> Oct 28 13:54:24 hobbes kernel: Symbols match kernel version 2.4.14.
> Oct 28 13:54:24 hobbes pppd[181]: PPPoE Plugin Initialized
> Oct 28 13:54:24 hobbes kernel: Error seeking in /dev/kmem 
> Oct 28 13:54:24 hobbes kernel: Symbol #sb, value 0008a000 
> Oct 28 13:54:24 hobbes kernel: Error adding kernel module table entry. 
> Oct 28 13:54:24 hobbes kernel: Linux version 2.4.14-pre3 (masch@hobbes) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Sat Oct 27 17:53:26 CEST 2001
> Oct 28 13:54:24 hobbes kernel: Booting on Ruffian using machine vector Ruffian from MILO
> Oct 28 13:54:24 hobbes kernel: Command line: bootdevice=sda3 bootfile=boot/vmlinux root=/dev/sda3 
> Oct 28 13:54:24 hobbes kernel: memcluster 0, usage 2, start        0, end        2
> Oct 28 13:54:24 hobbes kernel: memcluster 1, usage 0, start        2, end      256
> Oct 28 13:54:25 hobbes kernel: memcluster 2, usage 2, start      256, end      328
> Oct 28 13:54:25 hobbes kernel: memcluster 3, usage 0, start      328, end     2298
> Oct 28 13:54:25 hobbes kernel: memcluster 4, usage 2, start     2298, end     2300
> Oct 28 13:54:25 hobbes kernel: memcluster 5, usage 0, start     2300, end    98176
> Oct 28 13:54:25 hobbes kernel: freeing pages 2:256
> Oct 28 13:54:25 hobbes kernel: freeing pages 328:384
> Oct 28 13:54:25 hobbes kernel: freeing pages 684:2298
> Oct 28 13:54:25 hobbes kernel: freeing pages 2300:98176
> Oct 28 13:54:25 hobbes kernel: reserving pages 2:4
> Oct 28 13:54:25 hobbes kernel: pci: cia revision 1 (pyxis)
> Oct 28 13:54:25 hobbes kernel: On node 0 totalpages: 98176
> Oct 28 13:54:25 hobbes kernel: zone(0): 2048 pages.
> Oct 28 13:54:25 hobbes kernel: zone(1): 96128 pages.
> Oct 28 13:54:25 hobbes kernel: zone(2): 0 pages.
> Oct 28 13:54:25 hobbes kernel: Kernel command line: bootdevice=sda3 bootfile=boot/vmlinux root=/dev/sda3 
> Oct 28 13:54:25 hobbes kernel: Using epoch = 2000
> Oct 28 13:54:25 hobbes kernel: Console: colour VGA+ 80x25
> Oct 28 13:54:25 hobbes kernel: Calibrating delay loop... 1057.24 BogoMIPS
> Oct 28 13:54:25 hobbes kernel: Memory: 770072k/785408k available (1352k kernel code, 14728k reserved, 463k data, 320k init)
> Oct 28 13:54:25 hobbes kernel: Dentry-cache hash table entries: 131072 (order: 8, 2097152 bytes)
> Oct 28 13:54:25 hobbes kernel: Inode-cache hash table entries: 65536 (order: 7, 1048576 bytes)
> Oct 28 13:54:25 hobbes kernel: Mount-cache hash table entries: 16384 (order: 5, 262144 bytes)
> Oct 28 13:54:25 hobbes kernel: Buffer-cache hash table entries: 65536 (order: 6, 524288 bytes)
> Oct 28 13:54:25 hobbes kernel: Page-cache hash table entries: 131072 (order: 7, 1048576 bytes)
> Oct 28 13:54:25 hobbes kernel: POSIX conformance testing by UNIFIX
> Oct 28 13:54:25 hobbes kernel: pci: passed tb register update test
> Oct 28 13:54:25 hobbes kernel: pci: passed sg loopback i/o read test
> Oct 28 13:54:25 hobbes kernel: pci: passed pte write cache snoop test
> Oct 28 13:54:25 hobbes kernel: pci: failed valid tag invalid pte reload test (mcheck; workaround available)
> Oct 28 13:54:25 hobbes kernel: pci: passed pci machine check test
> Oct 28 13:54:25 hobbes kernel: pci: tbia workaround enabled
> Oct 28 13:54:25 hobbes kernel: Activating ISA DMA hang workarounds.
> Oct 28 13:54:25 hobbes kernel: Linux NET4.0 for Linux 2.4
> Oct 28 13:54:25 hobbes kernel: Based upon Swansea University Computer Society NET3.039
> Oct 28 13:54:25 hobbes kernel: Starting kswapd
> Oct 28 13:54:25 hobbes kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
> Oct 28 13:54:25 hobbes kernel: pty: 256 Unix98 ptys configured
> Oct 28 13:54:25 hobbes kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> Oct 28 13:54:25 hobbes kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
> Oct 28 13:54:25 hobbes kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Oct 28 13:54:25 hobbes kernel: block: 128 slots per queue, batch=32
> Oct 28 13:54:25 hobbes kernel: PPP generic driver version 2.4.1
> Oct 28 13:54:25 hobbes kernel: SCSI subsystem driver Revision: 1.00
> Oct 28 13:54:25 hobbes kernel: sym53c8xx: at PCI bus 1, device 13, function 0
> Oct 28 13:54:25 hobbes kernel: sym53c8xx: 53c875 detected 
> Oct 28 13:54:25 hobbes kernel: sym53c875-0: rev 0x3 on pci bus 1 device 13 function 0 irq 20
> Oct 28 13:54:25 hobbes kernel: sym53c875-0: ID 7, Fast-20, Parity Checking
> Oct 28 13:54:25 hobbes kernel: scsi0 : sym53c8xx-1.7.3c-20010512
> Oct 28 13:54:25 hobbes kernel:   Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
> Oct 28 13:54:25 hobbes kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
> Oct 28 13:54:25 hobbes kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W4220T  Rev: 1.01
> Oct 28 13:54:25 hobbes kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
> Oct 28 13:54:25 hobbes kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Oct 28 13:54:25 hobbes kernel: sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
> Oct 28 13:54:25 hobbes kernel: SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
> Oct 28 13:54:25 hobbes kernel: Partition check:
> Oct 28 13:54:25 hobbes kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
> Oct 28 13:54:25 hobbes kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> Oct 28 13:54:25 hobbes kernel: IP Protocols: ICMP, UDP, TCP
> Oct 28 13:54:25 hobbes kernel: IP: routing cache hash table of 8192 buckets, 128Kbytes
> Oct 28 13:54:25 hobbes kernel: TCP: Hash tables configured (established 65536 bind 65536)
> Oct 28 13:54:25 hobbes kernel: ip_conntrack (3068 buckets, 24544 max)
> Oct 28 13:54:25 hobbes kernel: ip_tables: (c)2000 Netfilter core team
> Oct 28 13:54:25 hobbes kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Oct 28 13:54:25 hobbes kernel: VFS: Mounted root (ext2 filesystem) readonly.
> Oct 28 13:54:25 hobbes kernel: Freeing unused kernel memory: 320k freed
> Oct 28 13:54:25 hobbes kernel: Adding Swap: 131064k swap-space (priority -1)
> Oct 28 13:54:25 hobbes kernel: eth0: DC21143 at 0x8000 (PCI bus 0, device 15), h/w address 00:00:f0:51:00:43,
> Oct 28 13:54:25 hobbes kernel:       and requires IRQ44 (provided by PCI BIOS).
> Oct 28 13:54:25 hobbes kernel: de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
> Oct 28 13:54:25 hobbes kernel: isapnp: Scanning for PnP cards...
> Oct 28 13:54:25 hobbes kernel: isapnp: Calling quirk for 01:00
> Oct 28 13:54:25 hobbes kernel: isapnp: SB audio device quirk - increasing port range
> Oct 28 13:54:25 hobbes kernel: isapnp: Calling quirk for 01:02
> Oct 28 13:54:25 hobbes kernel: isapnp: AWE32 quirk - adding two ports
> Oct 28 13:54:25 hobbes kernel: isapnp: Card 'Creative SB AWE64  PnP'
> Oct 28 13:54:25 hobbes kernel: isapnp: 1 Plug & Play card detected total
> Oct 28 13:54:25 hobbes kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
> Oct 28 13:54:25 hobbes kernel: sb: Creative SB AWE64  PnP detected
> Oct 28 13:54:25 hobbes kernel: sb: ISAPnP reports 'Creative SB AWE64  PnP' at i/o 0x220, irq 5, dma 1, 5
> Oct 28 13:54:25 hobbes kernel: SB 4.16 detected OK (220)
> Oct 28 13:54:25 hobbes kernel: <Sound Blaster 16 (4.16)> at 0x220 irq 5 dma 1,5
> Oct 28 13:54:25 hobbes kernel: <Sound Blaster 16> at 0x330 irq 5 dma 0,0
> Oct 28 13:54:25 hobbes kernel: sb: 1 Soundblaster PnP card(s) found.
> Oct 28 13:54:25 hobbes kernel: eth0: media is TP full duplex.
> Oct 28 13:54:25 hobbes rpc.statd[233]: Version 0.3.3 Starting
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:28 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:28 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:28 hobbes anacron[263]: Anacron 2.3 started on 2001-10-28
> Oct 28 13:54:28 hobbes anacron[263]: Normal exit (0 jobs run)
> Oct 28 13:54:29 hobbes /usr/sbin/cron[268]: (CRON) INFO (pidfile fd = 3)
> Oct 28 13:54:29 hobbes /usr/sbin/cron[269]: (CRON) STARTUP (fork ok)
> Oct 28 13:54:29 hobbes /usr/sbin/cron[269]: (CRON) INFO (Running @reboot jobs)
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=540639529, limit=131072
> Oct 28 13:54:45 hobbes kernel: attempt to access beyond end of device
> Oct 28 13:54:45 hobbes kernel: 08:03: rw=0, want=1342177282, limit=131072
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
