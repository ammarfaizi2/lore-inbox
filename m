Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRAVWuN>; Mon, 22 Jan 2001 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135536AbRAVWuD>; Mon, 22 Jan 2001 17:50:03 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:31251 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135509AbRAVWtp>; Mon, 22 Jan 2001 17:49:45 -0500
Date: Mon, 22 Jan 2001 22:49:38 +0000
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via apollo KX133 ide bug in 2.4.x
Message-ID: <20010122224938.A713@colonel-panic.com>
Mail-Followup-To: pdh, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A68DCD1.FACB4135@voicenet.com> <20000120083812.A945@colonel-panic.com> <20010120205608.C2838@colonel-panic.com> <3A6A03F4.DB6C0362@voicenet.com> <20010121124030.A804@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010121124030.A804@suse.cz>; from vojtech@suse.cz on Sun, Jan 21, 2001 at 12:40:30PM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 12:40:30PM +0100, Vojtech Pavlik wrote:
> On Sat, Jan 20, 2001 at 04:32:36PM -0500, safemode wrote:
> > Peter Horton wrote:
> > 
> > > On Thu, Jan 20, 2000 at 08:38:12AM +0000, Peter Horton wrote:
> > > >
> > > > I think I'm suffering the same thing on my new Asus A7V. Yesterday I got a
> > > > single "error in bitmap, remounting read only" type error, and today I got
> > > > some files in /tmp that returned I/O error when stat()ed. I do have DMA
> > > > enabled, but only UDMA33. I've done several kernel compiles with no
> > > > problems at all so looks like something is on the edge. Think I might go
> > > > back to 2.2.x for a bit and see what happens, or maybe just remove the VIA
> > > > driver :-((.
> > > >
> > >
> > > I apologise for following up my own E-mail, but there is something I'm
> > > missing here (maybe a whole lot of something). Anyone know how come we're
> > > seeing silent corruption ... I thought this UDMA stuff was all checksummed
> > > ? If there error is outside the data I assume the driver would notice ?
> > >
> > > P.
> > 
> > The thing is, even with UDMA disabled in the kernel, I still see the corruption
> > with 2.4.x (release) and above.  Anything written while using the kernel is
> > corrupted.   Much of the stuff will read fine (files) ... but I believe
> > directories get the IO error immediately and some files do also.  Everything is
> > seen as corrupted when you fsck a partition where this kernel has been run and
> > created files on.   This is a silent corruption without any errors reported and
> > I've only tested it on ext2.  You cannot create FS's with these kernels (at
> > least on the VIA chipsets) since they too are corrupted (note, only tested ext2
> > fs).   I did disable UDMA everywhere and still saw it happen, this problem is
> > not present in older 2.4.0-test kernels so it's something in the late
> > pre-release stage and into the release stage.
> 
> Do you have the via driver compiled in? If yes, try without, if no, try
> with it ...
> 

Okay, I bit the bullet and rebuilt the kernel with the VIA driver back in.
As a test I created one 128M file from /dev/urandom and copied it 26
times. Out of the 26 copies one was damaged. The damage was just one page
(eight sectors), aligned on a page boundary. The damaged section bore no
resemblance at all to what it should have been. Is it just a coincidence
that it looks like an incorrect page got written out ?

P.

PS - just to rule out other factors I ran memtest86 on this box for 10
hours with no error. It's not an overclock either.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
