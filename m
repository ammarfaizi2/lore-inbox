Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756691AbWKSOUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbWKSOUq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756693AbWKSOUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:20:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:58568 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1756691AbWKSOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:20:44 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
Date: Sun, 19 Nov 2006 15:19:50 +0100
User-Agent: KMail/1.9.5
References: <cb8795142da89.455f6345@shaw.ca>
In-Reply-To: <cb8795142da89.455f6345@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191519.50163.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. November 2006 01:47 schrieb ROBERT HANCOCK:
> Christian wrote:
> > During my I/O load test, after about half an hour of heavy I/O on three
> > SATAII disks the system suddenly hung for about 3 seconds. After that I
> > checked dmesg and found the following error output:
> >
> > [ 4574.193809] ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0
> > gen_ctl 0x1501000 status 0x400
> > [ 4574.193826] ata2: CPB 0: ctl_flags 0x1f, resp_flags 0x1
> > [ 4574.193835] ata2: CPB 1: ctl_flags 0x1f, resp_flags 0x2
>
> All this output is from the debugging code I have in the error handler in
> sata_nv for ADMA mode.
>
> > [ 4574.194366] ata2: Resetting port
> > [ 4574.194411] ata2.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2
> > frozen
> > [ 4574.194453] ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0
> > (timeout)
>
> Hmm, it looks like the controller thinks the command has been sent to the
> drive and has "released" the command for the drive to do its thing, and
> hasn't received a response back yet. (At least that's what I believe bit 1
> in the response flags means..) This might not be the fault of the
> controller or driver, it might just be the drive not responding. Can you
> post some drive information (like full dmesg from bootup)? -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

FYI:
My system config is one 400GB disk at sda, and two 250GB disks on a dmraid 
nvidia-fakeraid set of sdb and sdc.

My kernel message buffer gets quickly overrun by a flood of these error 
messages:

Nov 17 22:48:12 ubuntu kernel: [  119.566540] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.566602] sdb: rw=0, want=976784000, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.566661] printk: 62 messages suppressed.
Nov 17 22:48:12 ubuntu kernel: [  119.566719] Buffer I/O error on device sdb3, 
logical block 669380224
Nov 17 22:48:12 ubuntu kernel: [  119.566779] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.566836] sdb: rw=0, want=976784001, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.566892] Buffer I/O error on device sdb3, 
logical block 669380225
Nov 17 22:48:12 ubuntu kernel: [  119.566951] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567009] sdb: rw=0, want=976784002, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567066] Buffer I/O error on device sdb3, 
logical block 669380226
Nov 17 22:48:12 ubuntu kernel: [  119.567124] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567184] sdb: rw=0, want=976784003, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567241] Buffer I/O error on device sdb3, 
logical block 669380227
Nov 17 22:48:12 ubuntu kernel: [  119.567299] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567400] sdb: rw=0, want=976784004, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567457] Buffer I/O error on device sdb3, 
logical block 669380228
Nov 17 22:48:12 ubuntu kernel: [  119.567515] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567572] sdb: rw=0, want=976784005, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567629] Buffer I/O error on device sdb3, 
logical block 669380229
Nov 17 22:48:12 ubuntu kernel: [  119.567687] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567744] sdb: rw=0, want=976784006, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567800] Buffer I/O error on device sdb3, 
logical block 669380230
Nov 17 22:48:12 ubuntu kernel: [  119.567868] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.567925] sdb: rw=0, want=976784007, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.567982] Buffer I/O error on device sdb3, 
logical block 669380231
Nov 17 22:48:12 ubuntu kernel: [  119.568042] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.568098] sdb: rw=0, want=976784000, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.568159] Buffer I/O error on device sdb3, 
logical block 669380224
Nov 17 22:48:12 ubuntu kernel: [  119.568217] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.568274] sdb: rw=0, want=976784001, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [  119.568332] Buffer I/O error on device sdb3, 
logical block 669380225
Nov 17 22:48:12 ubuntu kernel: [  119.568390] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [  119.568447] sdb: rw=0, want=976784002, 
limit=488397168


Here is the relevant content of /var/log/kern.log:

Nov 17 22:48:12 ubuntu kernel: Inspecting /boot/System.map-2.6.19-rc5-mm1
Nov 17 22:48:12 ubuntu kernel: Loaded 26134 symbols 
from /boot/System.map-2.6.19-rc5-mm1.
Nov 17 22:48:12 ubuntu kernel: Symbols match kernel version 2.6.19.
Nov 17 22:48:12 ubuntu kernel: No module symbols loaded - kernel modules not 
enabled.
Nov 17 22:48:12 ubuntu kernel:   50.068747] scsi2 : sata_nv
Nov 17 22:48:12 ubuntu kernel: [   50.521057] ata1: SATA link up 3.0 Gbps 
(SStatus 123 SControl 300)
Nov 17 22:48:12 ubuntu kernel: [   50.522095] ata3: SATA link up 3.0 Gbps 
(SStatus 123 SControl 300)
Nov 17 22:48:12 ubuntu kernel: [   50.525228] ata1.00: ATA-7, max UDMA7, 
781422768 sectors: LBA48 NCQ (depth 31/32)
Nov 17 22:48:12 ubuntu kernel: [   50.525319] ata1.00: ata1: dev 0 multi count 
16
Nov 17 22:48:12 ubuntu kernel: [   50.529045] ata3.00: ATA-7, max UDMA7, 
488397168 sectors: LBA48 NCQ (depth 31/32)
Nov 17 22:48:12 ubuntu kernel: [   50.529136] ata3.00: ata3: dev 0 multi count 
16
Nov 17 22:48:12 ubuntu kernel: [   50.556623] ata1.00: configured for UDMA/133
Nov 17 22:48:12 ubuntu kernel: [   50.557059] scsi1 : sata_nv
Nov 17 22:48:12 ubuntu kernel: [   50.562842] ata3.00: configured for UDMA/133
Nov 17 22:48:12 ubuntu kernel: [   50.562942] scsi3 : sata_nv
Nov 17 22:48:12 ubuntu kernel: [   50.859873] ata2: SATA link down (SStatus 0 
SControl 300)
Nov 17 22:48:12 ubuntu kernel: [   50.860017] scsi 0:0:0:0: Direct-Access     
ATA      SAMSUNG HD401LJ  ZZ10 PQ: 0 ANSI: 5
Nov 17 22:48:12 ubuntu kernel: [   50.860110] ata1: bounce limit 
0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Nov 17 22:48:12 ubuntu kernel: [   50.863680] SCSI device sda: 781422768 
512-byte hdwr sectors (400088 MB)
Nov 17 22:48:12 ubuntu kernel: [   50.863750] sda: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   50.863806] sda: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   50.863816] SCSI device sda: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   50.863909] SCSI device sda: 781422768 
512-byte hdwr sectors (400088 MB)
Nov 17 22:48:12 ubuntu kernel: [   50.863973] sda: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   50.864029] sda: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   50.864039] SCSI device sda: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   50.864098]  sda: sda1
Nov 17 22:48:12 ubuntu kernel: [   50.887940] sd 0:0:0:0: Attached scsi disk 
sda
Nov 17 22:48:12 ubuntu kernel: [   51.016792] ata4: SATA link up 3.0 Gbps 
(SStatus 123 SControl 300)
Nov 17 22:48:12 ubuntu kernel: [   51.019832] ata4.00: ATA-7, max UDMA7, 
488397168 sectors: LBA48 NCQ (depth 31/32)
Nov 17 22:48:12 ubuntu kernel: [   51.019923] ata4.00: ata4: dev 0 multi count 
16
Nov 17 22:48:12 ubuntu kernel: [   51.062341] ata4.00: configured for UDMA/133
Nov 17 22:48:12 ubuntu kernel: [   51.062470] scsi 2:0:0:0: Direct-Access     
ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
Nov 17 22:48:12 ubuntu kernel: [   51.062563] ata3: bounce limit 
0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Nov 17 22:48:12 ubuntu kernel: [   51.063186] SCSI device sdb: 488397168 
512-byte hdwr sectors (250059 MB)
Nov 17 22:48:12 ubuntu kernel: [   51.063257] sdb: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   51.063312] sdb: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   51.063323] SCSI device sdb: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   51.063413] SCSI device sdb: 488397168 
512-byte hdwr sectors (250059 MB)
Nov 17 22:48:12 ubuntu kernel: [   51.063475] sdb: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   51.063530] sdb: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   51.063539] SCSI device sdb: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   51.063601]  sdb: sdb1 sdb2 sdb3
Nov 17 22:48:12 ubuntu kernel: [   51.072794]  sdb: p3 exceeds device capacity
Nov 17 22:48:12 ubuntu kernel: [   51.072895] sd 2:0:0:0: Attached scsi disk 
sdb
Nov 17 22:48:12 ubuntu kernel: [   51.073439] scsi 3:0:0:0: Direct-Access     
ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
Nov 17 22:48:12 ubuntu kernel: [   51.073532] ata4: bounce limit 
0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Nov 17 22:48:12 ubuntu kernel: [   51.074110] SCSI device sdc: 488397168 
512-byte hdwr sectors (250059 MB)
Nov 17 22:48:12 ubuntu kernel: [   51.074180] sdc: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   51.074235] sdc: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   51.074245] SCSI device sdc: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   51.074334] SCSI device sdc: 488397168 
512-byte hdwr sectors (250059 MB)
Nov 17 22:48:12 ubuntu kernel: [   51.074396] sdc: Write Protect is off
Nov 17 22:48:12 ubuntu kernel: [   51.074451] sdc: Mode Sense: 00 3a 00 00
Nov 17 22:48:12 ubuntu kernel: [   51.074461] SCSI device sdc: drive cache: 
write back
Nov 17 22:48:12 ubuntu kernel: [   51.074518]  sdc: unknown partition table
Nov 17 22:48:12 ubuntu kernel: [   51.085297] sd 3:0:0:0: Attached scsi disk 
sdc
Nov 17 22:48:12 ubuntu kernel: [   51.124775] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [   51.124836] sdb: rw=0, want=976784000, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [   51.124894] Buffer I/O error on device sdb3, 
logical block 669380224
Nov 17 22:48:12 ubuntu kernel: [   51.124955] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [   51.125012] sdb: rw=0, want=976784001, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [   51.125068] Buffer I/O error on device sdb3, 
logical block 669380225
Nov 17 22:48:12 ubuntu kernel: [   51.125126] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [   51.125183] sdb: rw=0, want=976784002, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [   51.125239] Buffer I/O error on device sdb3, 
logical block 669380226
Nov 17 22:48:12 ubuntu kernel: [   51.125297] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [   51.125354] sdb: rw=0, want=976784003, 
limit=488397168
Nov 17 22:48:12 ubuntu kernel: [   51.125410] Buffer I/O error on device sdb3, 
logical block 669380227
Nov 17 22:48:12 ubuntu kernel: [   51.125468] attempt to access beyond end of 
device
Nov 17 22:48:12 ubuntu kernel: [   51.125524] sdb: rw=0, want=976784004, 
limit=488397168


user@ubuntu:~$ sudo hdparm -I /dev/sd[a-c]

/dev/sda:

ATA device, with non-removable media
        Model Number:       SAMSUNG HD401LJ
        Serial Number:      S0HVJ1FL900207
        Firmware Revision:  ZZ100-15
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 4a
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  781422768
        device size with M = 1024*1024:      381554 MBytes
        device size with M = 1000*1000:      400088 MBytes (400 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
udma7
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        228min for SECURITY ERASE UNIT. 228min for ENHANCED SECURITY ERASE 
UNIT.
Checksum: correct

/dev/sdb:

ATA device, with non-removable media
        Model Number:       SAMSUNG SP2504C
        Serial Number:      S09QJ1LYC06381
        Firmware Revision:  VT100-33
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 4a
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  488397168
        device size with M = 1024*1024:      238475 MBytes
        device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
udma7
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        120min for SECURITY ERASE UNIT. 120min for ENHANCED SECURITY ERASE 
UNIT.
Checksum: correct

/dev/sdc:

ATA device, with non-removable media
        Model Number:       SAMSUNG SP2504C
        Serial Number:      S09QJ10L420645
        Firmware Revision:  VT100-41
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 4a
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  488397168
        device size with M = 1024*1024:      238475 MBytes
        device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
udma7
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        88min for SECURITY ERASE UNIT. 88min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct


Hope that helps!


p.s:
Why does the kernel report a queue depth of 31/32, but hdparm says its 32? Is 
this correct?

ata1.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 31/32)

-Christian
