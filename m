Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUGMRX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUGMRX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUGMRXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 13:23:55 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:21387 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S265548AbUGMRXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 13:23:41 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-18.tower-45.messagelabs.com!1089739418!4149897
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: DriveReady SeekComplete Error...
Date: Tue, 13 Jul 2004 13:23:12 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E62E88D@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DriveReady SeekComplete Error...
Thread-Index: AcRo8byUCXlfA7gjSd69R1BXfZEn5QADEYvA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Dwayne Rightler" <drightler@technicalogic.com>,
       <linux-kernel@vger.kernel.org>
Cc: "Dhruv Matani" <dhruvbird@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrmm, does anyone else have that same drive or chipset you use, do they
also experience the problem?

What is the exact model of the drive and what chipset do you use?

cd /proc/ide/hda ; cat model

lspci -vvv # as root

-----Original Message-----
From: Dwayne Rightler [mailto:drightler@technicalogic.com] 
Sent: Tuesday, July 13, 2004 11:58 AM
To: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
Cc: Dhruv Matani
Subject: Re: DriveReady SeekComplete Error...

The CONFIG_IDEDISK_MULTI_MODE setting makes no difference as seen below:

demigod:~# uname -a
Linux demigod 2.6.7-kexec #2 Tue Jul 13 08:31:56 CDT 2004 i686 GNU/Linux

demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
CONFIG_IDEDISK_MULTI_MODE=y

demigod:~# dmesg | grep ^hda
hda: SAMSUNG SV2044D, ATA DISK drive
hda: max request size: 128KiB
hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
hda: DMA disabled
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: DMA disabled

##########################################

demigod:~# uname -a
Linux demigod 2.6.7-kexec #1 Mon Jul 5 11:30:36 CDT 2004 i686 GNU/Linux

demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
# CONFIG_IDEDISK_MULTI_MODE is not set

demigod:~# dmesg | grep ^hda
hda: SAMSUNG SV2044D, ATA DISK drive
hda: max request size: 128KiB
hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
hda: DMA disabled
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: DMA disabled
hda: dma_timer_expiry: dma status == 0x41
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
----- Original Message ----- 
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Dwayne Rightler" <drightler@technicalogic.com>;
<linux-kernel@vger.kernel.org>
Cc: "Dhruv Matani" <dhruvbird@gmx.net>
Sent: Tuesday, July 13, 2004 7:44 AM
Subject: RE: DriveReady SeekComplete Error...


> <*>     Include IDE/ATA-2 DISK support
> [*]       Use multi-mode by default
>
> Have you tried recompiling the kernel and checking off the second
option
> show above?
>
> CONFIG_IDEDISK_MULTI_MODE
> If you get this error, try to say Y here:
> hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> hda: set_multmode: error=0x04 { DriveStatusError }
> If in doubt, say N.
>
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dwayne
Rightler
> Sent: Tuesday, July 13, 2004 8:33 AM
> To: linux-kernel@vger.kernel.org
> Cc: Dhruv Matani
> Subject: Re: DriveReady SeekComplete Error...
>
> I have a similar problem with a Samsung hard drive. Model SV2044D.
The
> output of 'hdparm -i' below indicates it supports several multiword
and
> ultra DMA modes but if i run the drive in anything other than PIO mode
> it
> gets DMA timeouts and SeekComplete Errors.  This has been on every
> kernel I
> can recall in the 2.4 and 2.6 series.
>
> demigod:~# hdparm -i /dev/hda
>
> /dev/hda:
>
>  Model=SAMSUNG SV2044D, FwRev=MM200-53, SerialNo=0228J1FN905733
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
>  IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 *udma4
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4
>
>  * signifies the current active mode
>
>
>
> ----- Original Message ----- 
> From: "Dhruv Matani" <dhruvbird@gmx.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, July 13, 2004 7:30 AM
> Subject: DriveReady SeekComplete Error...
>
>
> > Hi,
> > I've been getting this error for my brand new (2 months old) Samsung
> > HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using
> the
> > kernel version 2.4.20-8 provided by RedHat. When I used
RH-7.2(before
> > upgrading to RH-9), the same HDD worked fine. Also, when I
> re-installed
> > RH-7.2, it worked fine?
> >
> > Any suggestions?
> >
> > Please cc me the reply, sine I'm not subscribed.
> > Thanks ;-)
> >
> > -- 
> >         -Dhruv Matani.
> > http://www.geocities.com/dhruvbird/
> >
> > As a rule, man is a fool. When it's hot, he wants it cold.
> > When it's cold he wants it hot. He always wants what is not.
> > -Anon.
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

