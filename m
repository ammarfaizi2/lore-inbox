Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUHTDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUHTDQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 23:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHTDQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 23:16:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:35537 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266366AbUHTDQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 23:16:03 -0400
X-Authenticated: #19232476
Subject: Re: DriveReady SeekComplete Error...
From: Dhruv Matani <dhruvbird@gmx.net>
To: Dwayne Rightler <drightler@technicalogic.com>
Cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <011601c469de$9456f700$010a300a@drightler2k>
References: <2E314DE03538984BA5634F12115B3A4E62E88D@email1.mitretek.org>
	 <011601c469de$9456f700$010a300a@drightler2k>
Content-Type: text/plain
Organization: 
Message-Id: <1092969099.7552.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Aug 2004 08:52:24 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!
	Great news!
First of all I would like to say that there was something seriously
wrong with the kernel 2.4.20-8.

1. DMA was screwed up for Samsung disks at least.
2. When I disabled, DMA, I regularly go hda: lost interrupt errors.
3. My ATX power supply did not switch off the computer automatically.

However, on using the vanilla 2.4.20 kernel, all the above errors have
vanished, and also XMMS does not skip any more! I am using DMA by
enabling use DMA by default while building the kernel without any
errors!

I suspect that the timing considerations for these hdds was wrong
somewhere, and in the older kernel version, it was right. Please see if
this helps.

Regards,
-Dhruv.




On Thu, 2004-07-15 at 01:40, Dwayne Rightler wrote:
> demigod:/proc/ide/hda# cat model
> SAMSUNG SV2044D
> 
> 
> lspci -vvv output is attached.  /dev/hda is attached to the VIA chipset.  I
> have another hard drive /dev/hdb and a cdrom drive /dev/hdc connected to
> that chipset as well and they can do DMA transfers.
> 
> The Promise controller has 2 hard drives hooked to it which can also do DMA
> transfers.
> 
> Thanks,
> Dwayne
> ----- Original Message ----- 
> From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
> To: "Dwayne Rightler" <drightler@technicalogic.com>;
> <linux-kernel@vger.kernel.org>
> Cc: "Dhruv Matani" <dhruvbird@gmx.net>
> Sent: Tuesday, July 13, 2004 12:23 PM
> Subject: RE: DriveReady SeekComplete Error...
> 
> 
> > Hrmm, does anyone else have that same drive or chipset you use, do they
> > also experience the problem?
> >
> > What is the exact model of the drive and what chipset do you use?
> >
> > cd /proc/ide/hda ; cat model
> >
> > lspci -vvv # as root
> >
> > -----Original Message-----
> > From: Dwayne Rightler [mailto:drightler@technicalogic.com]
> > Sent: Tuesday, July 13, 2004 11:58 AM
> > To: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
> > Cc: Dhruv Matani
> > Subject: Re: DriveReady SeekComplete Error...
> >
> > The CONFIG_IDEDISK_MULTI_MODE setting makes no difference as seen below:
> >
> > demigod:~# uname -a
> > Linux demigod 2.6.7-kexec #2 Tue Jul 13 08:31:56 CDT 2004 i686 GNU/Linux
> >
> > demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> > CONFIG_IDEDISK_MULTI_MODE=y
> >
> > demigod:~# dmesg | grep ^hda
> > hda: SAMSUNG SV2044D, ATA DISK drive
> > hda: max request size: 128KiB
> > hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: DMA disabled
> >
> > ##########################################
> >
> > demigod:~# uname -a
> > Linux demigod 2.6.7-kexec #1 Mon Jul 5 11:30:36 CDT 2004 i686 GNU/Linux
> >
> > demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> > # CONFIG_IDEDISK_MULTI_MODE is not set
> >
> > demigod:~# dmesg | grep ^hda
> > hda: SAMSUNG SV2044D, ATA DISK drive
> > hda: max request size: 128KiB
> > hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x41
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > ----- Original Message ----- 
> > From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
> > To: "Dwayne Rightler" <drightler@technicalogic.com>;
> > <linux-kernel@vger.kernel.org>
> > Cc: "Dhruv Matani" <dhruvbird@gmx.net>
> > Sent: Tuesday, July 13, 2004 7:44 AM
> > Subject: RE: DriveReady SeekComplete Error...
> >
> >
> > > <*>     Include IDE/ATA-2 DISK support
> > > [*]       Use multi-mode by default
> > >
> > > Have you tried recompiling the kernel and checking off the second
> > option
> > > show above?
> > >
> > > CONFIG_IDEDISK_MULTI_MODE
> > > If you get this error, try to say Y here:
> > > hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> > > hda: set_multmode: error=0x04 { DriveStatusError }
> > > If in doubt, say N.
> > >
> > >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dwayne
> > Rightler
> > > Sent: Tuesday, July 13, 2004 8:33 AM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Dhruv Matani
> > > Subject: Re: DriveReady SeekComplete Error...
> > >
> > > I have a similar problem with a Samsung hard drive. Model SV2044D.
> > The
> > > output of 'hdparm -i' below indicates it supports several multiword
> > and
> > > ultra DMA modes but if i run the drive in anything other than PIO mode
> > > it
> > > gets DMA timeouts and SeekComplete Errors.  This has been on every
> > > kernel I
> > > can recall in the 2.4 and 2.6 series.
> > >
> > > demigod:~# hdparm -i /dev/hda
> > >
> > > /dev/hda:
> > >
> > >  Model=SAMSUNG SV2044D, FwRev=MM200-53, SerialNo=0228J1FN905733
> > >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> > >  RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
> > >  BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
> > >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
> > >  IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > >  DMA modes:  mdma0 mdma1 mdma2
> > >  UDMA modes: udma0 udma1 udma2 udma3 *udma4
> > >  AdvancedPM=no WriteCache=enabled
> > >  Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4
> > >
> > >  * signifies the current active mode
> > >
> > >
> > >
> > > ----- Original Message ----- 
> > > From: "Dhruv Matani" <dhruvbird@gmx.net>
> > > To: <linux-kernel@vger.kernel.org>
> > > Sent: Tuesday, July 13, 2004 7:30 AM
> > > Subject: DriveReady SeekComplete Error...
> > >
> > >
> > > > Hi,
> > > > I've been getting this error for my brand new (2 months old) Samsung
> > > > HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using
> > > the
> > > > kernel version 2.4.20-8 provided by RedHat. When I used
> > RH-7.2(before
> > > > upgrading to RH-9), the same HDD worked fine. Also, when I
> > > re-installed
> > > > RH-7.2, it worked fine?
> > > >
> > > > Any suggestions?
> > > >
> > > > Please cc me the reply, sine I'm not subscribed.
> > > > Thanks ;-)
> > > >
> > > > -- 
> > > >         -Dhruv Matani.
> > > > http://www.geocities.com/dhruvbird/
> > > >
> > > > As a rule, man is a fool. When it's hot, he wants it cold.
> > > > When it's cold he wants it hot. He always wants what is not.
> > > > -Anon.

-- 
        -Dhruv Matani.
http://www.geocities.com/dhruvbird/

The price of freedom is responsibility, but it's a bargain, because
freedom is priceless. ~ Hugh Downs

