Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSJASPF>; Tue, 1 Oct 2002 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262860AbSJASPF>; Tue, 1 Oct 2002 14:15:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26788 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262859AbSJASPD>; Tue, 1 Oct 2002 14:15:03 -0400
Date: Tue, 1 Oct 2002 15:20:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
In-Reply-To: <3D99E3C5.E0F99E9E@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210011518000.653-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Andrew Morton wrote:

> Problem is, it's cruel.  People don't notice that we shaved 15 seconds
> off that three minute session of file bashing which they just did.
> But they do notice that when they later wiggle their mouse, it takes
> five seconds to pull the old stuff back in.

Yup, this is the big problem with VM ;)

> The way I'd like to address that is with a "I know that's cool but I
> don't like it" policy override knob.  But finding a sensible way of
> doing that is taking some head-scratching.  Anything which says
> "unmap pages much later" is doomed to failure I suspect.  It will
> just increase latency when we really _do_ need to unmap, and will
> cause weird OOM failures.

FreeBSD fixes this in a fairly simple way.  It has a sysctl
switch (vm_defer_pageouts IIRC) that can be toggled on and
off.

If the switch is off, the VM only reclaims swap backed pages
if memory is really low and doesn't if it can keep enough
free memory by only reclaiming file backed pages.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

