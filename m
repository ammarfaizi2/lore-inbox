Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVAWDMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVAWDMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVAWDMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:12:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:12747 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261192AbVAWDMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:12:34 -0500
Date: Sun, 23 Jan 2005 04:02:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andi Kleen <ak@muc.de>
Cc: Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
In-Reply-To: <m1r7kc27ix.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de>
 <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
 <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005, Andi Kleen wrote:

> Felipe Alfaro Solana <lkml@mac.com> writes:
> >
> > AFAIK, XOR is quite expensive on IA32 when compared to simple MOV
> > operatings. Also, since the original patch uses 3 MOVs to perform the
> > swapping, and your version uses 3 XOR operations, I don't see any
> > gains.
> 
> Both are one cycle latency for register<->register on all x86 cores
> I've looked at. What makes you think differently?
> 
> -Andi (who thinks the glibc qsort is vast overkill for kernel purposes
> where there are only small data sets and it would be better to use a 
> simpler one optimized for code size)
> 
How about a shell sort?  if the data is mostly sorted shell sort beats 
qsort lots of times, and since the data sets are often small in-kernel, 
shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
faster if the data is already completely sorted. Shell sort is certainly 
not the simplest algorithm around, but I think (without having done any 
tests) that it would probably do pretty well for in-kernel use... Then 
again, I've known to be wrong :)


-- 
Jesper Juhl

