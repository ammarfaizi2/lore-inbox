Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTAZTaD>; Sun, 26 Jan 2003 14:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTAZTaD>; Sun, 26 Jan 2003 14:30:03 -0500
Received: from qwws.net ([213.133.103.108]:37828 "HELO qwwsII.qwws.net")
	by vger.kernel.org with SMTP id <S266967AbTAZTaB>;
	Sun, 26 Jan 2003 14:30:01 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Tom Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: poor IDE performance on ASUS P4PE with WD800JB
Date: Sun, 26 Jan 2003 20:39:38 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301262039.38783.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've asked this question in several Newsgroups but nobody was really
able to answer it. That's why I decided to send it to LKM. Please CC
me on your replies. Thanks!

I've got a question related to ide performance.
First of all my hardware:
Mainboard: ASUS P4PE (using onboard IDE but not S-ATA)
   http://www.asus.com/products/mb/socket478/p4pe/overview.htm
Harddisk: Western Digital WD800JB
   http://www.westerndigital.com/products/products.asp?DriveID=32


Now about the current performance (on 2.4.20 and almost the same on 2.5.56):

tom@storm:~$ sudo hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.27 seconds =474.07 MB/sec
 Timing buffered disk reads:  64 MB in  3.05 seconds = 20.98 MB/sec

The cache read time is pretty ok but the disk read time is below of
what I'd have expected. My expectations would have been around 40MB/sec.

Am I wrong with my expectations for this setup?
I'd really be interested in any suggestion about how I could omptimize
the system.


And here's some more information about the current settings (let me
know if you need anything else):

tom@storm:~$ sudo hdparm /dev/hda
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 255 (on)
 geometry     = 9729/255/63, sectors = 156301488, start = 0
 busstate     =  1 (on)


tom@storm:~$ sudo cat /proc/ide/hda/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                9729            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        255             0               255             rw
bswap                   0               0               1               r
current_speed           69              0               69              rw
failures                0               0               65535           rw
file_readahead          16384           0               16384           rw
ide_scsi                0               0               1               rw
init_speed              69              0               69              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      255             1               255             rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw


tom@storm:~$ sudo hdparm -I /dev/hda
/dev/hda:
non-removable ATA device, with non-removable media
        Model Number:           WDC WD800JB-00CRA1
        Serial Number:          WD-WMA8E3710419
        Firmware Revision:      17.07W17
Standards:
        Supported: 1 2 3 4 5
        Likely used: 5
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    57600           (obsolete)
        bytes/sector:   600             (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 156301488
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 8192.0kB   ECC bytes: 40   Queue depth: 1
        Standby timer values: spec'd by standard, with device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct



A full dmesg dump can be found at http://www.wnk.at/files/dmesg.txt


Thanks very much,
-- 
Tom Winkler
