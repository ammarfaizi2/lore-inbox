Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTIPPQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbTIPPQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:16:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52241 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261901AbTIPPQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:16:12 -0400
Date: Tue, 16 Sep 2003 11:06:49 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <3F65B2BD.9000206@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1030916095944.26515D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Nick Piggin wrote:

> 
> 
> John Bradford wrote:

> I guess more specialised users would be able to edit the cache line
> size themselves. I wouldn't be adverse to a kconfig setting under the
> embedded menu though.

Clearly something which might be useful for some embedded CPUs.

> I can see an argument for cache line size but thats about it. I can't
> think of my optimisations that should be done on one architecture but
> not another.

Well, if you meant "any optimizations" there are lots, and they already
have config entries. Ex: F.P. emulation, RZ1000 fixups, etc.

> No I definitely agree. Except sometimes you'll have to check at runtime:
> a kernel compiled for all cpus for example needs Andi's Athlon prefetch
> scheme. You'd really want some good helpers to either do runtime check
> or always, or never. Something like this optimises down OK if cpu and
> archmask are constant.
> 
> static inline void ifcpu(const int cpumask, void (*func)(void))
> {
>         if ((cpumask&archmask) && ((~cpumask)&archmask)) {
>                 if (cpumask&current_cpu)
>                         func();
>         } else if (cpumask&archmask) {
>                 func();
>         }
> }
>
> ifcpu(K7||K8, &prefetch_workaround);
> 
> You then need to get kconfig to generate cpu and archmask nicely.
> You obviously still need to ifdef your prefetch_workaround to get the
> space saving.

True, there's no way to get a minimal kernel without at least some
ifdef'iness, although if you defined the code as an inline function and
used your code above... a matter of style, a few preprocessor lines in
that much code aren't going to be confusing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

