Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSHSQ3i>; Mon, 19 Aug 2002 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSHSQ3i>; Mon, 19 Aug 2002 12:29:38 -0400
Received: from waste.org ([209.173.204.2]:49807 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318930AbSHSQ3h>;
	Mon, 19 Aug 2002 12:29:37 -0400
Date: Mon, 19 Aug 2002 11:33:30 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Marco Colombo <marco@esi.it>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020819163330.GF14427@waste.org>
References: <20020819152936.GD14427@waste.org> <Pine.LNX.4.44.0208191744230.26653-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208191744230.26653-100000@Megathlon.ESI>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 06:20:14PM +0200, Marco Colombo wrote:
> 
> We're never "discarding" entropy. We're just feeling more and more
> confortable in saying we've stored 'poolsize' random bits.

Yes we are. The pool can only hold n bits. If it's full and we mix in
m more bits, we're losing m bits in the process.

> But what you say is definitely true... on my desktop system I only need
> to move the mouse a couple of times to fill the pool completely in a
> matter of seconds.

Heh. That's actually a bug. Your mouse movement is only giving the
system a few hundred bits of entropy (by the current code's
measurements), but /dev/random will give out thousands. 

Note that above a certain velocity, mouse samples are back to back
characters on the serial port (or packets in the keyboard controller),
so most of the timing entropy is in the early acceleration or during
direction changes.

> I see little convenience in having /dev/urandom semantic in the kernel
> (besides the fact it's already there, of course).

The kernel uses it internally for numerous things like sequence
numbers, syncookies, and UUIDs. So it doesn't take much to justify
exporting it..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
