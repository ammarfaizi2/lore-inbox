Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317871AbSGVWGL>; Mon, 22 Jul 2002 18:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSGVWGK>; Mon, 22 Jul 2002 18:06:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45578 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317867AbSGVWGJ>; Mon, 22 Jul 2002 18:06:09 -0400
Date: Mon, 22 Jul 2002 19:08:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Rick Parada <rick@bizrate.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rik Van Riel Patch - rmap-12h - Memory Issues - VM
In-Reply-To: <NEBBKPCLBMALOLFGJEJGOEEGHEAA.rick@bizrate.com>
Message-ID: <Pine.LNX.4.44L.0207221904320.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Rick Parada wrote:

> After 11 days of uptime your patch is working GREAT. Although cache is
> filled up again and there is only 70 megs free of memory top is
> reporting. I assume that this is just normal behavior. When rsync runs,
> memory from buff is free allowing rsync the memory to run seamless.

Yes, the cache is allowed to take all memory in the system, but
when something needs to run the memory will be reclaimed.

Of course it's also possible that program memory will be swapped
out instead of reclaiming from the cache, but the way rmap is
balanced means that the system is more likely to swap out cache
memory .. unless the memory from the cache is heavily accessed.

> And I notice that the kswapd time that top is reporting is far less than
> say the 2.4.18 kernel vanilla or 2.4.8 vanilla (two other boxes with the
> same configurations). Why is this?

Kswapd removes the right pages from RAM, that is: pages that will
not be used again soon (most likely).  This also means it doesn't
need to read those pages in again from disk and the VM is less
busy as a result.

It also changes some data structures inside the kernel to remove
some of the complexity in chosing which page to evict from RAM,
meaning that it can choose the right page to evict with less CPU
usage.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

