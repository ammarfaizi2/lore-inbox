Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317041AbSEWWzl>; Thu, 23 May 2002 18:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317042AbSEWWzk>; Thu, 23 May 2002 18:55:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57506 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317041AbSEWWzi>;
	Thu, 23 May 2002 18:55:38 -0400
Date: Fri, 24 May 2002 00:55:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Oleg Drokin <green@namesys.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524005525.H27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020523234720.A7495@bouton.inet6-interne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 11:47:20PM +0200, Lionel Bouton wrote:
> On jeu, mai 23, 2002 at 04:44:26 +0200, Martin Dalecki wrote:
> > Uz.ytkownik Oleg Drokin napisa?:
> > > Hello!
> > > 
> > > On Thu, May 23, 2002 at 04:27:39PM +0200, Martin Dalecki wrote:
> > > 
> > >>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > >>>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > >>
> > >>Since this error can be expected to be quite common.
> > >>Its an installation error. I will just make the corresponding
> > >>error message more intelliglible to the average user:
> > >>hda: checksum error on data transfer occurred!
> > > 
> > > 
> > > BTW, I have a particular setup that spits out such errors,
> > > and I somehow thinks the cable is good.
> > > 
> > > I have IBM DTLA-307030
> 
> <offtopic>
> Be prepared to some serious fun. I'm just in the middle of applying
> desesperate technics like RAID5/RAID0 on partitions from the same drive.
> Until I find some money to replace the failing drives I'm in for serious
> data recovery tricks if I want my grabbed video.
> I've 6 drives here, from which 2 are IBM DTLAs and one is an IBM IC35. Guess
> which 3 ones slowly reported more and more "UncorrectableError"s (aka
> bad blocks) during last month ?
> </offtopic>

If you rewrite the whole drive with zeros (or the original data) sector
by sector, the uncorrectable errors will go away. I've done this to my
307030 and it works fine again. (Fortunately for me the errors were only
in my swap partition).

> Sorry, I feeled the need to hammer IBM drives in public. More insightful text
> should be find below. 
> 
> > > drive and Seagate Barracuda IV drive (last one purchased
> > > only recently).
> > > IBM drive is connected to far end of 80-wires IDE cable and Barracuda is
> > > connected to the middle of this same wire.
> > > Before I bought IBM drive, everything was ok.
> > > But now I see BadCRC errors on hdb (only on hdb, which is barracuda drive)
> > > usually when both drives are active.
> > > If I disable DMA on IBM drive (or if kernel disables it by itself for some
> > > reason, and it actually does it sometimes), these errors seems to go away.
> > > 
> > > This is all on 2.4.18, but actually I think this is irrelevant.
> > > 
> > > If that's a bad cable, why it is only happens when both drives are working
> > > in DMA mode?
> > 
> > It's most likely the cable. The error comes directly from the
> > status register of the drive. The drive is reporting that it got
> > corrupted data from the wire. This will be only checked in the
> > 80 cable requiring DMA transfer modes.
> 
> If I'm not mistaken it's not the 80-cable tye that allows this (correct me if
> I'm wrong but the 40 new cables are grounded and act more like a shield
> between data/signal transport lines than anything else).
> IIRC BadCRC is new to UDMA. You could have this error with UDMA mode 0 on a
> 40-pin cable.
> 
> Thanks to Andre Hedrick's code, the kernel automagically slows the dma modes
> until the BadCRC disappear.
> 
> > So if the drive resorts to
> > slower operation all will be fine. If it does not - well
> > you see the above...
> > 
> > Having two drives on a single cable canges the termination
> > of the cable as well as other electrical properties significantly
> > and apparently you are just out of luck with the above system.
>  
> I've seen this behaviour, adding a slave to an IDE bus can sometimes make it
> less reliable. My current opinion is that the signal/noise ratio on IDE
> busses has gone down too much with speed growing, you simply can't take
> whatever controller/drive/cable/power supply combination and say each one
> seems OK, the whole bus should operate at UDMA100/133 flawlessly. Nowadays
> you need to either stress test an IDE config or know the exact electronic
> behaviour of each component to validate that it will work without using
> Andre's code (and thus getting underspec perf).
> 
> > What should really help is simple resort to slower operations
> > int he case of the driver.
> > 
> 
> Already done, see above.
> 
> > It can of course be as well that the host chip driver is simply
> > programming the channel for too aggressive values.
> > 
> 
> Can be. Then it's a bug.
> 
> > Hmm thinking again about it... It occurrs to me
> > that actually there should be a mechanism which tells the
> > host chip drivers whatever there are only just one or
> > two drivers connected. I will have to look in to it.
> > 
> 
> The driver doesn't know, but the general IDE code does.
> 
> LB, going back to his damn drives...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
