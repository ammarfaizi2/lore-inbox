Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVDHEkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVDHEkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVDHEkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:40:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:5524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262651AbVDHEkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:40:10 -0400
Date: Thu, 7 Apr 2005 21:42:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408041341.GA8720@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Chris Wedgwood wrote:
> 
> I'm playing with monotone right now.  Superficially it looks like it
> has tons of gee-whiz neato stuff...  however, it's *agonizingly* slow.
> I mean glacial.  A heavily sedated sloth with no legs is probably
> faster.

Yes. The silly thing is, at least in my local tests it doesn't actually
seem to be _doing_ anything while it's slow (there are no system calls
except for a few memory allocations and de-allocations). It seems to have
some exponential function on the number of pathnames involved etc.

I'm hoping they can fix it, though. The basic notions do not sound wrong.

In the meantime (and because monotone really _is_ that slow), here's a
quick challenge for you, and any crazy hacker out there: if you want to
play with something _really_ nasty (but also very _very_ fast), take a
look at kernel.org:/pub/linux/kernel/people/torvalds/.

First one to send me the changelog tree of sparse-git (and a tool to
commit and push/pull further changes) gets a gold star, and an honorable
mention. I've put a hell of a lot of clues in there (*).

I've worked on it (and little else) for the last two days. Time for 
somebody else to tell me I'm crazy.

		Linus

(*) It should be easier than it sounds. The database is designed so that
you can do the equivalent of a nonmerging (ie pure superset) push/pull
with just plain rsync, so replication really should be that easy (if
somewhat bandwidth-intensive due to the whole-file format).

Never mind merging. It's not an SCM, it's a distribution and archival
mechanism. I bet you could make a reasonable SCM on top of it, though.
Another way of looking at it is to say that it's really a content-
addressable filesystem, used to track directory trees.
