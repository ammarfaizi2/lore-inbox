Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWEDU4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWEDU4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWEDU4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:56:15 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:38826 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030326AbWEDU4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:56:14 -0400
Message-ID: <445A6A6B.2090605@tlinx.org>
Date: Thu, 04 May 2006 13:56:11 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>, linux-kernel@vger.kernel.org
Subject: kernel keeps empty CDROM(DVD)-drive "busy";  (was Re: cdrom: a dirty
 CD can freeze your system)
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain>
In-Reply-To: <1146750532.20677.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> This is a known problem with the old IDE layer. There are several
> problems involved
>   
---
Maybe I'm running into this same problem.  Reading the archived
thread about the linux kernel burning out drives toggled a slight
"worry" bit in my head.  Perhaps this is "nothing to worry about"
(ignore the blinking warning light behind the curtain...) and is
another "artifact" of the "ancient" IDE driver code.

I have a Plextor IDE, internal CD/DVD writer.  There is no media in
the drive.  I _used_ to keep a blank CDROM (ready to burn) in the
drive if I wasn't "around", to keep dust from settling on the tray and
to have a CD ready-to-burn if I was logged in from the other room.  But
I kept getting read errors, on boot, so I tried not loading media, which
is where I'm at now.

After boot, the "active" light on the drive turns on for about 3-5
seconds, then blinks off for <1 second, then 3-5 seconds on
again...and repeat, as though it is trying to read a media, failing
then trying again. It repeats this for as long as the system is up.

I've set drive read-ahead to 0, write-cache to off (not that those
settings "should" make a difference with no media in the drive.  I
also tried telling the drive to "sleep" (via hdparm), to no
avail.

It "ignores" (gives another error, actually) an attempt to "eject"
from the command line.

It "ignores" pushing the device's door open button (unless I do it
after a power-cycle reset to the system).

It seems to work (at least last time I tried it) for reading CD's
and DVD's as well as burning CD's (haven't tried to burn any DVD's
with it).  However, having the device constantly "selected" and
_appearing_ to retry is a bit bothersome given the experience of
another poster in the archived thread that was mentioned -- i.e. --
their drive seemed to burn itself out.  I'm not having the exact
same symptoms, as I'm not trying to directly access the drive (nor
am I experiencing any kernel hangs; (sidenote: not running the
preempt kernel, but am running the "voluntary preempt" kernel).

Seeing the "access/select" light on most of the time, though, makes
me wonder if something may be getting worn.  Unfortunately, I
can't hear if the drive is actually running due to the whine of
multiple hard disks

In regards to error messages, after every boot, the kernel
issues some errors (there is no CD in the drive) regarding
drive errors on the cdrom:

hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x44 { AbortedCommand 
LastFailedSense=0x04 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Hardware error -- (Sense key=0x04)
  Tracking servo failure -- (asc=0x09, ascq=0x01)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
ACPI: PCI Interrupt 0000:03:0a.0[A] -> GSI 18 (level, low) -> IRQ 17

---
    The above comes out when the IDE devices are probed during boot
(followed by a SCSI sda disk probe).

    At file-system mount time, I see another few errors (even though there
the cdrom related mount lines in fstab are commented out, specifically to
try to silence these error messages):
...
XFS mounting filesystem hdg1
Ending clean XFS mount for filesystem: hdg1
Adding 265064k swap on /dev/sda2.  Priority:-1 extents:1 across:265064k
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x44 { AbortedCommand 
LastFailedSense=0x04 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Hardware error -- (Sense key=0x04)
  Tracking servo failure -- (asc=0x09, ascq=0x01)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x44 { AbortedCommand 
LastFailedSense=0x04 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Hardware error -- (Sense key=0x04)
  Tracking servo failure -- (asc=0x09, ascq=0x01)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
---
Hdparm (FWIW) shows:
hdparm -vi /dev/hdc

/dev/hdc:
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    =  0 (off)
 HDIO_GETGEO failed: Inappropriate ioctl for device

 Model=PLEXTOR DVDR PX-716A, FwRev=1.04, SerialNo=496556
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no
 Drive conforms to: device does not report version:

 * signifies the current active mode

