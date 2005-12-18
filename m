Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVLRLV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVLRLV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 06:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVLRLV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 06:21:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965083AbVLRLV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 06:21:27 -0500
Subject: Re: [2.6 patch] i386: always use 4k/4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512181149.02009.stefan@loplof.de>
References: <200512181149.02009.stefan@loplof.de>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 12:21:23 +0100
Message-Id: <1134904884.9626.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Btw., has anyone yet *measured* maximum stack usage for some weeks on several 
> machines, e.g. desktop system with one NIC, reiserfs; server with several 
> NICs, stacked device-mapper targets, fiber channel, appletalk...; web server 
> with SQL database running on it etc?

partially, see below

> Right now I have the impression that the 4k stack flamewars base on make 
> checkstack output, waiting for bugreports and other guesswork. Removing the 
> safety net on such a basis is just *very bad engineering*.

your impression is wrong.

the kernel has a stack overflow detector, which checks at irq entry time
if the stack is "rather high" (7kb into the stack on a 8kb stack, 3.5kb
on a 4k stack). When this warning hits there's still runway left (like
12.5 percent), but lets say the end becomes in sight. If the stack usage
would be really tight, this "early warning" detector would be hitting a
lot of people, right? Well the good news is that it isn't being hit in
the distributions that use 4Kb stacks (at least the fedora releases and
RHEL, maybe others), with a few exceptions related to XFS use several
months ago (which got fixed since). 

While this isn't a measure of how deep things ACTUALLY go, it's a
measure that they don't go past the 3.5Kb limit, let alone go past 4Kb
limit. 

In addition someone did a chain analysis (which no doubt isn't 100%
complete but still a pretty good effort) and that didn't show major
problems either.

The guesswork in this thread is all from the people on the other side of
the argument, with lots fear and doubt but with no data ;)

(and the "safety net" is a bit of misnomer, since it's not really safe,
just "statistically different" if the shit hits the fan)

