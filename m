Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319055AbSHSUTk>; Mon, 19 Aug 2002 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSHSUTk>; Mon, 19 Aug 2002 16:19:40 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:13 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S319055AbSHSUTj>; Mon, 19 Aug 2002 16:19:39 -0400
Date: Mon, 19 Aug 2002 22:23:36 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Marco Colombo <marco@esi.it>, Andreas Dilger <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
In-Reply-To: <20020819163330.GF14427@waste.org>
Message-ID: <Pine.LNX.4.44.0208192213150.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Xymoron wrote:

> On Mon, Aug 19, 2002 at 06:20:14PM +0200, Marco Colombo wrote:
> > 
> > We're never "discarding" entropy. We're just feeling more and more
> > confortable in saying we've stored 'poolsize' random bits.
> 
> Yes we are. The pool can only hold n bits. If it's full and we mix in
> m more bits, we're losing m bits in the process.

B-) we're speaking of different "bits" here. A pool of, say, 4096 bits
only holds 4096 bits of data. But necessarily less than 4096 bits of
randomness, unless we have the 'perfect' random source... of course
if we inject 40960 random bits (from a "good" source) we get closer to
4096 "really" randoms bits.  At some point it makes no sense to inject
more, I agree.

> > But what you say is definitely true... on my desktop system I only need
> > to move the mouse a couple of times to fill the pool completely in a
> > matter of seconds.
> 
> Heh. That's actually a bug. Your mouse movement is only giving the
> system a few hundred bits of entropy (by the current code's
> measurements), but /dev/random will give out thousands. 
> 
> Note that above a certain velocity, mouse samples are back to back
> characters on the serial port (or packets in the keyboard controller),
> so most of the timing entropy is in the early acceleration or during
> direction changes.
>
> > I see little convenience in having /dev/urandom semantic in the kernel
> > (besides the fact it's already there, of course).
> 
> The kernel uses it internally for numerous things like sequence
> numbers, syncookies, and UUIDs. So it doesn't take much to justify
> exporting it..

It should really have its own pool, so userspace can't DoS the parts
that really need randomness.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

