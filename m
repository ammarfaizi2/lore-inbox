Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbTL0DAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTL0DAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:00:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:37248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265299AbTL0DAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:00:39 -0500
Date: Fri, 26 Dec 2003 19:00:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@surriel.com>
Cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-Id: <20031226190045.0f4651f3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
References: <1072423739.15458.62.camel@gaston>
	<Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
	<1072482941.15458.90.camel@gaston>
	<Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
	<1072485899.15456.96.camel@gaston>
	<Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
	<Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 26 Dec 2003, Linus Torvalds wrote:
> 
> > I'll let Rik and Andrea argue that part - it's entirely possible that
> > getting lots of positive results is a _good_ thing, if the same page is
> > mapped multiple times. That would just make us less eager to unmap it,
> > which sounds like potentially the right thign to do (it's also how the
> > old non-rmap code worked, and I know Rik thought it was "unfair", but
> > whatever).
> 
> I'm really not sure which of the two behaviours would
> perform better.  Chances are both behaviours will show
> some performance improvement over the other, depending
> on the workload...
> 

The current behaviour seems better from a theoretical point of view.  All
we want to know is the reference pattern - whether it is one process
referencing the page frequently or 100 processes referencing it
infrequently shouldn't matter.  And if we want to give mapped pages more
preference over unmapped ones (they already have some preference, by the
default value of /proc/sys/vm/swappiness), we have less radical ways of
doing this.

But yes, it probably makes damn-all difference across a mix of workloads.

