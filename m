Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131774AbRAZPb7>; Fri, 26 Jan 2001 10:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRAZPbt>; Fri, 26 Jan 2001 10:31:49 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:59151 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S131774AbRAZPbm>; Fri, 26 Jan 2001 10:31:42 -0500
Date: Fri, 26 Jan 2001 16:31:03 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Message-ID: <20010126163103.F7096@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.3.95.1010126095653.762A-100000@chaos.analogic.com> <Pine.LNX.4.10.10101261012010.18973-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101261012010.18973-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Fri, Jan 26, 2001 at 10:15:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> >  #ifdef SLOW_IO_BY_JUMPING
> >  #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
> >  #else
> > -#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
> > +#define __SLOW_DOWN_IO "\noutb %%al,$0x19"
> 
> this is nutty: why can't udelay be used here?  empirical measurements
> in the thread show the delay is O(2us).

Does anyone remember where __SLOW_DOWN_IO is needed any more?

udelay() makes sense.  Modern drivers use small udelays themselves to
confirm to chip specs.

Some ISA drivers appear to use outb_p "just to be on the safe side", no
idea if it's appropriate or not.  Some even mix outb and outb_p based on
educated guesses.  I know, I've written such code :-)

-- Jamie


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
