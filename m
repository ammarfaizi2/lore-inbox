Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWESKBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWESKBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWESKBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:01:08 -0400
Received: from the.earth.li ([193.201.200.66]:17569 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S932197AbWESKBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:01:07 -0400
Date: Fri, 19 May 2006 11:01:05 +0100
From: Jonathan McDowell <noodles@earth.li>
To: David Vrabel <dvrabel@arcom.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
Message-ID: <20060519100105.GF7570@earth.li>
References: <20060518160940.GS7570@earth.li> <20060518165728.GA26113@wohnheim.fh-wedel.de> <20060519090142.GB7570@earth.li> <446D90B5.2090802@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446D90B5.2090802@arcom.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 10:32:37AM +0100, David Vrabel wrote:
> Jonathan McDowell wrote:
> > On Thu, May 18, 2006 at 06:57:28PM +0200, Jörn Engel wrote:
> >> On Thu, 18 May 2006 17:09:41 +0100, Jonathan McDowell wrote:
> >>> +	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
> >>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> Could that be done in a macro?
> > 
> > Is there any benefit to doing so?
> > 
> >>> +	udelay(0.04);
> >> Floating point in the kernel?
> > 
> > Not quite. udelay is a macro on ARM so this ends up as an integer before
> > it ever hits a function call. In an ideal world I'd use "ndelay(40);"
> > but that would result in a delay of over 1µs as ARM doesn't have ndelay
> > defined so we hit the generic fallback.
> 
> Use instead:
> 
> /* delay for at least 40 ns */
> udelay(1);

Using "ndelay(40);" here would seem to make more sense; it's equivalent
at present and means that once I or someone else provided an ndelay
implementation for ARM the driver wouldn't need changed to take
advantage of it.

J.

-- 
                 /------------------------------------\
                 |      Ships log... erm... one.      |
                 | http://www.blackcatnetworks.co.uk/ |
                 \------------------------------------/
