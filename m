Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVKNLTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVKNLTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVKNLTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:19:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63690 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751077AbVKNLTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:19:39 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051114111108.GR3699@suse.de>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx>
	 <1131964282.2821.11.camel@laptopd505.fenrus.org>
	 <20051114111108.GR3699@suse.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 12:19:27 +0100
Message-Id: <1131967167.2821.14.camel@laptopd505.fenrus.org>
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

On Mon, 2005-11-14 at 12:11 +0100, Jens Axboe wrote:
> On Mon, Nov 14 2005, Arjan van de Ven wrote:
> > On Mon, 2005-11-14 at 11:20 +0100, Pierre Ossman wrote:
> > > Adrian Bunk wrote:
> > > > It seems most problems with 4k stacks are already resolved.
> > > > 
> > > > I'd like to see this patch to always use 4k stacks in -mm now for 
> > > > finding any remaining problems before submitting this patch for 2.6.16.
> > > > 
> > > > 
> > > 
> > > Has the block layer been remade to a serial approach? 
> > 
> > yes.
> 
> Not in mainline it hasn't.

well the patch was for -mm ;)

> 
> Are there any recent benchmarks of 4kb vs 8kb stacks?

not sure; I do know that it very much helps java (many more threads
possible) and the VM (far less order 1 allocs). In addition the 4Kb
allocation can be satisfied with the per cpu list of free 4Kb pages,
while obviously an order 1 cannot and has to go global.

>  Is anyone shipping 4kb stack kernels?

Both Fedora and RHEL are shipping this for all 2.6 based versions (eg
FC2 and all later, RHEL4)


