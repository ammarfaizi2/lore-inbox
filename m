Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUGOAej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUGOAej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGOAeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:34:06 -0400
Received: from intermedia.net ([64.78.61.105]:52264 "EHLO
	Ehost067.exch005intermedia.net") by vger.kernel.org with ESMTP
	id S266031AbUGOAPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:15:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problems with DMA on IDE/ServerWorks/Seagate.
Date: Wed, 14 Jul 2004 17:16:14 -0700
Message-ID: <7632915A8F000C4FAEFCF272A880344105095A@Ehost067.exch005intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with DMA on IDE/ServerWorks/Seagate.
Thread-Index: AcRqAPDs6TtIIcaSQ/iHhtOD/bOhKA==
From: "Dave Woods" <dwoods@fastclick.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Stephanie Marasciullo" <smarasciullo@fastclick.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please CC me on all replies, as I am not subscribed to the list.

We have diagnosed a problem (file corruption) using Ultra DMA & IDE with

ServerWorks OSB4 Chipset and Seagate drives under heavy disk I/O.
We were able to find a thread that discusses this problem in detail,
but dates back to 2001. We have nearly 100 boxes using this
configuration
with kernal 2.4.20, and we can reproduce the problem easily with a perl
script using md5 checksums.

The applicable thread is given below:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/1006.html

We've disabled DMA on several machines, and that appears to fix
the problem. However, despite seeing this workaround mentioned 
several times, we have not had any luck downshifting to mdma2.
Every time I attempt it, all disk accesses freeze up, and the box
has to be rebooted.

Our question: short of disabling DMA on all of our machines, what
other alternatives are there? I've played with using the hdparm -p
parameter prior to issuing hdparm -X34 and hdparm -d1, but it
doesn't like it. Is there a simple fix to this problem out there?

Thanks,
Dave Woods
FastClick
(805) 568-5334 x245
dwoods@fastclick.com
 

Detail system information below:

>From /proc/ide/drivers:
ide-cdrom version 4.59
ide-disk version 1.12
 
>From uname -a:
Linux ant1.fastclick.net 2.4.20 #1 SMP Mon Jul 5 16:46:48 GMT 2004 i686
unknown
 
>From /proc/version:
Linux version 2.4.20 (root@ant1.fastclick.net) (gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Mon Jul
 5 16:46:48 GMT 2004
 
>From iomem:
feafc000-feafcfff : ServerWorks OSB4/CSB5 OHCI USB Controller
 
>From ioports:
ffa0-ffaf : ServerWorks OSB4 IDE Controller
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
 
>From /proc/ide/ide0/config:
pci bus 00 device 79 vid 1166 did 0211 channel 0
66 11 11 02 05 00 00 02 00 8a 01 01 00 40 80 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d 20 5d 5d 00 20 00 00 08 00 00 00 00 00 00 00
00 00 00 00 01 00 02 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
>From /proc/ide/ide0/hda/settings:
 
name                    value           min             max
mode
----                    -----           ---             ---
----
acoustic                0               0               254
rw
address                 0               0               2
rw
bios_cyl                2434            0               65535
rw
bios_head               255             0               255
rw
bios_sect               63              0               63
rw
breada_readahead        8               0               255
rw
bswap                   0               0               1
r
current_speed           0               0               69
rw
failures                0               0               65535
rw
file_readahead          124             0               16384
rw
ide_scsi                0               0               1
rw
init_speed              0               0               69
rw
io_32bit                0               0               3
rw
keepsettings            0               0               1
rw
lun                     0               0               7
rw
max_failures            1               0               65535
rw
max_kb_per_request      128             1               255
rw
multcount               16              0               16
rw
nice1                   1               0               1
rw
nowerr                  0               0               1
rw
number                  0               0               3
rw
pio_mode                write-only      0               255
w
slow                    0               0               1
rw
unmaskirq               0               0               1
rw
using_dma               1               0               1
rw
wcache                  0               0               1
rw
 
>From hdparm -I /dev/hda:

/dev/hda:
 
non-removable ATA device, with non-removable media
        Model Number:           ST320011A                               
        Serial Number:          3HT22E5N            
        Firmware Revision:      3.10    
Standards:
        Supported: 1 2 3 4 5 
        Likely used: 5
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 39102336
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2048.0kB   ECC bytes: 4    Queue depth: 1
        Standby timer values: spec'd by standard
        r/w multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 65278
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 1
Checksum: correct
 
 
