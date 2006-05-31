Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWEaMge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWEaMge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEaMge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:36:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59626 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964984AbWEaMgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:36:33 -0400
Subject: Re: [rfc][patch] remove racy sync_page?
From: Arjan van de Ven <arjan@infradead.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
In-Reply-To: <447D8C99.2080009@aitel.hist.no>
References: <447AC011.8050708@yahoo.com.au>
	 <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au>
	 <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au>
	 <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
	 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
	 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org>
	 <447CE43A.6030700@yahoo.com.au>
	 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
	 <447D8C99.2080009@aitel.hist.no>
Content-Type: text/plain
Date: Wed, 31 May 2006 14:36:25 +0200
Message-Id: <1149078985.3114.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 14:31 +0200, Helge Hafting wrote:
> Linus Torvalds wrote:
> > On Wed, 31 May 2006, Nick Piggin wrote:
> >   
> >> The requests can only get merged if contiguous requests from the upper
> >> layers come down, right?
> >>     
> >
> > It has nothing to do with merging. It has to do with IO patterns.
> >
> > Seeking.
> >
> > Seeking is damn expensive - much more so than command issue. People forget 
> > that sometimes.
> >
> > If you can sort the requests so that you don't have to seek back and 
> > forth, that's often a HUGE win. 
> >
> > Yes, the requests will still be small, and yes, the IO might happen in 4kB 
> > chunks, but it happens a lot faster if you do it in a good elevator 
> > ordering and if you hit the track cache than if you seek back and forth.
> >   
> This is correct, but doesn't really explain why plugging might be good.
> 
> If requests go to disk immediately and the disk is able to keep
> up with the seeks, then plugging doesn't help. This is a low-bandwith
> case of course, but servicing each request immediately will
> keep the latency lower. 

only for writes. afaik for reads and other synchronous beasts we already
unplug immediately anyway.

In addition unplugging happens after like 3 or 4 requests and after a
few miliseconds, whatever comes first ... so you never wait really long
(on a "what a seek costs" scale) anyway

