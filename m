Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSBMK4x>; Wed, 13 Feb 2002 05:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291555AbSBMK4o>; Wed, 13 Feb 2002 05:56:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16138
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291545AbSBMK4i>; Wed, 13 Feb 2002 05:56:38 -0500
Date: Wed, 13 Feb 2002 02:46:12 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020213113928.A31254@suse.cz>
Message-ID: <Pine.LNX.4.10.10202130240540.1479-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Vojtech Pavlik wrote:

> On Tue, Feb 12, 2002 at 11:27:42PM -0800, Andre Hedrick wrote:
> > On Wed, 13 Feb 2002, Vojtech Pavlik wrote:
> > 
> > > On Tue, Feb 12, 2002 at 09:52:07PM -0800, Andre Hedrick wrote:
> > > 
> > > > HELL NO!
> > > 
> > > Hell why?
> > 
> > Does Virtual DMA mean anything?
> 
> Sure. Virtual-Direct-Marketing-Association, then there is the VDS,
> Vitrual-DMA-Services, which is a DOS DMA access specification, then
> there is the VDMA on PCI - this is a term used for normal PCI BM DMA
> passing through an IOMMU-capable bridge. Then there is Virtual-DMA on
> floppy controllers and NE*000's - which allows feeding the data to the
> card via PIO when there is no ISA DMA controller available in the
> system.
> 
> None of this is relevant to IDE on Linux.

Well not yet but here is a hint, all future hardware will be MMIO.
Meaning all IO is performed under DMA over the ATA-Bridge.
Specifically PIO operations are transacted over VDMA to the Bridge and
executed as PIO by the Bridge.

> Perhaps you mean PIO using SG-lists to put the data into the right
> places. But I still don't see a problem with this and the proposed patch.
> 
> > Does a function struct for handling IO and MMIO help?
> 
> Ugh? What is "function struct"?

Since the future will be a mess, and it is possible to have IO/MMIO on the
same HOST it will be come more fun than you can imagine.

> > All you two are doing is causing more work for me to build a working
> > model.
> 
> It's possible - but then that is because we have different development
> strategies. Ours is to start with minimum code and if something needs to
> be made different, then duplicate and edit that. But only when needed.
> Yours seems to be to duplicate everything first, make the changes and
> then look at what can be merged.

Mine is knowing the future of hardware and preparing for it to come.
Why else would I packetize the ATA-Command Block?

> In theory they both give the same results.
> 
> I don't think that happen's in reality. Duplicating first never gets
> merged together later, as many tiny differences emerge. Believe me, I
> know this - this already happened many times in the kernel and is a huge
> amount of work to undo - keep shared code shared.
> 
> > But it is clear you must poke and screw things up, so I will continue to
> > undo it in my trees until I have it working.
> 
> If you think so, sure, you're free to do that.

Well give you can not have access to hardware which doesn't exist ...

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

