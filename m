Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273426AbRINSiv>; Fri, 14 Sep 2001 14:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273441AbRINSif>; Fri, 14 Sep 2001 14:38:35 -0400
Received: from marla.i2net.com ([208.179.142.252]:64266 "HELO marla.i2net.com")
	by vger.kernel.org with SMTP id <S273426AbRINSiU>;
	Fri, 14 Sep 2001 14:38:20 -0400
Message-ID: <3BA24EB0.5000402@i2net.com>
Date: Fri, 14 Sep 2001 11:38:40 -0700
From: J <jack@i2net.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: keicher@nws.gov
Subject: 0-order allocation failed in 2.4.10-pre8
Content-Type: multipart/mixed;
 boundary="------------080709040900050901000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709040900050901000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
    I am reporting the same problem that kelley eicher
has, "0-order allocation failed (gfp=0x70/1)", hopefully
my info is helpfull. I added BUG() after the printk's in
"mm/page_alloc.c:505". I am able to get this message
when ever I copy a large (2+ gig) file from one XFS filesystem
to another on the same disk controller. I have attached klogd -p output
and an output of /proc/slabinfo from <= 1 second before the
Oops. If anyone would like more info, or for me to apply dangerous
patches, or to shut up even, let me know.

Jack

Machine:
Kernel Version 2.4.10-pre8 with SGI-XFS patches and IBM-JFS patches.
compiled with egcs 2.91-66 ;) (Some more info @ http://whatevr.i2net.com)
SMP P3 Box with 2 Gig of memory
Disk controller that helps to get this message: cpqarray (Smart Array 
3200 with 6 disks)


--------------080709040900050901000301
Content-Type: text/plain;
 name="slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo"

slabinfo - version: 1.1 (SMP)
kmem_cache            96     96    244    6    6    1 :  252  126
ip_fib_hash           25    226     32    2    2    1 :  252  126
fib6_nodes             5    226     32    2    2    1 :  252  126
ip6_dst_cache         11     40    192    2    2    1 :  252  126
ndisc_cache            1     30    128    1    1    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket         60     60    128    2    2    1 :  252  126
tcp_bind_bucket        6    226     32    2    2    1 :  252  126
tcp_open_request      40     40     96    1    1    1 :  252  126
inet_peer_cache        1     59     64    1    1    1 :  252  126
ip_dst_cache         120    120    192    6    6    1 :  252  126
arp_cache             60     60    128    2    2    1 :  252  126
urb_priv               0      0     64    0    0    1 :  252  126
hpsb_packet            0      0     96    0    0    1 :  252  126
blkdev_requests     1280   1280     96   32   32    1 :  252  126
xfs_chashlist        863   1010     16    5    5    1 :  252  126
xfs_ili             1008   1008    136   36   36    1 :  252  126
xfs_ifork              0      0     56    0    0    1 :  252  126
xfs_efi_item          15     15    260    1    1    1 :  124   62
xfs_efd_item          15     15    260    1    1    1 :  124   62
xfs_buf_item         104    104    148    4    4    1 :  252  126
xfs_dabuf            202    202     16    1    1    1 :  252  126
xfs_da_state          22     22    340    2    2    1 :  124   62
xfs_trans            129    132    320   11   11    1 :  124   62
xfs_inode           7706   9160    468 1140 1145    1 :  124   62
xfs_btree_cur         28     28    140    1    1    1 :  252  126
xfs_bmap_free_item    202    202     16    1    1    1 :  252  126
page_buf_t           300    300    192   15   15    1 :  252  126
page_buf_reg_t         7     80     96    2    2    1 :  252  126
avl_object_t           7    226     32    2    2    1 :  252  126
avl_entry_t          273    565     32    5    5    1 :  252  126
nfs_read_data          0      0    384    0    0    1 :  124   62
nfs_write_data         0      0    384    0    0    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       84     84     92    2    2    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache              2    226     32    2    2    1 :  252  126
skbuff_head_cache    209    240    160   10   10    1 :  252  126
sock                  32     32    928    8    8    1 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache           118    118     64    2    2    1 :  252  126
bdev_cache            16    118     64    2    2    1 :  252  126
mnt_cache             19    118     64    2    2    1 :  252  126
inode_cache         8408  13096    480 1637 1637    1 :  124   62
dentry_cache        1929  14370    128  479  479    1 :  252  126
dquot                  0      0     96    0    0    1 :  252  126
filp                 359    400     96   10   10    1 :  252  126
names_cache            3      3   4096    3    3    1 :   60   30
buffer_head       490132 492440     96 12285 12311    1 :  252  126
mm_struct            120    120    160    5    5    1 :  252  126
vm_area_struct      1711   1711     64   29   29    1 :  252  126
fs_cache             177    177     64    3    3    1 :  252  126
files_cache           99     99    416   11   11    1 :  124   62
signal_act            57     57   1312   19   19    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536            16     16  65536   16   16   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             8      9  16384    8    9    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              4      4   8192    4    4    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             51     51   4096   51   51    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            108    108   2048   54   54    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            173    200   1024   50   50    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             304    304    512   38   38    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             195    195    256   13   13    1 :  252  126
size-128(DMA)          2     30    128    1    1    1 :  252  126
size-128             900    900    128   30   30    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              531    531     64    9    9    1 :  252  126
size-32(DMA)          34    113     32    1    1    1 :  252  126
size-32             2456   3955     32   35   35    1 :  252  126

--------------080709040900050901000301
Content-Type: text/plain;
 name="klogd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="klogd"

klogd 1.3-3, log source = /proc/kmsg started.
Inspecting /boot/System.map
Loaded 22179 symbols from /boot/System.map.
Symbols match kernel version 2.4.10.
Loaded 14 symbols from 2 modules.
phys ID: 1) waiting for CALLOUT
<4>Startup point 1.
<4>Waiting for send to finish...
<4>+Sending STARTUP #2.
<4>After apic_write.
<4>Startup point 1.
<4>Waiting for send to finish...
<4>+After Startup.
<4>Before Callout 1.
<4>After Callout 1.
<4>CALLIN, before setup_local_APIC().
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 1595.80 BogoMIPS
<4>Stack at about c3219fbc
<7>CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
<5>CPU serial number disabled.
<7>CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383fbff 00000000 00000000 00000000
<4>OK.
<4>CPU1: Intel Pentium III (Coppermine) stepping 06
<4>CPU has booted.
<4>Before bogomips.
<6>Total of 2 processors activated (3188.32 BogoMIPS).
<4>Before bogocount - setting activated=1.
<4>Boot done.
<4>ENABLING IO-APIC IRQs
<6>...changing IO-APIC physical APIC ID to 2 ... ok.
<4>Synchronizing Arb IDs.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-3, 2-7, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
<6>..TIMER: vector=31 pin1=2 pin2=0
<6>activating NMI Watchdog ... done.
<4>CPU#0 NMI appears to be stuck.
<7>number of MP IRQ sources: 23.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00178011
<7>.......     : max redirection entries: 0017
<7>.......     : IO APIC version: 0011
<4> WARNING: unexpected IO-APIC, please mail
<4>          to linux-smp@vger.kernel.org
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 003 03  0    0    0   0   0    1    1    31
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 003 03  0    0    0   0   0    1    1    41
<7> 05 003 03  0    0    0   0   0    1    1    49
<7> 06 003 03  0    0    0   0   0    1    1    51
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 003 03  0    0    0   0   0    1    1    59
<7> 09 003 03  0    0    0   0   0    1    1    61
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 003 03  0    0    0   0   0    1    1    69
<7> 0d 003 03  0    0    0   0   0    1    1    71
<7> 0e 003 03  0    0    0   0   0    1    1    79
<7> 0f 003 03  0    0    0   0   0    1    1    81
<7> 10 003 03  1    1    0   1   0    1    1    89
<7> 11 003 03  1    1    0   1   0    1    1    91
<7> 12 003 03  1    1    0   1   0    1    1    99
<7> 13 003 03  1    1    0   1   0    1    1    A1
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 2
<7>IRQ1 -> 1
<7>IRQ4 -> 4
<7>IRQ5 -> 5
<7>IRQ6 -> 6
<7>IRQ8 -> 8
<7>IRQ9 -> 9
<7>IRQ12 -> 12
<7>IRQ13 -> 13
<7>IRQ14 -> 14
<7>IRQ15 -> 15
<7>IRQ16 -> 16
<7>IRQ17 -> 17
<7>IRQ18 -> 18
<7>IRQ19 -> 19
<6>.................................... done.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 798.6890 MHz.
<4>..... host bus clock speed is 133.1147 MHz.
<4>cpu: 0, clocks: 1331147, slice: 443715
<4>CPU0<T0:1331136,T1:887408,D:13,S:443715,C:1331147>
<4>cpu: 1, clocks: 1331147, slice: 443715
<4>CPU1<T0:1331136,T1:443696,D:10,S:443715,C:1331147>
<4>checking TSC synchronization across CPUs: passed.
<4>Setting commenced=1, go go go
<4>mtrr: your CPUs had inconsistent fixed MTRR settings
<4>mtrr: your CPUs had inconsistent variable MTRR settings
<4>mtrr: probably your BIOS does not setup all CPUs
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=3
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Using IRQ router VIA [1106/0686] at 00:07.0
<4>querying PCI -> IRQ mapping bus:0, slot:7, pin:3.
<6>PCI->APIC IRQ transform: (B0,I7,P3) -> 19
<4>querying PCI -> IRQ mapping bus:0, slot:7, pin:3.
<6>PCI->APIC IRQ transform: (B0,I7,P3) -> 19
<4>querying PCI -> IRQ mapping bus:0, slot:9, pin:0.
<6>PCI->APIC IRQ transform: (B0,I9,P0) -> 16
<4>querying PCI -> IRQ mapping bus:0, slot:11, pin:0.
<6>PCI->APIC IRQ transform: (B0,I11,P0) -> 17
<4>querying PCI -> IRQ mapping bus:0, slot:13, pin:0.
<6>PCI->APIC IRQ transform: (B0,I13,P0) -> 18
<4>querying PCI -> IRQ mapping bus:0, slot:14, pin:0.
<6>PCI->APIC IRQ transform: (B0,I14,P0) -> 18
<4>querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
<6>PCI->APIC IRQ transform: (B1,I0,P0) -> 16
<4>querying PCI -> IRQ mapping bus:2, slot:4, pin:0.
<6>PCI->APIC IRQ transform: (B2,I4,P0) -> 17
<4>querying PCI -> IRQ mapping bus:2, slot:5, pin:0.
<6>PCI->APIC IRQ transform: (B2,I5,P0) -> 19
<4>querying PCI -> IRQ mapping bus:3, slot:0, pin:0.
<6>PCI->APIC IRQ transform: (B3,I0,P0) -> 19
<6>PCI: Enabling Via external APIC routing
<6>PCI: Via IRQ fixup for 00:07.2, from 10 to 3
<6>PCI: Via IRQ fixup for 00:07.3, from 10 to 3
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd v1.8
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<6>Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu
<5>udf: registering filesystem
<4>JFS development version: $Name: v1_0_4 $
<6>SGI XFS with ACLs, EAs, DMAPI, realtime, quota, no debug enabled
<4>i2c-core.o: i2c core module
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>Real Time Clock Driver v1.10e
<6>Non-volatile memory driver v1.1
<4>block: 128 slots per queue, batch=16
<4>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>VP_IDE: IDE controller on PCI bus 00 dev 39
<4>VP_IDE: chipset revision 6
<4>VP_IDE: not 100% native mode: will probe irqs later
<6>VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
<4>    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:pio
<4>HPT370: IDE controller on PCI bus 00 dev 70
<4>HPT370: chipset revision 3
<4>HPT370: not 100% native mode: will probe irqs later
<4>    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:DMA
<4>    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
<4>hda: Maxtor 51536U3, ATA DISK drive
<4>hdc: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
<4>hde: WDC WD400AB-00BVA0, ATA DISK drive
<4>hdf: WDC WD400AB-00BVA0, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xd800-0xd807,0xdc02 on irq 18
<6>hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=29777/16/63, UDMA(66)
<6>hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
<6>hdf: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
<6>Partition check:
<6> hda: hda1 hda2 hda3
<6> hde: [PTBL] [4865/255/63] hde1
<6> hdf: unknown partition table
<6>Floppy drive(s): fd0 is 2.88M AMI BIOS
<6>FDC 0 is a post-1991 82077
<7>cpqarray: Device 0xe11 has been found at bus 3 dev 0 func 0
<4>Compaq SMART2 Driver (v 2.4.5)
<4>Found 1 controller(s)
<6>cpqarray: Finding drives on ida0 (Smart Array 3200)
<6>cpqarray ida/c0d0: blksz=512 nr_blks=44055840
<6> ida/c0d0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
<6>NET4: Frame Diverter 0.46
<6>SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
<4>CSLIP: code copyright 1989 Regents of the University of California.
<6>SLIP linefill/keepalive option.
<6>loop: loaded (max 8 devices)
<4>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
<4>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
<7>divert: allocating divert_blk for eth0
<6>eth0: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:95:58:FA, IRQ 17.
<6>  Receiver lock-up bug exists -- enabling work-around.
<6>  Board assembly 009542-003, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x24c9f043).
<6>  Receiver lock-up workaround activated.
<7>divert: allocating divert_blk for eth1
<6>eth1: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:95:58:FB, IRQ 19.
<6>  Receiver lock-up bug exists -- enabling work-around.
<6>  Board assembly 009542-003, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x24c9f043).
<6>  Receiver lock-up workaround activated.
<6>PPP generic driver version 2.4.1
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<7>divert: not allocating divert_blk for non-ethernet device dummy0
<7>divert: not allocating divert_blk for non-ethernet device bond0
<7>divert: not allocating divert_blk for non-ethernet device eql
<4>Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes (simon@ncm.com)
<6>Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
<6>Linux video capture interface: v1.00
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 816M
<6>agpgart: Detected Via Apollo Pro chipset
<6>agpgart: AGP aperture is 16M @ 0xda000000
<6>SCSI subsystem driver Revision: 1.00
<5>megaraid: v1.17a (Release Date: Fri Jul 13 18:44:01 EDT 2001)
<5>megaraid: found 0x101e:0x9010:idx 0:bus 0:slot 13:func 0
<5>scsi0 : Found a MegaRAID controller at 0xd410, IRQ: 18
<5>megaraid: [A :A ] detected 2 logical drives
<5>megaraid: channel[1] is raid.
<5>megaraid: channel[2] is raid.
<5>megaraid: channel[3] is raid.
<4>megaraid: no BIOS enabled.
<6>scsi0 : AMI MegaRAID A  254 commands 16 targs 3 chans 8 luns
<5>scsi0: scanning channel 1 for devices.
<5>scsi0: scanning channel 2 for devices.
<5>scsi0: scanning channel 3 for devices.
<5>scsi0: scanning virtual channel for logical drives.
<4>  Vendor: MegaRAID  Model: LD0 RAID5 17354R  Rev:   A 
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: MegaRAID  Model: LD1 RAID5  8128R  Rev:   A 
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<6>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
<4>  Vendor: CREATIVE  Model: DVD5240E-1        Rev: 1.20
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>Attached scsi disk sda at scsi0, channel 3, id 0, lun 0
<4>Attached scsi disk sdb at scsi0, channel 3, id 0, lun 1
<4>SCSI device sda: 35540992 512-byte hdwr sectors (18197 MB)
<6> sda: sda1
<4>SCSI device sdb: 16646144 512-byte hdwr sectors (8523 MB)
<6> sdb: sdb1
<4>Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
<4>sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<6>usb.c: registered new driver hub
<6>usb-uhci.c: $Revision: 1.268 $ time 19:17:49 Sep 13 2001
<6>usb-uhci.c: High bandwidth mode enabled
<6>usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 19
<4>usb-uhci.c: Detected 2 ports
<6>usb.c: new USB bus registered, assigned bus number 1
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<6>usb-uhci.c: USB UHCI at I/O 0xc000, IRQ 19
<4>usb-uhci.c: Detected 2 ports
<6>usb.c: new USB bus registered, assigned bus number 2
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<6>usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
<6>Initializing USB Mass Storage driver...
<6>usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>mice: PS/2 mouse device common for all mice
<5>IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 16384 buckets, 128Kbytes
<4>TCP: Hash tables configured (established 262144 bind 65536)
<6>IPv4 over IPv4 tunneling driver
<7>divert: not allocating divert_blk for non-ethernet device tunl0
<6>GRE over IPv4 tunneling driver
<7>divert: not allocating divert_blk for non-ethernet device gre0
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>IPv6 v0.8 for NET4.0
<6>IPv6 over IPv4 tunneling driver
<7>divert: not allocating divert_blk for non-ethernet device sit0
<6>NET4: Ethernet Bridge 008 for NET4.0
<4>XFS mounting filesystem ida0(72,5)
<4>XFS: WARNING: recovery required on readonly filesystem.
<4>XFS: write access will be enabled during mount.
<4>Starting XFS recovery on filesystem: ida0(72,5) (dev: 72/5)
<4>Ending XFS recovery on filesystem: ida0(72,5) (dev: 72/5)
<4>VFS: Mounted root (xfs filesystem) readonly.
<4>Freeing unused kernel memory: 236k freed
<6>Adding Swap: 975096k swap-space (priority -1)
<4>XFS mounting filesystem ida0(72,8)
<4>Starting XFS recovery on filesystem: ida0(72,8) (dev: 72/8)
<4>Ending XFS recovery on filesystem: ida0(72,8) (dev: 72/8)
<4>XFS mounting filesystem ida0(72,6)
<4>Starting XFS recovery on filesystem: ida0(72,6) (dev: 72/6)
<4>Ending XFS recovery on filesystem: ida0(72,6) (dev: 72/6)
<4>XFS mounting filesystem ida0(72,7)
<4>Starting XFS recovery on filesystem: ida0(72,7) (dev: 72/7)
<4>Ending XFS recovery on filesystem: ida0(72,7) (dev: 72/7)
<4>XFS mounting filesystem ida0(72,9)
<4>Starting XFS recovery on filesystem: ida0(72,9) (dev: 72/9)
<4>Ending XFS recovery on filesystem: ida0(72,9) (dev: 72/9)
<4>XFS mounting filesystem ida0(72,11)
<4>Starting XFS recovery on filesystem: ida0(72,11) (dev: 72/11)
<4>Ending XFS recovery on filesystem: ida0(72,11) (dev: 72/11)
<4>reiserfs: checking transaction log (device 08:11) ...
<4>Using tea hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>jfs_mount: Mount Failure: File System Dirty.
<4>Mount JFS Failure: 22
<4>jfs_mount failed w/return code = 22
<6> ataraida: ataraida1
<6>Highpoint HPT370 Softwareraid driver for linux version 0.01
<6>Drive 0 is 38166 Mb 
<6>Drive 1 is 38166 Mb 
<6>Raid array consists of 2 drives. 
<7>VFS: Disk change detected on device ide1(22,0)
<3>ide-scsi: hdc: unsupported command in request queue (0)
<4>end_request: I/O error, dev 16:00 (hdc), sector 64
<4>isofs_read_super: bread failed, dev=16:00, iso_blknum=16, block=32
<7>eth0: no IPv6 routers present
<7>bond0: no IPv6 routers present
<7>eth1: no IPv6 routers present
<7>Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
<7>SMSC Super-IO detection, now testing Ports 2F0, 370 ...
<6>parport_pc: Via 686A parallel port disabled in BIOS
<6>lp: driver loaded but no devices found
<6>[drm] Initialized tdfx 1.0.0 20010216 on minor 0
<6>[drm] Initialized tdfx 1.0.0 20010216 on minor 1
<6>es1371: version v0.30 time 14:39:43 Sep 13 2001
<6>es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
<6>es1371: found es1371 rev 6 at io 0xcc00 irq 17
<6>es1371: features: joystick 0x0
<6>ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
<4>XFS mounting filesystem ataraid(114,1)
<4>EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
<3>__alloc_pages: 0-order allocation failed (gfp=0x70/1).
<4>invalid operand: 0000
<4>CPU:    0
<4>EIP:    0010:[__alloc_pages+602/616]
<4>EFLAGS: 00010282
<4>eax: 0000003a   ebx: 00000000   ecx: 00000002   edx: 00000002
<4>esi: c0433628   edi: 00000000   ebp: f7bfa000   esp: f7bfbdc8
<4>ds: 0018   es: 0018   ss: 0018
<4>Process kswapd (pid: 5, stackpage=f7bfb000)
<4>Stack: 00000070 f6feeb40 00001089 c04d7c80 00000000 00000010 00000001 c043361c 
<4>       00000070 c012eb20 c0647240 c0133425 c0647240 c013356c f6feeb40 f6feeb40 
<4>       00000001 c04d7c80 f5ce2e00 c04d7c80 c04d7c80 f7b6a260 c04d7ca8 00000002 
<4>Call Trace: [_alloc_pages+24/28] [alloc_bounce_page+13/144] [create_bounce+48/524] [__make_request+342/1848] [__make_request+1027/1848] 
<4>   [__make_request+155/1848] [start_io+126/232] [generic_make_request+160/292] [submit_bh+66/96] [convert_page+140/180] [cluster_write+186/208] 
<4>   [pagebuf_delalloc_convert+196/208] [pagebuf_write_full_page+118/604] [linvfs_pb_bmap+0/188] [linvfs_write_full_page+15/32] [linvfs_pb_bmap+0/188] [page_launder+683/1504] 
<4>   [do_try_to_free_pages+83/196] [kswapd+105/172] [rest_init+0/68] [kernel_thread+35/48] 
<4>
<4>Code: 0f 0b 31 c0 5b 5e 5f 5d 83 c4 14 c3 89 f6 83 fa 09 77 09 e8 
<3>__alloc_pages: 0-order allocation failed (gfp=0x70/1).
<4>invalid operand: 0000
<4>CPU:    0
<4>EIP:    0010:[__alloc_pages+602/616]
<4>EFLAGS: 00010282
<4>eax: 0000003a   ebx: 00000000   ecx: 00000002   edx: 00000002
<4>esi: c0433628   edi: 00000000   ebp: f6df8000   esp: f6df9b2c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process cp (pid: 4304, stackpage=f6df9000)
<4>Stack: 00000070 f6d6d3c0 00001089 c04d7c80 00000000 00000010 00000001 c043361c 
<4>       00000070 c012eb20 c06270c0 c0133425 c06270c0 c013356c f6d6d3c0 f6d6d3c0 
<4>       00000001 c04d7c80 c04d7cb0 f6fe6980 c04d7c80 4807b8d8 c04d7ca8 00000002 
<4>Call Trace: [_alloc_pages+24/28] [alloc_bounce_page+13/144] [create_bounce+48/524] [__make_request+342/1848] [__make_request+402/1848] 
<4>   [__make_request+433/1848] [__make_request+155/1848] [generic_make_request+160/292] [submit_bh+66/96] [convert_page+140/180] [cluster_write+186/208] 
<4>   [pagebuf_delalloc_convert+196/208] [pagebuf_write_full_page+118/604] [linvfs_pb_bmap+0/188] [linvfs_write_full_page+15/32] [linvfs_pb_bmap+0/188] [page_launder+683/1504] 
<4>   [do_try_to_free_pages+83/196] [try_to_free_pages+34/44] [__alloc_pages+463/616] [_alloc_pages+24/28] [grab_cache_page+100/164] [__pagebuf_do_delwri+95/680] 
<4>   [linvfs_pb_bmap+170/188] [_pagebuf_file_write+367/552] [pagebuf_generic_file_write+279/1104] [linvfs_pb_bmap+0/188] [update_atime+68/72] [xfs_write+980/1768] 
<4>   [linvfs_pb_bmap+0/188] [linvfs_write+272/332] [sys_write+142/196] [system_call+51/56] 
<4>
<4>Code: 0f 0b 31 c0 5b 5e 5f 5d 83 c4 14 c3 89 f6 83 fa 09 77 09 e8 
<3>__alloc_pages: 0-order allocation failed (gfp=0x70/1).
<4>invalid operand: 0000
<4>CPU:    1
<4>EIP:    0010:[__alloc_pages+602/616]
<4>EFLAGS: 00010286
<4>eax: 0000003a   ebx: 00000000   ecx: 00000046   edx: 00000001
<4>esi: c0433628   edi: 00000000   ebp: f105a000   esp: f105bc00
<4>ds: 0018   es: 0018   ss: 0018
<4>Process analog (pid: 4679, stackpage=f105b000)
<4>Stack: 00000070 c35a6b40 00001089 c04d7c80 00000000 00000010 00000001 c043361c 
<4>       00000070 c012eb20 f503c900 c0133425 f503c900 c013356c c35a6b40 c35a6b40 
<4>       00000001 c04d7c80 c04d7cb0 c0f22660 c04d7c80 4807a000 c04d7ca8 00000002 
<4>Call Trace: [_alloc_pages+24/28] [alloc_bounce_page+13/144] [create_bounce+48/524] [__make_request+342/1848] [__make_request+402/1848] 
<4>   [__make_request+433/1848] [__make_request+155/1848] [generic_make_request+160/292] [submit_bh+66/96] [convert_page+140/180] [cluster_write+186/208] 
<4>   [pagebuf_delalloc_convert+196/208] [pagebuf_write_full_page+118/604] [linvfs_pb_bmap+0/188] [linvfs_write_full_page+15/32] [linvfs_pb_bmap+0/188] [page_launder+683/1504] 
<4>   [do_try_to_free_pages+83/196] [try_to_free_pages+34/44] [__alloc_pages+463/616] [_alloc_pages+24/28] [generic_file_readahead+470/632] [do_generic_file_read+520/1284] 
<4>   [generic_file_read+99/128] [file_read_actor+0/224] [xfs_read+654/728] [linvfs_read+163/208] [sys_read+142/196] [system_call+51/56] 
<4>
<4>Code: 0f 0b 31 c0 5b 5e 5f 5d 83 c4 14 c3 89 f6 83 fa 09 77 09 e8 

--------------080709040900050901000301--

