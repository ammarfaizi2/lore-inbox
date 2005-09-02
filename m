Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVIBOKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVIBOKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbVIBOKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:10:45 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:53645 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161016AbVIBOKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:10:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pedro Venda <pjvenda@arrakis.net.dhis.org>
Subject: Re: [ck] Re: [PATCH][RFC] vm: swap prefetch
Date: Sat, 3 Sep 2005 00:10:19 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, Hans Kristian Rosbach <hk@isphuset.no>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200509012346.33020.kernel@kolivas.org> <200509020018.32993.kernel@kolivas.org> <200509021501.29505.pjvenda@arrakis.dhis.org>
In-Reply-To: <200509021501.29505.pjvenda@arrakis.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509030010.19880.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005 01:01, Pedro Venda wrote:
> On Thursday 01 September 2005 14:18, Con Kolivas wrote:
> > On Fri, 2 Sep 2005 00:18, Hans Kristian Rosbach wrote:
> > > On Thu, 2005-09-01 at 23:46 +1000, Con Kolivas wrote:
> > > > Here is a working swap prefetching patch for 2.6.13. I have
> > > > resuscitated and rewritten some early prefetch code Thomas Schlichter
> > > > did in late 2.5 to create a configurable kernel thread that reads in
> > > > swap from ram in reverse order it was written out. It does this once
> > > > kswapd has been idle for a minute (implying no current vm stress).
> > > > This patch attached below is a rollup of two patches the current
> > > > versions of which are here:
> > >
> > > That said, I have often thought it might be good to have something like
> > > pre-writing swap, ie reverse what your patch does.
> > >
> > > In other words it'd keep as much of swappable data on disk as possible,
> > > but without removing it from memory. So when it comes time to free up
> > > some memory, the data is already on disk so no performance penalty from
> > > writing it out.
>
> both ideas make all the sense to me. I'll give it a try, but in what way
> can we test this kind of enhancement? maybe write a small program that
> starts fills a good part of swap space and then, after 1min idle, 'watch
> free -m' should show free memory decreasing (not counting cache/buffers)
> with idle activity. decent?

Yes that about wraps up what it does. It would be even better used in a real 
world situation on a machine that has trouble "getting started" after an 
overnight updatedb run and has been idle for a while.

> about the Hans's proposal - it would increase power consumption, because of
> increased disk activity. about con's swap prefetch, I'm not so sure...

Depends entirely on workload. Overall I think this increases power consumption 
because the disk does tiny little reads and keeps spinning until it has 
finished prefetching as much as it can. I was thinking it could be made 
configurable and to detect when laptop mode was enabled and so on... if it is 
thought that this is desirable of course.

Cheers,
Con
