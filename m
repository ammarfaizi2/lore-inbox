Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUFEVNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUFEVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFEVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:13:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:43702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262406AbUFEVNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:13:20 -0400
Date: Sat, 5 Jun 2004 14:13:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>, Ulrich Drepper <drepper@redhat.com>
cc: Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <20040605205547.GD20716@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406051405110.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
 <20040605205547.GD20716@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004, Arjan van de Ven wrote:
> 
> ... or glibc internally caches the getpid() result and doesn't notice the
> app calls clone() internally... strace seems to show 1 getpid() call total
> not 2.

Why the hell does glibc do that totally useless optimization?

It's a classic "optimize for benchmarks" thing - evil. I don't see any
real app caring, and clearly apps _do_ fail when you get it wrong, as
shown by Russell.

And it's really easy to get it wrong. You can't just invalidate the cache
when you see a "clone()" - you have to make sure that you never ever cache
it ever after either.

Uli, if Arjan is right, then please fix this. It's a buggy and pointless 
optimization. Anybody who optimizes purely for benchmarks should be 
ashamed of themselves.

		Linus


