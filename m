Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUIWQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUIWQDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIWQDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:03:51 -0400
Received: from denise.shiny.it ([194.20.232.1]:968 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S266344AbUIWQDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:03:24 -0400
Date: Thu, 23 Sep 2004 18:03:18 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit
 32byte cacheline]
In-Reply-To: <20040923141157.GA12367@logos.cnet>
Message-ID: <Pine.LNX.4.58.0409231755150.32673@denise.shiny.it>
References: <20040923141157.GA12367@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Sep 2004, Marcelo Tosatti wrote:

> Forgot to CC linux-kernel, just in case someone else
> can have useful information on this matter.
>
> Andi says any additional overhead will be in the noise
> compared to cacheline saving benefit.
>
> ***********
>
> Within the Linux kernel we can benefit from changing some fields
> of commonly accessed data structures to 16 bit instead of 32 bits,
> given that the values for these fields never reach 2 ^ 16.
>
> Arjan warned me, however, that the prefix (in this case "data16") will
> cause an additional extra cycle in instruction decoding, per message above.
>
> Can you confirm that please? We can't seem to be able to find
> it in Intel's documentation.
>
> By shrinking two fields of "per_cpu_pages" structure we can fit it
> in one 32-byte cacheline (<= Pentium III and probably several other
> embedded/whatnot architectures will benefit from such a change).

One cycle is a small overhead compared to the cost of a fetch from L2
cache or, even worse, a cache miss. Memory is terribly slow. I think that
nowadays we should design things trying to keep memory accesses as few as
possible.


--
Giuliano.
