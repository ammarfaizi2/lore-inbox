Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752057AbWKBKZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbWKBKZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWKBKZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:25:17 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:1992 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752033AbWKBKZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:25:15 -0500
Date: Thu, 2 Nov 2006 11:24:27 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Holden Karau <holden@pigscanfly.ca>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, Holden Karau <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Matthew Wilcox"@wohnheim.fh-wedel.de
Subject: historical micro-optimizations (Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised again)
Message-ID: <20061102102427.GA22216@wohnheim.fh-wedel.de>
References: <4548C8AE.2090603@pigscanfly.ca> <20061101164715.GC16154@wohnheim.fh-wedel.de> <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com> <20061101202400.GA6888@wohnheim.fh-wedel.de> <454908F9.80905@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454908F9.80905@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 November 2006 15:52:09 -0500, Phillip Susi wrote:
> 
> In other words, the only time this micro optimization will be of benefit 
> is if you are erroring out most of the time rather than only under 
> exceptional conditions, AND the error label isn't too far away for a 
> conditional branch to reach.  In other words, just don't do it ;)

The difference was in code size, so the icache impact would have
benefitted the good case as well.  "was" and "would have" because I
finally got off my lazy arse and tested the code.  With gcc 4.12 both
variants compiled to exactly the same code.  With 2.95 there was a one
instruction (2 bytes) difference.

I didn't test all the versions in between, but the advantage is
definitely a thing of the past.

And even if the 2 byte difference still existed, it wouldn't really
matter much, we all agree on that.  That's why I said:

> >Both methods definitely work.  Whether one is preferrable over the
> >other is imo 90% taste and maybe 10% better code on some architecture.
> >So just pick what you prefer.

The only thing I was arguing was that one method would not work - it
does.  So I hope this was sufficient distraction for everyone and we
can get back to work. :)

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
