Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUGILOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUGILOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUGILOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:14:21 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:49816 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265953AbUGILOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:14:18 -0400
Subject: Re: Autoregulate swappiness & inactivation
From: FabF <fabian.frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org
In-Reply-To: <40EE76CC.5070905@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
	 <1089284097.3691.52.camel@localhost.localdomain>
	 <40EDEF68.2020503@kolivas.org>
	 <1089366486.3322.10.camel@localhost.localdomain>
	 <40EE76CC.5070905@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089371646.3322.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 13:14:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 12:43, Nick Piggin wrote:
> FabF wrote:
> 
> > 
> > Here's an easy benchmark to demonstrate problem :
> > 1.Run Mozilla
> > 2.Minimize
> > 3=>Mozilla Resident Size (mrs) : 24Mb
> > 4.Run updatedb
> > 5.=>mrs : 15Mb
> > 6.updatedb ends up
> > 7.mrs doesn't move at all (yes, it goes down as I'm typing this msg :)).
> > 
> 
> How much RAM do you have? Does this happen with and without Con's
> patch?
Hi Nick,

256Mb with Con's patch 1 (autoswappiness activated) mm6
but it's general behaviour on my box :(

> 
> I don't have a problem here with your problem, however I'm running
> my -np patchset, which has different use-once heuristics.
> 
> > So my question is :
> > Don't we have a way to say "whose pages were reclaimed from and
> >  reattribute its" ? (having in mind memory status per se).
> > IOW flushing (I guess it's pdflush relevant ? ) do work for dead
> > processes but doesn't care about applications alive...
> > 
> 
> Page reclaim doesn't really know or care about processes, it
> basically works on a global page pool.
That's exactly the nerve center of the problem I guess.
When we swap we don't care about different processes but when some of
its is going in, we _quickly_ need to refresh memory but isn't it too
late ? I mean what do we do here ? We recover pages and "get application
to life".Desktop side of the story reminds me about some oses giving
_impression_ all was alright.I mean there must be a way to anticipate
 such trouble without renice -xx all GUI relevant processes
 in order to have both server/client cfg synergy.
 
> 
> pdflush is used to perform writeout of dirty data, so it has
> no part in reducing Mozilla's RSS.
Oops ... kswapd then ?

> 
> I don't really understand what you are asking though. Your basic
> problem is that mozilla's resident memory gets evicted too easily,
> is that right?
> 
Not at all.My problem is mozilla has some MB to recover when
reactivating; meanwhile, I consider there was sufficient resource to
share with it _before_ reactivation as I'm waiting some minutes after an
heavy process (e.g updatedb) to be done and over.

AFAICS, Con's patches are about auto-regulation, not about anticipation
(?)

Regards,
FabF


