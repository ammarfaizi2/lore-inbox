Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVKNL2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVKNL2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVKNL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:28:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751085AbVKNL2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:28:06 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051114112402.GT3699@suse.de>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx>
	 <1131964282.2821.11.camel@laptopd505.fenrus.org>
	 <20051114111108.GR3699@suse.de>
	 <1131967167.2821.14.camel@laptopd505.fenrus.org>
	 <20051114112402.GT3699@suse.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 12:27:57 +0100
Message-Id: <1131967678.2821.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 12:24 +0100, Jens Axboe wrote:
> > 
> > not sure; I do know that it very much helps java (many more threads
> > possible) and the VM (far less order 1 allocs). In addition the 4Kb
> > allocation can be satisfied with the per cpu list of free 4Kb pages,
> > while obviously an order 1 cannot and has to go global.
> 
> I realize it has nice advantages in theory, just wondering if anyone has
> done a performance analysis of 4kb vs 8kb stacks lately (or at all?).

I don't think at least anyone at RH has done any; the functionality gain
was already enough for us. One item I missed: in the many-thread cases,
you also save a lot of memory that can now be used for pagecache; 
this won't of course be visible in a microbenchmark but should help
system wide.

Also in the implementation I don't see any way 4Kb stacks could show up
in any benchmarks as negative; there are only 4 or 5 extra instructions
in any path, and afaics no cache downsides (in fact the same irq stack
memory is now reused for irqs instead of threadstack-du-jour, so less
footprint/hotter caches)


