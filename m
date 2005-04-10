Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVDJXnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDJXnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDJXnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:43:47 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:36924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261619AbVDJXnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:43:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WFsaj22JCNFIar07cACqTMNB+mYaUMBs0t/IYbU9trVrPqeR1TSV27S88kxN4Gb2dtF9JcSUUL0IWK3RMLP8H5XdAL4AoFDyADSK4CX/q1uo1N91bfjfE1REDNnKq4E5z/Gs9QFSyTHe0N2DIuibGRdwewiVya2acvyJiKwcbf4=
Message-ID: <2a0fbc590504101643297d6f0f@mail.gmail.com>
Date: Mon, 11 Apr 2005 01:43:32 +0200
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <58cb370e0504060902442082ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <2a0fbc5905040506422fbf6356@mail.gmail.com>
	 <Pine.LNX.4.61.0504050957400.15886@chaos.analogic.com>
	 <2a0fbc59050405155815666e8d@mail.gmail.com>
	 <Pine.LNX.4.61.0504060737130.21548@chaos.analogic.com>
	 <58cb370e0504060902442082ee@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 6:02 PM, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> There still can be a bug in setting up DMA timings etc.
> 
> It is hard to even guess as you haven't given any details about your
> system: dmesg/hdparm/lspci/config... (or I overlooked it somehow).

I sent the related dmesg lines, and my .config.
for dmesg and .config :
http://marc.theaimsgroup.com/?l=linux-kernel&m=111179215521092&w=2

what part of lspci would you need ?

hdparm :

flash@evenflow:~$ sudo hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y47J8CRE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode

(it shows no mode... it's strange, because this drive should be nearly
the same as the following)

flash@evenflow:~$ sudo hdparm -i /dev/hdc

/dev/hdc:

 Model=Maxtor 6Y120L0, FwRev=YAR41BW0, SerialNo=Y31LWCXE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode

flash@evenflow:~$ sudo hdparm -d /dev/hdc

/dev/hdc:
 using_dma    =  0 (off)

(Note : hdparm -i says 'udma6', and hdparm -d says 'no dma'...
Strange, isn't it ?)

> > > In my case, the driver stopped for hdb, that is my dvd-burner/player.
> > > It did nothing for hda or hdc, I had to disable DMA myself.
> > >
> > > Will I have to install Windows XP to prove ultra DMA works correctly
> > > on this setup ? I really don't hope...
> 
> That would be very helpful.

I'll try that...

> Another useful thing would be to try non-nVidia motherboard
> (if you have one handy) without changing anything else.

I succesfully used these drives with another motherboard (PIIX4)
before, in udma2 mode, for years...

But first thing : I have to check if the cables are correctly plugged
in (I mean in the correct order)... I didn't have the time to do that
yet.

Thanks for your answer.
-- 
Julien
