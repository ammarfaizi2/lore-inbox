Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSHCVCO>; Sat, 3 Aug 2002 17:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSHCVCO>; Sat, 3 Aug 2002 17:02:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20996 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317779AbSHCVCG>; Sat, 3 Aug 2002 17:02:06 -0400
Date: Sat, 3 Aug 2002 18:05:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <3D4B692B.46817AD0@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208031803050.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Andrew Morton wrote:

> No joy, I'm afraid.

> Guess we should instrument it up and make sure that the hashing
> and index thing is getting the right locality.

Could it be that your quad needs to go to RAM to grab a cacheline
that's exclusive on the other CPU while Daniel's machine can just
shove cachelines from CPU to CPU ?

What I'm referring to is the fact that the pte_chain_locks in
Daniel's patch are all packed into a few cachelines, instead of
having each lock on its own cache line...

This could explain the fact that the locking overhead plummeted
on Daniel's box while it didn't change at all on your machine.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

