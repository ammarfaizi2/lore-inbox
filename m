Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275832AbRI1EyD>; Fri, 28 Sep 2001 00:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275833AbRI1Exx>; Fri, 28 Sep 2001 00:53:53 -0400
Received: from member.michigannet.com ([207.158.188.18]:34566 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S275832AbRI1Exp>; Fri, 28 Sep 2001 00:53:45 -0400
Date: Fri, 28 Sep 2001 00:53:03 -0400
From: Paul <set@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
Message-ID: <20010928005302.A226@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Rik van Riel <riel@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001377785.1430.7.camel@gromit.house> <Pine.LNX.4.33L.0109242234410.19147-100000@imladris.rielhome.conectiva> <20010925203515.A227@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925203515.A227@squish.home.loc>; from set@pobox.com on Tue, Sep 25, 2001 at 08:35:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi.

	Got 2.4.9-ac16, and ran the 'test' described in my previous
post in this thread, and some benchmarks. Interactive performance 
was fine, but not quite as snappy as 2.4.9-ac15. I think this is
because 2.4.9-ac15 just didnt want to swap, due no doubt to the
mispatch. I guess everything I do 'normally' tends to fit well
within my available memory.
	Aiming the gun squarely at my toe again, I modified my
malloc program to write to the mem it allocs, and sleep 50us,
so I can watch it progress. Quite different results this time:
	(I have 128M ram and 330M swap)
	Mal's RSS climbed to around 60-90M, eating up free mem
until free mem was at 2.8M. Then some of the buffers and cache
drained. (mot much though-- I kept moving around the virtual
desktop and doing stuff, and interactivity was fine, and disk
was extremely quiet during whole test). After Mal drained as much
from cache and buff as it could, it would go to swap periodicly,
until eventually all of swap was used up. Then it started on the
buff and cache again-- it didnt seem to completely deplete them,
but they got down pretty low. Then it finally started getting
some of that 2.8M free memory that had been reserved this whole
time. Swap was completely full, cache and buff were very low, and
free mem went to zip. Then the OOM killer took it. At no point was the
machine thrashing.
	I dont know if this really says anything, but it was
comforting to see such a seemingly rational smooth progression
and termination:)
	Then I modified Mal to write to every chunk it had malloc'd
each time it malloc'd more. This is punishing:) After a while it
is a fight with Mal and everyone to be in memory. Disk activity
becomes contant, and things keep getting swapped out, however, Im
writing this with some degree of interactive degradation as it
goes on. Load is only 2, and Mal has slowed to a crawl, but the
machine is running as well as can be expected.

Thanks;
Paul
set@pobox.com
