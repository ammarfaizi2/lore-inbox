Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVL1PiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVL1PiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVL1PiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:38:00 -0500
Received: from waste.org ([64.81.244.121]:33199 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964842AbVL1Ph7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:37:59 -0500
Date: Wed, 28 Dec 2005 09:34:30 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228153430.GO3356@waste.org>
References: <20051228114701.GC3003@elte.hu> <p734q4tb5na.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734q4tb5na.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 04:30:49PM +0100, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > allow gcc4 compilers to optimize unit-at-a-time - which results in gcc
> > having a wider scope when optimizing. This also results in smaller code
> > when optimizing for size. (gcc4 does not have the stack footprint
> > problem of gcc3 compilers.)
> 
> I never had any trouble with stack footprint even with gcc 3.3 on x86-64
> and unit-at-a-time and it was always enabled. 

The particular offenders I remember were in lib/inflate.c running over
4K well before 4K stacks were in mainline, so I fixed it well before
anyone else got to see it.
 
> But one caveat: turning on unit-at-a-time makes objdump -S / make
> foo/bar.lst with CONFIG_DEBUG_INFO essentially useless because objdump
> cannot deal with functions being out of order in the object file. This
> can be a big problem while analyzing oopses - essentially you have
> to analyze the functions without source level information. And with
> unit-at-a-time they become bigger so it's more difficult.

Yeah, and it also makes stuff like bloat-o-meter output go all to hell.
 
> But I still think it's a good idea.

Indeed.

-- 
Mathematics is the supreme nostalgia of our time.
