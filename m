Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317040AbSEWWxM>; Thu, 23 May 2002 18:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317041AbSEWWxL>; Thu, 23 May 2002 18:53:11 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54434 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317040AbSEWWxJ>;
	Thu, 23 May 2002 18:53:09 -0400
Date: Fri, 24 May 2002 00:52:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Oleg Drokin <green@namesys.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524005249.G27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020523200005.B5760@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 08:00:05PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Thu, May 23, 2002 at 04:44:26PM +0200, Martin Dalecki wrote:
> 
> > It's most likely the cable. The error comes directly from the
> > status register of the drive. The drive is reporting that it got
> > corrupted data from the wire. This will be only checked in the
> > 80 cable requiring DMA transfer modes. So if the drive resorts to
> > slower operation all will be fine. If it does not - well
> > you see the above...
> 
> Note, that errors are only appearing on hdb (barracuda drive),
> but errors go away once I disable DMA on hda (IBM drive).
> So the DMA is apparently is still on.
> Hm, or is there some trick that if only one drive on the channel
> operates in DMA mode and second on in PIO mode, then everything resorts to PIO
> of some sort? But hdparm seems not to confirm that.

It's probably because in DMA mode the IBM drive has different electrical
properties on the cable.

> 
> > It can of course be as well that the host chip driver is simply
> > programming the channel for too aggressive values.
> 
> BTW, that's
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6

Doesn't tell much ...

> Usually I see something like this:
> hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> ... (some such messages) ... followed by:
> hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: DMA disabled
> ide0: reset: success
> 
> Since this point, no more error messages.
> I checked and hdb is actually in DMA mode at this point.
> 
> Hm, I also noticed that hdb have this setting:
>  I/O support  =  3 (32-bit w/sync)

> Never saw this before. 

I think the driver sets this when it sees the problems ...

-- 
Vojtech Pavlik
SuSE Labs
