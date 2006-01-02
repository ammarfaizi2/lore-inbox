Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWABS0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWABS0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWABS0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:26:45 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:46000 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750921AbWABS0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:26:44 -0500
Subject: Re: Need help with mtrr & agpgart
From: Ochal Christophe <ochal@kefren.be>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060102011431.GC5213@kurtwerks.com>
References: <1136163121.8522.10.camel@localhost.localdomain>
	 <20060102011431.GC5213@kurtwerks.com>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 19:26:37 +0100
Message-Id: <1136226398.7602.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 20:14 -0500, Kurt Wall wrote:
> On Mon, Jan 02, 2006 at 01:52:01AM +0100, Ochal Christophe took 0 lines to write:
> > I've been doing a little digging in my system since i was unable to get
> > DRI running on my current motherboard (see my prior posts regarding a
> > possible bug in agpgart), and i noticed that i don't get any lines
> > in /proc/mtrr expect for my main memory.
> > 
> > The entry seems correct, the size specified is also correct, however, i
> > don't get any write-combining lines.
> > 
> > This is what i get:
> > 
> > eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1
> > 
> > This is what i should get:
> > eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1
> > reg01: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1
> > reg02: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1
> 
> I don't get much better on my AMD64 system:
> 
> $ cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
> reg01: base=0x1ff00000 ( 511MB), size=   1MB: uncachable, count=1

I did some more tests, i replaced my Radeon card with an older R128 one,
and enabling DRI makes it crawl, it's worse then windows95 on a 386 :(

It seems there's an incompability with my hardware somewhere, but i
can't put my finger to the exact cause of the system, the only known
recurrence is that agpgart incorrectly specifies the agp aperture size
regardless of AGP card i use, and regardless of my BIOS settings.

With this R128 i *can* enable DRI, but it only sees 8MB of video ram,
the mtrr entry has a write-combining line of 32MB (the incorrect size of
my AGP aperture) and any disk access seems to halt the X server.

I've never had any problem like this before with linux, and i'm stumped
as to how to solve it, hopefully, someone here can provide me with some
more hints & tricks

