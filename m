Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSHQAlZ>; Fri, 16 Aug 2002 20:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHQAlY>; Fri, 16 Aug 2002 20:41:24 -0400
Received: from waste.org ([209.173.204.2]:22924 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317592AbSHQAlY>;
	Fri, 16 Aug 2002 20:41:24 -0400
Date: Fri, 16 Aug 2002 19:45:20 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: henrique <henrique@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817004520.GN5418@waste.org>
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <200208161751.35895.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208161751.35895.henrique@cyclades.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 05:51:35PM +0000, henrique wrote:
> 
> What would you do in my situation. I am dealing with the Motorola
> MPC860T and my system has no disk (I use a flash), no mouse, no
> keyboard, no PCI bus. It has just a fast-ethernet, a console port
> and some serial ports.

I've just recently dealt with analyzing this very situation in my own work.

> After reading the discussion on the lkml I realize that the only
> places I can get randomness in my system is in the serial.c (that
> controls the serial ports) and arch/ppc/8xx_io/fec.c (fast eth
> driver) interrupts.
> 
> What do you think about this solution ???

For the purposes of a network appliance, it's probably sufficient. But
if you're making a term server, beware. You may be able to trust an
interactive user who's authenticated themselves to your configuration
UI to generate randomly timed keystrokes, but you can't trust just any
signal sent to you on a serial port. 

Realistically, the hashing done by /dev/urandom is probably strong
enough for most purposes. It's as cryptographically strong as whatever
block cipher you're likely to use with it. /dev/random goes one step
further and tries to offer something that's theoretically
unbreakable. Useful for generating things like large public keys, less
useful for generating the session keys used by SSL and the
like. They're easier to break by direct attack.

If that's not good enough for you, build in a noise generator like a
reverse biased diode. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
