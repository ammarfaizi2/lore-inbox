Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVKCWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVKCWAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKCWAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:00:11 -0500
Received: from silver.veritas.com ([143.127.12.111]:20415 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750786AbVKCWAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:00:10 -0500
Date: Thu, 3 Nov 2005 21:59:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: bad page state under possibly oom situation
In-Reply-To: <20051103211151.GA22769@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0511032144110.537@goblin.wat.veritas.com>
References: <20051102143502.GE6137@in.ibm.com>
 <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
 <4369B051.7050303@colorfullife.com> <20051103211151.GA22769@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Nov 2005 22:00:10.0124 (UTC) FILETIME=[F573BCC0:01C5E0C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Dipankar Sarma wrote:
> On Thu, Nov 03, 2005 at 07:38:09AM +0100, Manfred Spraul wrote:
> > Hugh Dickins wrote:
> > > flags 0x90 mean PG_slab|PG_dirty.)
> > A very odd combination:
> > Or change the value of PG_slab to 20 
> > and check if page->flags remains 0x90.

Good observation and suggestion from Manfred.

> Here is a dump of the page struct when this happens (two different
> instances) - 

Yuk!

page ffff810008005550 flags 4000005500009090, but the rest is okay.
page ffff81000800aaa0 count 00900055, but the rest is okay (including
                                      mapcount, the int above count).
Even the page addresses seem related.

You seem to be infected with 55s and 90s,
nothing to do with PG_slab|PG_dirty; but I don't know what it means.

Hugh
