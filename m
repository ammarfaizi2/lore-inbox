Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUGJSM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUGJSM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUGJSM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:12:58 -0400
Received: from mail.aei.ca ([206.123.6.14]:44480 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266319AbUGJSMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:12:54 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7 ide errors
Date: Sat, 10 Jul 2004 14:12:44 -0400
User-Agent: KMail/1.6.2
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <200407100848.15665.edt@aei.ca> <20040710162026.GA12371@bounceswoosh.org>
In-Reply-To: <20040710162026.GA12371@bounceswoosh.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407101412.44266.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 12:20, Eric D. Mudama wrote:
> On Sat, Jul 10 at  8:48, Ed Tomlinson wrote:
> >Hi,
> >
> >The ide error introduced with the barrier patches are still happening here with mm7. 
> >
> >Jul 10 08:06:04 bert usb.agent[1705]:      usbhid: loaded successfully
> >Jul 10 08:06:04 bert input.agent[1738]:      joydev: loaded successfully
> >Jul 10 08:06:06 bert kernel: lp: driver loaded but no devices found
> >Jul 10 08:06:16 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> >Jul 10 08:06:16 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> >Jul 10 08:06:16 bert kernel: ide: failed opcode was: 0xe7
> >Jul 10 08:06:18 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> >Jul 10 08:06:18 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> >Jul 10 08:06:18 bert kernel: ide: failed opcode was: 0xe7
> >
> >Typically  I get one of the above every couple of minutes and have since the barrier changes
> >when into mm.
> >
> >What can I do to help get to the bottom of this problem?
> 
> 0xE7 is the 'FLUSH CACHE' command for use on drives <= 137GB.
> 
> What model of drive do you have, and how big is it?

Here is the drive info posted again.  Note that a second drive on hdb does not
exhibit the problem.  If I had to guess I would say that the logic to only try 0xe7
once and remember not to use it again if there was a problem is buggy.

Ed

root@bert:/home/knoppix# hdparm -iI /dev/hda

/dev/hda:

 Model=WDC AC26400R, FwRev=15.01J15, SerialNo=WD-WM6271600165
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=13328/15/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=13328/15/63, CurSects=12594960, LBA=yes, LBAsects=12594960
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4

 * signifies the current active mode


ATA device, with non-removable media
        Model Number:       WDC AC26400R
        Serial Number:      WD-WM6271600165
        Firmware Revision:  15.01J15
Standards:
        Supported: 4 3 2 1
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       13328   13328
        heads           15      15
        sectors/track   63      63
        --
        bytes/track: 57600      bytes/sector: 600
        CHS current addressable sectors:   12594960
        LBA    user addressable sectors:   12594960
        device size with M = 1024*1024:        6149 MBytes
        device size with M = 1000*1000:        6448 MBytes (6 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 512.0kB    bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=160ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set


