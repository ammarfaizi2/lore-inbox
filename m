Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbUKLPwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbUKLPwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUKLPwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:52:53 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:58279 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S262552AbUKLPvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:51:07 -0500
Date: Fri, 12 Nov 2004 16:51:06 +0100
Message-Id: <683533131@web.de>
MIME-Version: 1.0
From: "Enrico Bartky" <DOSProfi@web.de>
To: linux-kernel@vger.kernel.org
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the catalog there is described that the drive can use UDMA66 Mode

http://www.fujitsu.com/global/support/computing/storage/hdd/eol/dhdd/mpd3xxat-catalog.html

"Piszcz, Justin Michael" <justin.piszcz@mitretek.org> schrieb am 12.11.04 16:46:08:

Maybe someone can step in if I am wrong, but I believe the drive cannot
use that mode.

There could also be multi-mode/issues.

Try hdparm -c3 -d1 -u1 -X68 /dev/hde

If that does not work, I am not sure if the drive will support that
mode.

For reference, I have a 61.4GB (MAXTOR) on a promise card, and it uses
the following mode in use:

Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 57     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

And a 40GB:

Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns

My guess is either:

1) The drive does not support it.
2) There is a multi-mode issue with DMA/the disk.
   See the following kernel option:

Device Drivers  --->
ATA/ATAPI/MFM/RLL support  --->
<*>     Include IDE/ATA-2 DISK support
[*]       Use multi-mode by default    

The help states:

Use multi-mode by default 
If you get this error, try to say Y here:                               
hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }        
hda: set_multmode: error=0x04 { DriveStatusError }

  If in doubt, say N.

 


I normally say Y here.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Enrico Bartky
Sent: Friday, November 12, 2004 10:35 AM
To: linux-kernel@vger.kernel.org
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)

The dmesg after hdparm command is

--snip--

hde: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }ide: failed opcode was 100
hde: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hde: CHECK for good STATUS

--snap--

What does that mean?
________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

