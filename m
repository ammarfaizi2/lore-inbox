Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHBPls>; Fri, 2 Aug 2002 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHBPls>; Fri, 2 Aug 2002 11:41:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28177 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315278AbSHBPlr>; Fri, 2 Aug 2002 11:41:47 -0400
Date: Fri, 2 Aug 2002 08:46:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <davidm@napali.hpl.hp.com>
Subject: Re: adjust prefetch in free_one_pgd()
In-Reply-To: <15690.42924.410428.28956@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, David Mosberger wrote:
>
> I thought the prefetches API intended this to be a safe operation?

Well, any _sane_ prefetch API would be safe.

However, there is known-broken hardware out there, in which a prefetch
from IO space will kill the machine.

Personally, I would just say that we should disable prefetch on such
clearly broken hardware, but since it's Alans favourite machine (some
early AMD Athlon if I remember correctly), I think Alan will disagree ;)

> It's definitely not an issue on ia64: there, prefetches against
> uncached memory translations are automatically canceled.

That's true of just about any other architecture too. I think the AMD case
is an erratum, so even on AMD it is _supposed_ to work.

			Linus

