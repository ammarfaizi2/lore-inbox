Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267207AbSKUXt4>; Thu, 21 Nov 2002 18:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSKUXt4>; Thu, 21 Nov 2002 18:49:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12810 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267207AbSKUXtz>; Thu, 21 Nov 2002 18:49:55 -0500
Date: Thu, 21 Nov 2002 15:56:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill i_dev
In-Reply-To: <UTC200211212346.gALNkem21004.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0211211548530.5779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Nov 2002 Andries.Brouwer@cwi.nl wrote:
> 
> The i_dev field is deleted and the few uses are replaced
> by i_sb->s_dev.

Applied.

> There is a single side effect: a stat on a socket now sees
> a nonzero st_dev. There is nothing against that - FreeBSD
> has a nonzero value as well - but there is at least one
> utility (fuser) that will need an update.

Looking at the patch (not testing it), as far as I can tell we'll return a 
basically random number that is just whatever the anonymous super-block 
was allocated, right?

I'm not convinced that returning random numbers to user space is
necessarily a great idea.. That said, I think we already do it for unnamed
pipes anyway, so I'm more wondering if we should have some way to map
these numbews (in user space) to a valid thing, so that they wouldn't just
be random numbers.

(In other words: I like the patch, and I'm not really complaining about
this new behavour at all. It's just the "randomness" as far as user space
goes that bothers me a bit, since it seems to imply bad interface design).

		Linus

