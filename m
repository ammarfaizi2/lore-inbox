Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVAWEae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVAWEae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVAWEaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:30:21 -0500
Received: from waste.org ([216.27.176.166]:63380 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261212AbVAWE3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:29:54 -0500
Date: Sat, 22 Jan 2005 20:29:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@muc.de>
Cc: Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123042930.GI3867@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r7kc27ix.fsf@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 03:39:34AM +0100, Andi Kleen wrote:
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

Mostly agreed. Except:

a) the glibc version is not actually all that optimized
b) it's nice that it's not recursive
c) the three-way median selection does help avoid worst-case O(n^2)
behavior, which might potentially be triggerable by users in places
like XFS where this is used

I'll probably whip up a simpler version tomorrow or Monday and do some
size/space benchmarking. I've been meaning to contribute a qsort for
doubly-linked lists I've got lying around as well.

-- 
Mathematics is the supreme nostalgia of our time.
