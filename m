Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCHWWU>; Thu, 8 Mar 2001 17:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCHWWK>; Thu, 8 Mar 2001 17:22:10 -0500
Received: from Mail.Mankato.MSUS.EDU ([134.29.1.12]:51980 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id <S130008AbRCHWV5>;
	Thu, 8 Mar 2001 17:21:57 -0500
Message-ID: <3AA805DC.D7412B1E@mnsu.edu>
Date: Thu, 08 Mar 2001 16:21:17 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Organization: Minnesota State University, Mankato
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-lvm@sistina.com
Subject: lvm - lvm_map access beyond end of device
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Vital info:
    Linux-2.2.18
    LVM version 0.9  by Heinz Mauelshagen  (13/11/2000)
    gcc version 2.95.2
    GDT7563RN Firmware 2.27.04-R03F


After about 27 days of uptime one of our Linux machines that is being
used as a Samba, Netatalk, and FTP server; the main data mount went into
a read-only state.  The machine has a GDT7563RN ICP Vortex RAID card
with 6-SCSI channels.  Five channels are being used with nine 18GB disks
on each channel.  The RAID controller takes those 45 disks and makes
three RAID-5 units with two hot-spares.  We are using LVM to take those
three RAID disks and striping those to one big block device.  We are
mounting that 656GB disk as an EXT2 mount on /data.  During testing we
banged the h*ll out of it with multiple bonnie tests and never found a
problem.  But during normal use we got events in our syslog (attached),
also note the RAID controller showed no events.  After a umount of the
mounted filesystem, a reboot then a fsck the system worked fine.  There
were no bad reports from the fsck.  Yes, I said no bad reports from
fsck, it did take 3.5 hours though.  What's causing this?

Inline attachments syslog, dmesg-boot.

syslog:

Mar  8 01:15:47 files kernel: lvm - lvm_map access beyond end of device;
*rsector: 2451636592 or size: 8 wrong for minor:  0
Mar  8 01:15:47 files kernel: Bad lvm_map in ll_rw_block
Mar  8 01:15:47 files kernel: EXT2-fs error (device lvm(58,0)):
ext2_readdir: bad entry in directory #43122713: rec_len is smaller than
minimal - offset=0, inode=0, rec_len=0, name_len=0
Mar  8 01:15:47 files kernel: Remounting filesystem read-only
Mar  8 01:15:48 files kernel: lvm - lvm_map access beyond end of device;
*rsector: 2596938272 or size: 8 wrong for minor:  0
Mar  8 01:15:48 files kernel: Bad lvm_map in ll_rw_block
Mar  8 01:15:48 files kernel: EXT2-fs error (device lvm(58,0)):
ext2_readdir: bad entry in directory #43122714: rec_len is smaller than
minimal - offset=0, inode=0, rec_len=0, name_len=0
Mar  8 01:15:48 files kernel: Remounting filesystem read-only


dmesg-boot:
   1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    91
 0f 000 00  0    0    0   0   0    1    1    99
 10 0FF 0F  1    1    0   1   0    1    1    A1
 11 0FF 0F  1    1    0   1   0    1    1    A9
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 0FF 0F  1    1    0   1   0    1    1    B9
 16 000 00  1    0    0   0   0    0    0    00
 17 0FF 0F  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ19 -> 19
IRQ21 -> 21
IRQ23 -> 23
.................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfdab0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P0) -> 16
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
PCI->APIC IRQ transform: (B2,I7,P0) -> 23
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3060-0x3067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3068-0x306f, BIOS settings: hdc:pio, hdd:pio
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
LVM version 0.9  by Heinz Mauelshagen  (13/11/2000)
lvm
-- Driver successfully initialized
Configuring GDT-PCI HA at 0/13 IRQ 17
scsi0 : GDT7563RN
scsi : 1 host.
  Vendor: ICP       Model: Host Drive  #00   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ICP       Model: Host Drive  #15   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 15, lun 0
  Vendor: ICP       Model: Host Drive  #29   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 29, lun 0
scsi : detected 3 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 501790275 [245014 MB]
[245.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 465949260 [227514 MB]
[227.5 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 465949260 [227514 MB]
[227.5 GB]
Partition check:
 sda: sda1 sda2 sda3
 sdb: sdb1
 sdc: sdc1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed
Adding Swap: 2097136k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:D0:B7:88:55:39, IRQ 21.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  Forcing 100Mbs full-duplex operation.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
NET4: AppleTalk 0.18 for Linux NET4.0
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI
0/12/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
(scsi2) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI
0/12/1
(scsi2) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi2) Downloading sequencer code... 392 instructions downloaded
(scsi3) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI
0/16/0
(scsi3) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi3) Downloading sequencer code... 392 instructions downloaded
(scsi4) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI
0/16/1
(scsi4) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi4) Downloading sequencer code... 392 instructions downloaded
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi2 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi3 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi4 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi : 5 hosts.
(scsi2:0:6:0) Synchronous at 20.0 Mbyte/sec, offset 16.
  Vendor: TOSHIBA   Model: CD-ROM XM-6401TA  Rev: 1001
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: EXABYTE   Model: Exabyte EZ17      Rev: 1.07
  Type:   Medium Changer                     ANSI SCSI revision: 02
(scsi3:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: EXABYTE   Model: Mammoth2          Rev: v02j
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: EXABYTE   Model: EXB-210           Rev: 1.07
  Type:   Medium Changer                     ANSI SCSI revision: 02
(scsi4:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: EXABYTE   Model: Mammoth2          Rev: v02p
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi generic sg4 at scsi3, channel 0, id 0, lun 0
Detected scsi generic sg6 at scsi4, channel 0, id 0, lun 0
st: bufsize 32768, wrt 30720, max buffers 5, s/g segs 16.
Detected scsi tape st0 at scsi3, channel 0, id 1, lun 0
Detected scsi tape st1 at scsi4, channel 0, id 1, lun 0



