Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUCLQbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUCLQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:31:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:49031 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261764AbUCLQbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:31:32 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16465.58851.227553.595591@laputa.namesys.com>
Date: Fri, 12 Mar 2004 19:31:31 +0300
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
In-Reply-To: <4051D737.1050108@cyberone.com.au>
References: <404FACF4.3030601@cyberone.com.au>
	<200403111825.22674@WOLK>
	<40517E47.3010909@cyberone.com.au>
	<20040312012703.69f2bb9b.akpm@osdl.org>
	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>
	<4051B0C6.2070302@cyberone.com.au>
	<4051C5F1.2050605@cyberone.com.au>
	<16465.53692.106520.847235@laputa.namesys.com>
	<4051D737.1050108@cyberone.com.au>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > 
 > 
 > Nikita Danilov wrote:
 > 
 > >Nick Piggin writes:
 > > > 
 > >
 > >[...]
 > >
 > > > 
 > > > By the way, I would be interested to know the rationale behind
 > > > mark_page_accessed as it is without this patch, also what is it doing in
 > > > rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
 > > > still). It seems to me like it only serves to make VM behaviour harder to
 > > > understand, but I'm probably missing something. Andrew?
 > >
 > >With your patch, once a page got into inactive list, its PG_referenced
 > >bit will only be checked by VM scanner when page wanders to the tail of
 > >list. In particular, if is impossible to tell pages that were accessed
 > >only once while on inactive list from ones that were accessed multiple
 > >times. Original mark_page_accessed() moves page to the active list on
 > >the second access, thus making it less eligible for the reclaim.
 > >
 > >
 > 
 > With my patch though, it gives unmapped pages the same treatment as
 > mapped pages. Without my patch, pages getting a lot of mark_page_accessed
 > activity can easily be promoted unfairly past mapped ones which are simply
 > getting activity through the pte.

Another way to put it is that treatment of file system pages is dumbed
down to the level of mapped ones: information about access patterns is
just discarded.

 > 
 > I say just set the bit and let the scanner handle it.

I think that decisions about balancing VM and file system caches should
be done by higher level, rather than by forcing file system to use
low-level mechanisms designed for VM, where only limited information is
provided by hardware. Splitting page queues is a step in a right
direction, as it allows to implement more precise replacement for the
file system cache.

Nikita.
