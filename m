Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbUKLPmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbUKLPmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUKLPmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:42:38 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:9892 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262557AbUKLPmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:42:07 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-13.tower-45.messagelabs.com!1100274119!7367457!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)
Date: Fri, 12 Nov 2004 10:41:58 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4077@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROMISE Ultra133 TX2 (PDC20269)
Thread-Index: AcTIzXMeRGk+54IFSRaNpBQF5DVkiwAAAcgg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Enrico Bartky" <DOSProfi@web.de>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
