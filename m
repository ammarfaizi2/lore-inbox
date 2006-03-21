Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWCUBty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWCUBty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCUBty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:49:54 -0500
Received: from bhhdoa.org.au ([65.98.99.88]:48399 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S1751400AbWCUBty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:49:54 -0500
Message-ID: <1142901656.441f4b98472e5@vds.kolivas.org>
Date: Tue, 21 Mar 2006 11:40:56 +1100
From: kernel@kolivas.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
References: <20060320122449.GA29718@outpost.ds9a.nl> <20060320145047.GA12332@rhlx01.fht-esslingen.de> <200603210224.23540.kernel@kolivas.org> <87wteo37vr.fsf@duaron.myhome.or.jp>
In-Reply-To: <87wteo37vr.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:

> Con Kolivas <kernel@kolivas.org> writes:
> > The pm timer is very fast when the timer is latched and that strange loop
> uses 
> > hardly any cpu time. The same can't be said about the unlatched timer case
> 
> > where absurd amounts of cpu seem the norm. You have a catch 22 situation if
> 
> > you depend on the accuracy of the pm timer only to end up wasting time
> trying 
> > to actually use that timer. 
> 
> Actually, pmtmr not seems very fast, rather it's slow like usual I/O port.

What I mean is that I've seen profiles of the worst (from Andi) showing up to 5%
cpu time on some workloads! That's a heck of a lot slower than when it's
latched.

> is about 1us.
> 
> And the following is test of gettimeofday(). Probably, we need a patch.
> Umm....
> 
> 2.6.16 (pmtmr)
> Simple gettimeofday: 3.6532 microseconds


> 2.6.16+patch (pmtmr)
> Simple gettimeofday: 1.4582 microseconds

Looks well worth it

> 2.6.16 (tsc)
> Simple gettimeofday: 0.4037 microseconds


> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks!

> +	if (unlikely(pmtmr_need_workaround)) {

I would not put this in an unlikely because on the machines where
pmtmr_need_workaround is true this will always be true.

Cheers,
Con

