Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbTL0DyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbTL0DyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:54:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:59549 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265304AbTL0DyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:54:10 -0500
Date: Fri, 26 Dec 2003 19:54:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Rik van Riel <riel@surriel.com>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
In-Reply-To: <20031226190045.0f4651f3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0312261951420.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
 <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
 <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
 <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
 <20031226190045.0f4651f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Andrew Morton wrote:
> 
> The current behaviour seems better from a theoretical point of view. 

I disagree. It's at least not obvious.

>							 All
> we want to know is the reference pattern - whether it is one process
> referencing the page frequently or 100 processes referencing it
> infrequently shouldn't matter.

I agree that those two cases should be the same. And in fact, those two
cases _will_ be the same by my suggested change ("break out of
'page_referenced()' early")

However, you ignore the third case: a page that is frequently used by 100 
processes.

Such a page behaves differently with the 'break early' behaviour, by 
pinnong the page more tightly. 

And I think that's the right behaviour. At least that's not "obviously 
wrong".

It's not something to do in 2.6.x, but I disagree that it's clear-cut.

		Linus
