Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTA2P4g>; Wed, 29 Jan 2003 10:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTA2P4g>; Wed, 29 Jan 2003 10:56:36 -0500
Received: from mail.ithnet.com ([217.64.64.8]:3091 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264886AbTA2P4f>;
	Wed, 29 Jan 2003 10:56:35 -0500
Date: Wed, 29 Jan 2003 17:05:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-Id: <20030129170554.08dc6393.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0301291046490.18828-100000@coffee.psychology.mcmaster.ca>
References: <20030129164552.182e0cb8.skraw@ithnet.com>
	<Pine.LNX.4.44.0301291046490.18828-100000@coffee.psychology.mcmaster.ca>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003 10:51:03 -0500 (EST)
Mark Hahn <hahn@physics.mcmaster.ca> wrote:

> > > > what exactly does
> > > > 
> > > > 	mtrr: no more MTRRs available
> > > > 	mtrr: no more MTRRs available
> > > > 
> > > > during boot mean? What can I do against this? This comes up while
> > > > booting a system with 6GB and P-III 1.4 GHz (Serverworks chipset).
> > > > Kernel is 2.4.20.
> > > 
> > > you need to look at /proc/mtrr.
> > 
> > Thanks for your hint, but what does this tell me?
> 
> that your bios is stupid, I think.  mtrr's handle areas that are 
> powers of two in size (and >= 1M, I think).  the problem here is that
> the bios is trying to represent 4G of write-back ram and a 16M of 
> uncachable IO area (AGP aperture, I'm guessing).  the correct way
> to do this is a single 4G mtrr with an overlapping 16M one.

Ah, I see. So getting the above two messages would simply mean that there is no
table space left to add yet another two entries kernel gets from bios?

> do you have >4G ram?  that would explain the latter two.

Yes, this box has 6GB.

> note that you can fairly freely add/delete mtrr's from userspace.
> as long as you do it infrequently, I don't see why there would be 
> any risk or performance problem.

So the conclusion is that it does not look nice currently, but does not do any
harm (performance loss) either. I can live with that.
Thanks for your comments.

> > # cat /proc/mtrr
> > reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> > reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> > reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> > reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
> > reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
> > reg05: base=0xf7000000 (3952MB), size=  16MB: uncachable, count=1
> > reg06: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
> > reg07: base=0x200000000 (8192MB), size=8192MB: write-back, count=1
-- 
Regards,
Stephan
