Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVLNRYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVLNRYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVLNRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:24:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:32984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750786AbVLNRYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:24:12 -0500
Date: Wed, 14 Dec 2005 09:18:42 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-ID: <20051214171842.GB30546@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A0230B.1040904@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 04:50:03PM +0300, Vitaly Wool wrote:
> Greg KH wrote:
> 
> >On Tue, Dec 13, 2005 at 11:01:01AM -0800, David Brownell wrote:
> > 
> >
> >>It's way better to just insist that all I/O buffers (in all
> >>generic APIs) be DMA-safe.  AFAICT that's a pretty standard
> >>rule everywhere in Linux.
> >>   
> >>
> >
> >I agree.
> > 
> >
> Well, why then David doesn't insist on that in his own code?

Heh, I don't know, only David can answer that :)

> His synchronous transfer functions are allocating transfer buffers on
> stack which is not DMA-safe.
> Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
> Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
> functions are called (as he proposes for upper layer drivers to do)?
> That's a significant inconsistency. Is it also the thing you agree with?
> 
> And they way he does it implies redundant memcpy's and kmalloc's: 
> suppose we have two controller drivers working in two threads and 
> calling write_then_read in such a way that the one called later has to 
> allocate a new buffer. Suppose also that both controller drivers are 
> working in *PIO* mode. In this situation you have one redundant kmalloc 
> and two redundant memcpy's, not speaking about overhead brought up by 
> mutexes.
> 
> The thing is that only controller driver is aware whether DMA is
> needed or not, so it's controller driver that should work it out.
> Requesting all the buffers to be DMA-safe will make a significant
> performance drop on all small transfers!

What is the speed of your SPI bus?

And what are your preformance requirements?

thanks,

greg k-h
