Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTBTNL6>; Thu, 20 Feb 2003 08:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBTNL5>; Thu, 20 Feb 2003 08:11:57 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:48552 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265890AbTBTNLy>; Thu, 20 Feb 2003 08:11:54 -0500
Date: Thu, 20 Feb 2003 10:21:50 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
In-Reply-To: <20030220124833.GB4051@lilith.homenet>
Message-ID: <Pine.LNX.4.50L.0302201019250.2329-100000@imladris.surriel.com>
References: <20030219171432.A6059@smp.colors.kwc>
 <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com>
 <20030220124833.GB4051@lilith.homenet>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Dejan Muhamedagic wrote:

> > echo 1 10 > /proc/sys/vm/pagecache
>
> Will that work with rmap15d?  The code seems to support only min
> and borrow parameters.

Indeed, only min and borrow are currently supported.

>  Correct me if I'm wrong.  This is what it looks like currently:
>
> # cat /proc/sys/vm/pagecache
> 1       3       20
> # mem | grep Cache
> Cached:        4569128 kB
> SwapCached:     829668 kB
> ActiveCache:    136728 kB

The "problem" here is that a lot of the memory in Cached: is
mapped into process address space, so in effect it is process
memory.

This is especially true for executables, libraries and shared
memory segments, which you REALLY want to have treated as process
memory and not as cache...

This makes the Cached statistic a bit confusing for administrators.

> > In that case you're probably familiar with the cache size
> > tuning, since AIX has the exact same tuning knob as rmap ;)
>
> AIX vmtune -P is equivalent to the Linux cache-max, but cache-max
> is not implemented.

Doesn't it also have something like the borrow percentage, above
which AIX will only reclaim from the cache, unless the repaging
rate of the cache is higher than that of process memory ?

regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
