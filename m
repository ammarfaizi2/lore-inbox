Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbRAIR6z>; Tue, 9 Jan 2001 12:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRAIR6p>; Tue, 9 Jan 2001 12:58:45 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:60387 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S131436AbRAIR6i>;
	Tue, 9 Jan 2001 12:58:38 -0500
Date: Tue, 9 Jan 2001 09:58:35 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, John Ruttenberg <rutt@chezrutt.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: wavelan has fatal error with 2.4.0 (but worked in 2.4.0-test12)
Message-ID: <20010109095835.C30225@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010109094217.A30225@bougret.hpl.hp.com> <E14G2t8-00074Q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14G2t8-00074Q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 05:48:47PM +0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 05:48:47PM +0000, Alan Cox wrote:
> > > It is a bug in the driver.
> > 
> > 	Please check again the code and point me the invalid
> > udelay(). You will realise that there is no delay in the driver that
> > is longer than 100ms.
> 
> The udelay limit is set a lot lower than 100mS. It has to be somewhat lower
> otherwise you have to do two levels of loops which will throw small udelay
> timings a fair whack.

	Sorry, I mixed up my units. All the delays are lower than 100us.

> > 	The bug is that udelay() can't be passed a variable but only a
> > constant. Therefore bug in udelay().
> 
> Sounds like a compiler bug.
> 
> #define udelay(n) (__builtin_constant_p(n) ? \
> 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
> 	__udelay(n))
> 
> non constants are covered.

	Therefore, compiler bug. Ouch !

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
