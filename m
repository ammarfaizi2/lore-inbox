Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271143AbRHOLV2>; Wed, 15 Aug 2001 07:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271144AbRHOLVT>; Wed, 15 Aug 2001 07:21:19 -0400
Received: from [195.89.159.99] ([195.89.159.99]:59118 "EHLO thefinal.cern.ch")
	by vger.kernel.org with ESMTP id <S271143AbRHOLU6>;
	Wed, 15 Aug 2001 07:20:58 -0400
Date: Tue, 14 Aug 2001 16:59:51 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: george anzinger <george@mvista.com>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: No 100 HZ timer !
Message-ID: <20010814165951.A4935@thefinal.cern.ch>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3B675682.3CE51A3D@mvista.com> <20010811115737.B35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010811115737.B35@toy.ucw.cz>; from pavel@suse.cz on Sat, Aug 11, 2001 at 11:57:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > The testing I have done seems to indicate a lower overhead on a lightly
> > loaded system, about the same overhead with some load, and much more
> > overhead with a heavy load.  To me this seems like the wrong thing to
> > do.  We would like as nearly a flat overhead to load curve as we can get
> 
> Why? Higher overhead is a price for better precision timers. If you rounded
> all times in "tickless" mode, you'd get about same overhead, right?

What Pavel says is true only if the data structure for holding pending
timers degrades into good O(1) insertion & deletion time in the tickless case.

I recall George Anzinger saying something about the current ticked
scheduler being able to insert timers that never reach expiry very
efficiently (simply a list insert + delete), whereas the current
tickless code could not do that.

Is that right?  Is it the data structure that is taking too long to
process, when many timers that do not reach expiry are inserted?  There
would be one such insertion and deletion on every context switch, right?

-- Jamie
