Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVAXVye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVAXVye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVAXVwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:52:46 -0500
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:19848 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261606AbVAXVut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:50:49 -0500
Date: Mon, 24 Jan 2005 13:50:45 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: Matt Mackall <mpm@selenic.com>
cc: Felipe Alfaro Solana <lkml@mac.com>, Andi Kleen <ak@muc.de>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Buck Huppmann <buchk@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
In-Reply-To: <20050124212037.GJ3867@waste.org>
Message-ID: <Pine.LNX.4.58.0501241342460.30376@shell1.speakeasy.net>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de>
 <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
 <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
 <5ADB1D78-6CFB-11D9-86B4-000D9352858E@mac.com> <20050124212037.GJ3867@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Matt Mackall wrote:

> On Sun, Jan 23, 2005 at 05:58:00AM +0100, Felipe Alfaro Solana wrote:
> > On 23 Jan 2005, at 03:39, Andi Kleen wrote:
> >
> > >Felipe Alfaro Solana <lkml@mac.com> writes:
> > >>
> > >>AFAIK, XOR is quite expensive on IA32 when compared to simple MOV
> > >>operatings. Also, since the original patch uses 3 MOVs to perform the
> > >>swapping, and your version uses 3 XOR operations, I don't see any
> > >>gains.
> > >
> > >Both are one cycle latency for register<->register on all x86 cores
> > >I've looked at. What makes you think differently?
> >
> > I thought XOR was more expensie. Anyways, I still don't see any
> > advantage in replacing 3 MOVs with 3 XORs.
>
> Again, no temporaries needed.
>
> But I benched it and it was quite a bit slower.
>
> --
> Mathematics is the supreme nostalgia of our time.

Yep, it's a difference of four instructions (when using one or two
temporary variables and swapping using assignments) versus six
instructions (when using xors, since IA32 can't do an xor with both
arguments in memory).

I originally pitched this idea out to the list just for discussion
purposes. Most considered it, and said that the advantages don't
outweigh the disadvantages. And that's fine -- it means that the chosen
way is that much better considered. Always a good thing. :)

-Vadim Lobanov

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
