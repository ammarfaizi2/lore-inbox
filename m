Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTDUWLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDUWLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:11:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262228AbTDUWLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:11:38 -0400
Date: Mon, 21 Apr 2003 15:23:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
In-Reply-To: <20030421221146.GA14283@averell>
Message-ID: <Pine.LNX.4.44.0304211514200.17938-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Andi Kleen wrote:
> 
> At least on Athlon/Opteron these sequences are the fastest because they are
> special cased in the decoder and do not consume any execution resources.  

Is that true even on the 32-bit Athlons, especially the older ones?

I can understand the special-casing on Opteron, since in 64-bit mode
you'll see more of the prefixes, but for older K7s?

> On the P4 it also shouldn't matter because it has the trace cache that 
> hides decoding issues.  Same on Transmeta, right?

Yes, decoding is not usually an issue on a trace-cache-driven thing, 
either P4 or Transmeta.

> I guess it'll do well on P3.

I think the P3 (which is still Intel's "current" offering as it comes to 
the mobile Pentium-M side) has problems. And there are still people who 
use even older chips.

Of course, for _this_ particular case (ie sfence/mfence) older chips do 
not matter, as they'll fall back on the longer sequence and never see the 
no-ops, but we may have other replacements where it goes the other way and 
it's the _new_ sequence that is shorter.

> I'm using the GAS sequences for the Intel case Ulrich pointed out now,
> but only upto 4 bytes (memory barrier only needs 3 bytes currently). 
> This will hopefully satisfy all nop optimizers ;)

Looks good to me.

I do have _one_ more small niggling issue - I think this patch also makes
the CONFIG_X86_SSE2 define be a thing of the past. Or is it used for
something else still? It would be good to remove it, and try to make most
of the architecture choices be pure optimization hints (apart from some of
the more painful architecture updates like the broken write protect on the
original 386). That will make it easier for distribution makers.

		Linus "picky, picky" Torvalds

