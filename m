Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbSJCAb3>; Wed, 2 Oct 2002 20:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbSJCAb3>; Wed, 2 Oct 2002 20:31:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262703AbSJCAb3>; Wed, 2 Oct 2002 20:31:29 -0400
Date: Wed, 2 Oct 2002 17:36:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
In-Reply-To: <7146.1033580256@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Oct 2002, David Howells wrote:
> 
> This patch adds an Andrew File System (AFS) driver to the kernel. Currently
> it only provides read-only, uncached, non-automounted and unsecured support.

Are you sure this is the right way to go?

As far as I can tell, this is a dead end, because we fundamentally cannot
do the local backing store from the kernel.

>From my (nonexistent) understanding of how AFS works, would it not be a 
whole lot more sensible to implement it as a coda client or something like 
that (with the networking support in-kernel, but with the caching logic 
etc in user space).

I dunno, I just get the feeling that a good AFS client simply cannot be 
done entirely in kernel space, and if you start off like this, you'll 
never get where you really want to go. Pls comment on this (and yeah, the 
comment can be a "Boy, you're really a stupid git, and here's why: xyz", 
but I really want the "xyz" part too ;)

Now, admittedly maybe the user-space deamon approach is crap, and what we
really want is to have some way to cache network stuff on the disk
directly from the kernel, ie just implement a real mapping/page-indexed
cachefs that people could mount and use together with different network 
filesystems.

		Linus

