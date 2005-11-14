Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVKNHtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVKNHtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVKNHtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:49:43 -0500
Received: from outbound.idiom.com ([216.240.47.196]:36496 "EHLO
	delight.idiom.com") by vger.kernel.org with ESMTP id S1750974AbVKNHtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:49:42 -0500
Message-ID: <43784187.4060607@obviously.com>
Date: Sun, 13 Nov 2005 23:49:27 -0800
From: Bryce Nesbitt <bryce1@obviously.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide: failed opcode errors, thousands of them, 2.6.13-15
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is using a SUSE Linux 10.0 build.  I installed a new DVD burner,
and now get 1 error per second in
the kernel ring buffer:

Nov 13 23:31:18 linux kernel: hdc: packet command error: status=0x51 {
DriveReady SeekComplete Error }
Nov 13 23:31:18 linux kernel: hdc: packet command error: error=0x54 {
AbortedCommand LastFailedSense=0x05 }
Nov 13 23:31:18 linux kernel: ide: failed opcode was: unknown
Nov 13 23:31:19 linux udevd[2297]: get_netlink_msg: no ACTION in payload
found, skip event 'mount'
Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: RRIP_1991A
Nov 13 23:31:19 linux kernel: hdc: packet command error: status=0x51 {
DriveReady SeekComplete Error }
Nov 13 23:31:19 linux kernel: hdc: packet command error: error=0x54 {
AbortedCommand LastFailedSense=0x05 }
Nov 13 23:31:19 linux kernel: ide: failed opcode was: unknown
Nov 13 23:31:20 linux kernel: hdc: packet command error: status=0x51 {
DriveReady SeekComplete Error }
Nov 13 23:31:20 linux kernel: hdc: packet command error: error=0x54 {
AbortedCommand LastFailedSense=0x05 }
Nov 13 23:31:20 linux kernel: ide: failed opcode was: unknown

This is similar to report:
http://lkml.org/lkml/2005/9/21/300  DMA broken in mainline 2.6.13.2
_AND_ opensuse vendor 2.6.13-15


Like the first reporter, I also have a LITEON SOHW-1693S DVD burner.
Curiously enough mine works fine (burns and reads DVD's just fine).
DMA on or DMA off makes no difference.
Note the HDIO_GETGEO error below.
Is there anything else I can probe to help track down this issue?


linux:/home/bryce # lspci
...
00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)

linux:/home/bryce # hdparm /dev/hdc
/dev/hdc:
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

linux:/home/bryce # hdparm -iI /dev/hdc

/dev/hdc:

 Model=LITE-ON DVDRW SOHW-1693S, FwRev=KS0B, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2
 AdvancedPM=no
 Drive conforms to: device does not report version:

 * signifies the current active mode


ATAPI CD-ROM, with removable media
        Model Number:       LITE-ON DVDRW SOHW-1693S
        Serial Number:
        Firmware Revision:  KS0B
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns

linux:/home/bryce # uname -a
Linux linux 2.6.13-15-default #1 Tue Sep 13 14:56:15 UTC 2005 i686
athlon i386 GNU/Linux

