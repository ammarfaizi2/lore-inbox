Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSEWQAL>; Thu, 23 May 2002 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSEWQAK>; Thu, 23 May 2002 12:00:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:22400 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S316843AbSEWQAK>; Thu, 23 May 2002 12:00:10 -0400
Date: Thu, 23 May 2002 20:00:05 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020523200005.B5760@namesys.com>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, May 23, 2002 at 04:44:26PM +0200, Martin Dalecki wrote:

> It's most likely the cable. The error comes directly from the
> status register of the drive. The drive is reporting that it got
> corrupted data from the wire. This will be only checked in the
> 80 cable requiring DMA transfer modes. So if the drive resorts to
> slower operation all will be fine. If it does not - well
> you see the above...

Note, that errors are only appearing on hdb (barracuda drive),
but errors go away once I disable DMA on hda (IBM drive).
So the DMA is apparently is still on.
Hm, or is there some trick that if only one drive on the channel
operates in DMA mode and second on in PIO mode, then everything resorts to PIO
of some sort? But hdparm seems not to confirm that.

> It can of course be as well that the host chip driver is simply
> programming the channel for too aggressive values.

BTW, that's
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6

Usually I see something like this:
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
... (some such messages) ... followed by:
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: DMA disabled
ide0: reset: success

Since this point, no more error messages.
I checked and hdb is actually in DMA mode at this point.

Hm, I also noticed that hdb have this setting:
 I/O support  =  3 (32-bit w/sync)

Never saw this before. 

Bye,
    Oleg
