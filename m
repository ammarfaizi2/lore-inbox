Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSEHTil>; Wed, 8 May 2002 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314975AbSEHTik>; Wed, 8 May 2002 15:38:40 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:774 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S314957AbSEHTik>; Wed, 8 May 2002 15:38:40 -0400
Date: Wed, 8 May 2002 20:38:29 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: Dax Kelson <dax@gurulabs.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
In-Reply-To: <Pine.LNX.4.44.0205080136560.8607-100000@mooru.gurulabs.com>
Message-ID: <Pine.LNX.4.33.0205082029060.14553-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wed, 8 May 2002, Dax Kelson wrote:

> Originally when a process set*uided all capabilities bits were cleared.
> Then sometime later (wish BK went back 3 years), the behaviour was
> modified according to the comment "A process may, via prctl(), elect to
> keep its capabilites when it calls setuid() and switches away from
> uid==0. Both permitted and effective sets will be retained."
>
> The current behavior/implementation doesn't match the comment. Only
> permitted capabilities are retained.
>
> This patch against 2.4.18-3 (RHL7.3 kernel, should apply against stock)
> fixes it.  Now both permitted and effective capabilities are retained.

This is a change of behaviour in a fairly security sensitive area, so I'd
like us to step back and ask - should we fix the code or the comment?

An application using prctl()[1] is capability aware. I think it is fair
(and more secure) if we require these applications to explicitly request
raising capabilities in the effective set, after the switch from euid == 0
to euid != 0.

Comments?

Cheers
Chris

[1] There are quite a few now - search google for PR_SET_KEEPCAPS.

