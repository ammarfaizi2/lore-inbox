Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318394AbSGYJGh>; Thu, 25 Jul 2002 05:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318395AbSGYJGh>; Thu, 25 Jul 2002 05:06:37 -0400
Received: from outboundx.mv.meer.net ([209.157.152.12]:60688 "EHLO
	outboundx.mv.meer.net") by vger.kernel.org with ESMTP
	id <S318394AbSGYJG1>; Thu, 25 Jul 2002 05:06:27 -0400
Message-ID: <3D3FC052.43740DB4@jwz.org>
Date: Thu, 25 Jul 2002 02:09:38 -0700
From: Jamie Zawinski <jwz@jwz.org>
Organization: my own bad self
X-Mailer: Mozilla 3.02 (X11; N; Linux 2.4.9-13smp i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: puzzling kernel hangs with 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had been (moderately) happily running kernel 2.2.something (whatever
came with Red Hat 6.1, I don't remember) and I recently upgraded to 
Red Hat 7.3 and kernel 2.4.18.  Since I did that, my machine has been
regularly locking up.

  - Sometimes it becomes completely unresponsive (unpingable.)

  - Sometimes my open shells still work -- but they can't access the
    disk at all.  If I run a program in the background, it never exits;
    if I run it in the foreground, it can't be ^C'ed.

  - Sometimes, some programs work (ls) but some hang (top.)
    In that state, "shutdown" hangs, and "reboot -f" is pretty
    much the only option.

This is happening about every two days.  It's rather irritating.

My /var/log/messages is full of stuff like the following "oops"
message.  In the following, it's "Process sawfish", but I've also seen
the following processes: X, xmms, kswapd, httpd, sh, bash, tcsh sshd,
and config.guess.  So it seems fairly random.

I'm not sure the machine has ever swapped when the problem occurs,
as I've got plenty of RAM for what it's doing:

   Mem:  320524K av, 314720K used,   5804K free, 0K shrd, 20084K buff
   Swap: 369380K av,      0K used, 369380K free          208416K cached

The machine is my mp3 jukebox / icecast server, so it's set of
activities is pretty constant.  Though X is running, I don't use
it as a desktop.

I'm running the stock Red Hat kernel, I have not built my own.
I have two IDE disks with ~8 ext3 file partitions on each.
Plus a SCSI CDR, CDRW, and DAT, all of which I use very rarely.

Any suggestions?


    ksymoops 2.4.4 on i686 2.4.18-3.  Options used
         -V (default)
         -k /proc/ksyms (default)
         -l /proc/modules (default)
         -o /lib/modules/2.4.18-3/ (default)
         -m /boot/System.map-2.4.18-3 (default)

    Warning: You did not tell me where to find symbol information.  I will
    assume that the log matches the kernel and modules that are running
    right now and I'll use the default options above for symbol resolution.
    If the current kernel and/or modules do not match the log, you can get
    more accurate output by telling me the kernel version and where to find
    map, modules, ksyms etc.  ksymoops -h explains the options.

    Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
    ksymoops: No such file or directory
    Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
    ksymoops: No such file or directory
    Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
    ksymoops: No such file or directory
    Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
    ksymoops: No such file or directory
    Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
    ksymoops: No such file or directory
    /usr/bin/find: /lib/modules/2.4.18-3/build: No such file or directory
    Error (pclose_local): find_objects pclose failed 0x100
    Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01bd130, System.map says c015abe0.  Ignoring ksyms_base entry
    Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
    Jul 24 11:18:47 gronk kernel:  <1>Unable to handle kernel paging request at virtual address be897800
    Jul 24 11:18:47 gronk kernel: c01369a5
    Jul 24 11:18:47 gronk kernel: *pde = 00000000
    Jul 24 11:18:47 gronk kernel: Oops: 0000
    Jul 24 11:18:47 gronk kernel: CPU:    0
    Jul 24 11:18:47 gronk kernel: EIP:    0010:[<c01369a5>]    Not tainted
    Using defaults from ksymoops -t elf32-i386 -a i386
    Jul 24 11:18:47 gronk kernel: EFLAGS: 00010286
    Jul 24 11:18:47 gronk kernel: eax: 0100004c   ebx: c125af48   ecx: d0680194   edx: be897800
    Jul 24 11:18:47 gronk kernel: esi: d0680194   edi: 00000000   ebp: c125af48   esp: c997de90
    Jul 24 11:18:47 gronk kernel: ds: 0018   es: 0018   ss: 0018
    Jul 24 11:18:48 gronk kernel: Process sawfish (pid: 30758, stackpage=c997d000)
    Jul 24 11:18:48 gronk kernel: Stack: c01366ae 00000027 c1000030 c0126738 c012743e d1979be0 ce6f21e0 d12cf3e0 
    Jul 24 11:18:48 gronk kernel:        ce6f21e0 d1979be0 40065000 00000001 c012682a d1979be0 ce6f21e0 40065000 
    Jul 24 11:18:48 gronk kernel:        00000001 d0680194 d12cf3f8 c014c56b c2f94780 000008dc 000008dc 00000000 
    Jul 24 11:18:48 gronk kernel: Call Trace: [<c01366ae>] page_add_rmap [kernel] 0x2e 
    Jul 24 11:18:48 gronk kernel: [<c0126738>] do_no_page [kernel] 0x1e8 
    Jul 24 11:18:48 gronk kernel: [<c012743e>] do_mmap_pgoff [kernel] 0x4ae 
    Jul 24 11:18:48 gronk kernel: [<c012682a>] handle_mm_fault [kernel] 0xca 
    Jul 24 11:18:48 gronk kernel: [<c014c56b>] get_empty_inode [kernel] 0x7b 
    Jul 24 11:18:48 gronk kernel: [<c01143aa>] do_page_fault [kernel] 0x12a 
    Jul 24 11:18:48 gronk kernel: [<c016a14d>] sys_shmget [kernel] 0x5d 
    Jul 24 11:18:48 gronk kernel: [<c010d653>] sys_ipc [kernel] 0x1b3 
    Jul 24 11:18:48 gronk kernel: [<c0114280>] do_page_fault [kernel] 0x0 
    Jul 24 11:18:49 gronk kernel: [<c0108a14>] error_code [kernel] 0x34 
    Jul 24 11:18:50 gronk kernel: Code: 8b 02 a3 e8 ea 32 c0 89 d0 c7 02 00 00 00 00 c3 8d 74 26 00 

    >>EIP; c01369a5 <pte_chain_alloc+15/30>   <=====
    Trace; c01366ae <page_add_rmap+2e/40>
    Trace; c0126738 <do_no_page+1e8/210>
    Trace; c012743e <do_mmap_pgoff+4ae/5a0>
    Trace; c012682a <handle_mm_fault+ca/150>
    Trace; c014c56b <get_empty_inode+7b/80>
    Trace; c01143aa <do_page_fault+12a/45b>
    Trace; c016a14d <sys_shmget+5d/100>
    Trace; c010d653 <sys_ipc+1b3/270>
    Trace; c0114280 <do_page_fault+0/45b>
    Trace; c0108a14 <error_code+34/3c>
    Code;  c01369a5 <pte_chain_alloc+15/30>
    00000000 <_EIP>:
    Code;  c01369a5 <pte_chain_alloc+15/30>   <=====
       0:   8b 02                     mov    (%edx),%eax   <=====
    Code;  c01369a7 <pte_chain_alloc+17/30>
       2:   a3 e8 ea 32 c0            mov    %eax,0xc032eae8
    Code;  c01369ac <pte_chain_alloc+1c/30>
       7:   89 d0                     mov    %edx,%eax
    Code;  c01369ae <pte_chain_alloc+1e/30>
       9:   c7 02 00 00 00 00         movl   $0x0,(%edx)
    Code;  c01369b4 <pte_chain_alloc+24/30>
       f:   c3                        ret    
    Code;  c01369b5 <pte_chain_alloc+25/30>
      10:   8d 74 26 00               lea    0x0(%esi,1),%esi


    3 warnings and 6 errors issued.  Results may not be reliable.


uname -a:
Linux gronk 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown

dmesg:

    Linux version 2.4.18-3 (bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 07:37:53 EDT 2002
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
     BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 0000000013ffc000 (usable)
     BIOS-e820: 0000000013ffc000 - 0000000013fff000 (ACPI data)
     BIOS-e820: 0000000013fff000 - 0000000014000000 (ACPI NVS)
     BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
    On node 0 totalpages: 81916
    zone(0): 4096 pages.
    zone(1): 77820 pages.
    zone(2): 0 pages.
    Kernel command line: auto BOOT_IMAGE=linux ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.18-3
    Initializing CPU#0
    Detected 669.108 MHz processor.
    Console: colour VGA+ 80x25
    Calibrating delay loop... 1333.65 BogoMIPS
    Memory: 320000k/327664k available (1119k kernel code, 7276k reserved, 775k data, 280k init, 0k highmem)
    Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
    Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
    Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
    Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
    Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
    CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
    CPU: L1 I cache: 16K, L1 D cache: 16K
    CPU: L2 cache: 256K
    CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
    CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
    CPU: Intel Pentium III (Coppermine) stepping 01
    Enabling fast FPU save and restore... done.
    Enabling unmasked SIMD FPU exception support... done.
    Checking 'hlt' instruction... OK.
    POSIX conformance testing by UNIFIX
    mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
    mtrr: detected mtrr type: Intel
    PCI: PCI BIOS revision 2.10 entry at 0xf0890, last bus=1
    PCI: Using configuration type 1
    PCI: Probing PCI hardware
    Unknown bridge resource 0: assuming transparent
    PCI: Using IRQ router VIA [1106/0596] at 00:04.0
    Activating ISA DMA hang workarounds.
    isapnp: Scanning for PnP cards...
    isapnp: SB audio device quirk - increasing port range
    isapnp: AWE32 quirk - adding two ports
    isapnp: Card 'Creative SB AWE64  PnP'
    isapnp: 1 Plug & Play card detected total
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16)
    Starting kswapd
    VFS: Diskquotas version dquot_6.5.0 initialized
    pty: 2048 Unix98 ptys configured
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
    ttyS00 at 0x03f8 (irq = 4) is a 16550A
    ttyS01 at 0x02f8 (irq = 3) is a 16550A
    Real Time Clock Driver v1.10e
    block: 608 slots per queue, batch=152
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    VP_IDE: IDE controller on PCI bus 00 dev 21
    VP_IDE: chipset revision 16
    VP_IDE: not 100% native mode: will probe irqs later
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:04.1
        ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
        ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
    hda: Maxtor 54098H8, ATA DISK drive
    hdb: Maxtor 93652U8, ATA DISK drive
    hdc: IBM-DPTA-353750, ATA DISK drive
    hdd: SONY CD-ROM CDU5221, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=4982/255/63, UDMA(66)
    hdb: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=4441/255/63, UDMA(66)
    hdc: 73261440 sectors (37510 MB) w/1961KiB Cache, CHS=72680/16/63, UDMA(66)
    ide-floppy driver 0.99.newide
    Partition check:
     hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
     hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 >
     hdc: [PTBL] [4560/255/63] hdc1 hdc2 < hdc5 hdc6 hdc7 >
    Floppy drive(s): fd0 is 1.44M
    FDC 0 is a post-1991 82077
    RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
    ide-floppy driver 0.99.newide
    md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
    md: Autodetecting RAID arrays.
    md: autorun ...
    md: ... autorun DONE.
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    IP: routing cache hash table of 2048 buckets, 16Kbytes
    TCP: Hash tables configured (established 32768 bind 32768)
    Linux IP multicast router 0.06 plus PIM-SM
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    RAMDISK: Compressed image found at block 0
    Freeing initrd memory: 240k freed
    VFS: Mounted root (ext2 filesystem).
    SCSI subsystem driver Revision: 1.00
    kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
    PCI: Found IRQ 10 for device 00:0b.0
    scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
            <Adaptec 2940 Ultra2 SCSI adapter>
            aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

      Vendor: YAMAHA    Model: CRW4260           Rev: 1.0h
      Type:   CD-ROM                             ANSI SCSI revision: 02
      Vendor: HP        Model: C1537A            Rev: L907
      Type:   Sequential-Access                  ANSI SCSI revision: 02
    Journalled Block Device driver loaded
    EXT3-fs: INFO: recovery required on readonly filesystem.
    EXT3-fs: write access will be enabled during recovery.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: recovery complete.
    EXT3-fs: mounted filesystem with ordered data mode.
    Freeing unused kernel memory: 280k freed
    Adding Swap: 120452k swap-space (priority -1)
    Adding Swap: 112416k swap-space (priority -2)
    Adding Swap: 136512k swap-space (priority -3)
    usb.c: registered new driver usbdevfs
    usb.c: registered new driver hub
    usb-uhci.c: $Revision: 1.275 $ time 07:43:07 Apr 18 2002
    usb-uhci.c: High bandwidth mode enabled
    PCI: Found IRQ 9 for device 00:04.2
    PCI: Sharing IRQ 9 with 00:0d.0
    usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
    usb-uhci.c: Detected 2 ports
    usb.c: new USB bus registered, assigned bus number 1
    hub.c: USB hub found
    hub.c: 2 ports detected
    usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
    EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,9), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
    Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
    ide-floppy driver 0.99.newide
    hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
    Uniform CD-ROM driver Revision: 3.12
    hdd: DMA disabled
    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
    parport0: irq 7 detected
    PCI: Found IRQ 9 for device 00:0d.0
    PCI: Sharing IRQ 9 with 00:04.2
    3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
    00:0d.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800. Vers LK1.1.16
    ip_conntrack (2559 buckets, 20472 max)
    Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
    sb: Creative SB AWE64  PnP detected
    sb: ISAPnP reports 'Creative SB AWE64  PnP' at i/o 0x220, irq 5, dma 1, 5
    SB 4.16 detected OK (220)
    sb: 1 Soundblaster PnP card(s) found.

-- 
Jamie Zawinski
jwz@jwz.org             http://www.jwz.org/
jwz@dnalounge.com       http://www.dnalounge.com/
