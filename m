Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTL2QHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTL2QHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:07:33 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:37760 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S263598AbTL2QHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:07:25 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
Date: Mon, 29 Dec 2003 11:07:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Is it safe to ignore UDMA BadCRC errors?
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The topic of CRC errrors from IDE drives has been discussed numerous
times on this list, and I've reviewed those discussions, but I'm still
not 100% certain of the answer to this question: Is it safe for me to
ignore occasional CRC errors from my drive?

Here are the details....

The errors look like this:

  hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

They don't seem to happen often enough to convince the kernel to back
down to a slower UDMA mode.

PCI IDE controller:

  PDC20262: IDE controller at PCI slot 00:0f.0
  PDC20262: chipset revision 1
  PDC20262: not 100% native mode: will probe irqs later
  PDC20262: ROM enabled at 0xfebe0000
  PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
      ide2: BM-DMA at 0xef00-0xef07, BIOS settings: hde:DMA, hdf:DMA
      ide3: BM-DMA at 0xef08-0xef0f, BIOS settings: hdg:DMA, hdh:DMA

Seagate 160GB hard drive getting the occasional errors:

  /dev/hde:
   multcount    = 16 (on)
   IO_support   =  0 (default 16-bit)
   unmaskirq    =  1 (on)
   using_dma    =  1 (on)
   keepsettings =  0 (off)
   readonly     =  0 (off)
   readahead    =  8 (on)
   geometry     = 19457/255/63, sectors = 312581808, start = 0

  /dev/hde:

   Model=ST3160021A, FwRev=3.04, SerialNo=3JS0X3MB
   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
   RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
   BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
   CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
   IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
   PIO modes:  pio0 pio1 pio2 pio3 pio4 
   DMA modes:  mdma0 mdma1 mdma2 
   UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 
   AdvancedPM=no WriteCache=enabled
   Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

   * signifies the current active mode

Flat, keyed, two-position ribbon cable which looks to be in good
condition.  There is no hdf on the same channel as hde (i.e., the
slave position on the cable is empty).

Replacing the cable with a shielded, round, single-position, keyed,
ATA100/133 cable didn't get rid of the errors (and in fact seemed to
make the drive behave worse, which may mean it wasn't a very good
shielded round cable; speaking of which, can anyone recommend a good,
reliable brand of IDE cables).

Reducing to UDMA3 by adding "-X udma3" to the hdparm invocation on
reboot didn't get rid of the errors.

Rerouting the various IDE cables to prevent them from running parallel
to each other didn't get rid of the errors.

Should I be continuing to pursue this, or should I just ignore it if
the performance of the drive is good and the errors only happen
occasionally?

Thanks for any advice you can provide.

  Jonathan Kamens
