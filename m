Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRF0Ngq>; Wed, 27 Jun 2001 09:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRF0Ngf>; Wed, 27 Jun 2001 09:36:35 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:2564 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S261684AbRF0NgR>; Wed, 27 Jun 2001 09:36:17 -0400
Date: Wed, 27 Jun 2001 15:36:14 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: John Stoffel <stoffel@casc.com>, Jason McMullan <jmcmullan@linuxcare.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <Pine.LNX.4.33L.0106261838320.23373-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106271509570.6630-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Rik van Riel wrote:

> On Tue, 26 Jun 2001, John Stoffel wrote:
>
> > >> * If we're getting low cache hit rates, don't flush
> > >> processes to swap.
> > >> * If we're getting good cache hit rates, flush old, idle
> > >> processes to swap.
> >
> > Rik> ... but I fail to see this one. If we get a low cache hit rate,
> > Rik> couldn't that just mean we allocated too little memory for the
> > Rik> cache ?
> >
> > Or that we're doing big sequential reads of file(s) which are
> > larger than memory, in which case expanding the cache size buys
> > us nothing, and can actually hurt us alot.
>
> That's a big "OR".  I think we should have an algorithm to
> see which of these two is the case, otherwise we're just
> making the wrong decision half of the time.
>
> Also, in many systems we'll be doing IO on _multiple_ files
> at the same time, so I guess this will have to be a file-by-file
> decision.

Of course, you can always think of a "bad" behaviour. That should
really be a page-by-page decision. An application may have both data and
meta-data on the same file. You want to keep the metadata on core
(think of access by an index, it's much better if all the index is there,
even some unused parts) *and* cache commonly used data (that's just
a cache of hot objects, normal replacement algoriths may be used) *and*
drop-behind data on sequential scans...  trying to understand what
an application is doing, in order to foresee what it will be doing,
it's bad attitude. Let's give an application writer a way to code it
sanely (setting per-file VM attributes is fine).  If an application
is not friendly (gives no hints on its VM behaviour) just punish it.
I mean, when tuning the VM behaviour, system health and friendly
applications performance are the goals - do whatever necessary to preserve
them, even kill the offender and rm its executable if someone it's
running it again (*grin*) B-).

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

