Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291563AbSBML02>; Wed, 13 Feb 2002 06:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBML0T>; Wed, 13 Feb 2002 06:26:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:40459 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291563AbSBML0J>; Wed, 13 Feb 2002 06:26:09 -0500
Date: Wed, 13 Feb 2002 12:26:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213122607.A31348@suse.cz>
In-Reply-To: <20020213113928.A31254@suse.cz> <Pine.LNX.4.10.10202130240540.1479-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202130240540.1479-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Wed, Feb 13, 2002 at 02:46:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 02:46:12AM -0800, Andre Hedrick wrote:
> On Wed, 13 Feb 2002, Vojtech Pavlik wrote:
> 
> > On Tue, Feb 12, 2002 at 11:27:42PM -0800, Andre Hedrick wrote:
> > > On Wed, 13 Feb 2002, Vojtech Pavlik wrote:
> > > 
> > > > On Tue, Feb 12, 2002 at 09:52:07PM -0800, Andre Hedrick wrote:
> > > > 
> > > > > HELL NO!
> > > > 
> > > > Hell why?
> > > 
> > > Does Virtual DMA mean anything?
> > 
> > Sure. Virtual-Direct-Marketing-Association, then there is the VDS,
> > Vitrual-DMA-Services, which is a DOS DMA access specification, then
> > there is the VDMA on PCI - this is a term used for normal PCI BM DMA
> > passing through an IOMMU-capable bridge. Then there is Virtual-DMA on
> > floppy controllers and NE*000's - which allows feeding the data to the
> > card via PIO when there is no ISA DMA controller available in the
> > system.
> > 
> > None of this is relevant to IDE on Linux.
> 
> Well not yet but here is a hint, all future hardware will be MMIO.

That's nice. Actually, that's the case on many archs already.

> Meaning all IO is performed under DMA over the ATA-Bridge.

Ugh? This is not the meaning of your first sentence. 

> Specifically PIO operations are transacted over VDMA to the Bridge and
> executed as PIO by the Bridge.

Care to explain in more detail? Hmm, I suppose not.

I suppose you mean that the IDE controller will use BM DMA w/ SG for
every transaction and the PIO/DMA/UDMA mode will only be different on
the IDE BUS. That's very nice, and actually will make things simpler.

I still don't see how any of the proposed patches kill the possibility
to do this.

> > Perhaps you mean PIO using SG-lists to put the data into the right
> > places. But I still don't see a problem with this and the proposed patch.
> > 
> > > Does a function struct for handling IO and MMIO help?
> > 
> > Ugh? What is "function struct"?
> 
> Since the future will be a mess, and it is possible to have IO/MMIO on the
> same HOST it will be come more fun than you can imagine.

The future (kernel point of view) will be how we make it to be. If we
make a lot of messy code, the future will be a mess. This seems to be
what you're doing. (Sorry.)

> > > All you two are doing is causing more work for me to build a working
> > > model.
> > 
> > It's possible - but then that is because we have different development
> > strategies. Ours is to start with minimum code and if something needs to
> > be made different, then duplicate and edit that. But only when needed.
> > Yours seems to be to duplicate everything first, make the changes and
> > then look at what can be merged.
> 
> Mine is knowing the future of hardware and preparing for it to come.
> Why else would I packetize the ATA-Command Block?
> 
> > In theory they both give the same results.
> > 
> > I don't think that happen's in reality. Duplicating first never gets
> > merged together later, as many tiny differences emerge. Believe me, I
> > know this - this already happened many times in the kernel and is a huge
> > amount of work to undo - keep shared code shared.
> > 
> > > But it is clear you must poke and screw things up, so I will continue to
> > > undo it in my trees until I have it working.
> > 
> > If you think so, sure, you're free to do that.
> 
> Well give you can not have access to hardware which doesn't exist ...
> 
> Cheers,
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development

-- 
Vojtech Pavlik
SuSE Labs
