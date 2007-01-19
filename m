Return-Path: <linux-kernel-owner+w=401wt.eu-S932829AbXASRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbXASRy4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXASRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:54:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:54742 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932829AbXASRyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:54:55 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 12:39:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Adrian Bunk <bunk@stusta.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: [PATCH] Stop making "inline" imply forced inlining.
In-Reply-To: <20070119172542.GO9093@stusta.de>
Message-ID: <Pine.LNX.4.64.0701191228200.25140@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701191156000.24621@CPE00045a9c397f-CM001225dbafb6>
 <20070119172542.GO9093@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Adrian Bunk wrote:

> On Fri, Jan 19, 2007 at 11:56:30AM -0500, Robert P. J. Day wrote:
> >
> >   Remove the macros that define simple "inlining" to mean forced
> > inlining, since you can (and *should*) get that effect with the
> > CONFIG_FORCED_INLINING kernel config variable instead.
>
> NAK.
>
> I don't see any place in the kernel where we need a non-forced
> inline.

that's not the point.  the point is that, as it stands now, the build
is *broken* in three ways.

first, it's broken because declaring something simply as "inline"
*forces* it to be inlined, which flies in the face of historical
convention and is more than a little misleading.

second, it's broken because both the use of
"__attribute__((always_inline))" all over the place and the
CONFIG_FORCED_INLINING kernel config option imply that you indeed have
a choice, when you clearly *don't*.  quite simply, you can play with
that kernel config option or splash the "always_inline" attributes
around all you want and, unbeknownst to you, none of that is making
the *slightest* bit of difference.  that is the very *definition* of a
"broken" build.

and, finally, you claim that you "don't see any place in the kernel
where we need a non-forced inline."  i have already posted an alpha
header file that claims (rightly or wrongly) to need that freedom.
Q.E.D.

> We have tons of inline's in C files that should simply be removed -
> let's do this instead.

that may be a better idea, but it doesn't address the current
brokenness.

i'm willing to believe that this patch has zero chance of going
anywhere.  but if you want to reject it, at least be honest about it.
don't say, "there's no problem here."  instead, say, "yes, the build
is broken but we don't feel like doing anything about it."

rday
