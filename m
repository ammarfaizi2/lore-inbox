Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRLBM4u>; Sun, 2 Dec 2001 07:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282872AbRLBM4l>; Sun, 2 Dec 2001 07:56:41 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28169 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282867AbRLBM40>;
	Sun, 2 Dec 2001 07:56:26 -0500
Date: Sun, 2 Dec 2001 10:17:48 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: <space-00002@vortex.physik.uni-konstanz.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: buffer/memory strangeness in 2.4.16 / 2.4.17pre2
In-Reply-To: <3C09B168.401E61C9@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0112021014330.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Andrew Morton wrote:

> You'll find that if you push the machine really hard - allocate
> 1.5x physical memory and touch it all then the VM will, eventually,
> with great reluctance and much swapping, relinquish the 30 megabytes
> of buffercache memory.  But it's out of whack.

This is an expected (and very bad) side effect of use-once.

> If we put anon pages on the active list instead, then shrink_caches()
> and refill_inactive() start to do something, and they move that stale
> old buffercache memory onto the inactive list where it can be freed.

This would fix the problem of not being able to evict stale
active pages, but I have no idea if it would unbalance
something else.

> This is just a random hack.  I don't understand what's going on in
> the VM, let alone what's *supposed* to be going on.  And given the
> state of documentation available to us,  I never will.

The balancing in Andrea's VM is just too subtle to understand
without docs, that is, if there is any particular idea behind
it and it isn't just experimentation.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

