Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUGLL6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUGLL6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUGLL6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:58:42 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31158 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266643AbUGLL6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:58:36 -0400
Date: Mon, 12 Jul 2004 13:50:03 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712115003.GV3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040712102818.GB31013@devserv.devel.redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-12T12:28:19,
   Arjan van de Ven <arjanv@redhat.com> said:

> > Sure, but the network IO is isolated from the main process via a _very
> > careful_ non-blocking IO using sockets library, so that works out well.
> ... which of course never allocates skb's ? ;)

No, the interprocess communication does not; it's local sockets. I think
Alan (Robertson) even has a paper on this. It's really quite well
engineered, with a non-blocking poll() implementation based on signals
and stuff. Oh well.

> > But again, I'd rather like to see this solved (memory pools for
> > userland, PF_ etc), because it's relevant for many scenarios requiring
> PF_ is not enough really ;) 
> You need to force GFP_NOFS etc for several critical parts, and well, by
> being in kernel you can avoid a bunch of these allocations for real, and/or
> influence their GFP flags

True enough, but I'm somewhat unhappy with this still. So whenever we
have something like that we need to move it into the kernel space?
(pvmove first, and now the clustering etc.) Can't we come up with a way
to export this flag to user-space?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

