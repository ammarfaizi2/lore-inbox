Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310545AbSCLKEi>; Tue, 12 Mar 2002 05:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCLKE3>; Tue, 12 Mar 2002 05:04:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29701 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310545AbSCLKEO>; Tue, 12 Mar 2002 05:04:14 -0500
Date: Tue, 12 Mar 2002 11:05:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre2aa2
Message-ID: <20020312110533.B25226@dualathlon.random>
In-Reply-To: <20020311082031.B10413@dualathlon.random> <E16kRp6-0000rR-00@the-village.bc.nu> <20020311230729.I10413@dualathlon.random> <20020312081114.GA704@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312081114.GA704@suse.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 09:11:14AM +0100, Jens Axboe wrote:
> On Mon, Mar 11 2002, Andrea Arcangeli wrote:
> > On Mon, Mar 11, 2002 at 03:34:52PM +0000, Alan Cox wrote:
> > > > Only in 2.4.19pre2aa2: 00_amd-viper-7441-guessed-1
> > > > 
> > > > 	Let amd74xx recognize the 7441 amd chipset, it works and I needed it
> > > > 	mainly to set ->highmem = 1 and to skip the bounce buffers on my
> > > > 	desktop.  (Tried also mode 5 and it failed, so I #undef __CAN_MODE_5
> > > > 	back)
> > > 
> > > The correct AMD 7441 fixes are in the IDE patch and have been for a few
> > > months. They were supplied by AMD and work a treat. I don't believe there is
> > > any reason they require the new IDE infrastructure. They are howeve 32bit
> > > still so the 64bit IDE will be nice
> > 
> > thanks for the info. I will merge the IDE patch then (with the
> > additional modification to enable high-IO, that is why I looked into
> > it). btw, while making that change, I was also wondering that it would
> > be simpler to enable the highio in the common ide-dma part, rather than
> > in the chipsets tunings, the highio is completly unrelated to the fact
> > we compile amd7xxx or viaxxx into the kernel or not. but I didn't made
> > that change because the amd7xxx driver was working fine for me and also
> > because of possibly broken chipsets with the 31th bit of the bus address
> > disconnected, just to stay on the very safe side and not to trigger
> > hardware (not software) bugs.
> 
> We can probably safely just drop the highio flag in the hwif now. I just
> added it way back then as a safeguard, it might be a better idea to just
> have potentially buggy chipsets set their dma mask appropriately and let
> ide-dma enable the right bounce address (if any).
> 
> I'll update the block-highmem for 2.4.19-pre3 now that the IDE merge is
> in.

I will send you my latest version, you probably want to hack on top of
it I think, I synched up the VM part and fixed some silly bug (like
pages_to_phys on alpha).

Andrea
