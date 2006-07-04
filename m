Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWGDHxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWGDHxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGDHxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:53:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12968 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750753AbWGDHxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:53:17 -0400
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Milton Miller <miltonm@bga.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44AA1D09.7080308@sgi.com>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
	 <200607040516.k645GFTj014564@sullivan.realtime.net>
	 <44AA1D09.7080308@sgi.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 09:53:11 +0200
Message-Id: <1151999591.3109.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 09:47 +0200, Jes Sorensen wrote:
> Milton Miller wrote:
> > On Mon Jul 03 2006 - 11:37:43 EST,  Jes Sorensen wrote:
> >> Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
> >> which have items in the bh lru and only flushing on the relevant
> >> CPUs. On systems with larger CPU counts it's quite normal that only a
> >> few CPUs are actively doing block IO, so spewing IPIs everywhere to
> >> flush this is unnecessary.
> 
> > Ok we are optimizing for the low but not zero traffic case ... 
> 
> Well yes and no. $#@$#@* hald will do the open/close stupidity a
> couple of times per second. On a 128 CPU system thats quite a lot of
> IPI traffic, resulting in measurable noise if you run a benchmark.
> Remember that the IPIs are synchronous so you have to wait for them to
> hit across the system :

can you get hald fixed? That sounds important anyway... stupid userspace
isn't going to be good no matter what, and the question is how much crap
we need to do in the kernel to compensate for stupid userspace...
especially if such userspace is open source and CAN be fixed...


