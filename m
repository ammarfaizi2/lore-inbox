Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBDBUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBDBUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbVBDBUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:20:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45746 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261838AbVBDBAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:00:11 -0500
Date: Thu, 3 Feb 2005 16:59:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Paul Mackerras <paulus@samba.org>
cc: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <16898.46622.108835.631425@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
 <20050202163110.GB23132@logos.cnet> <Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
 <16898.46622.108835.631425@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Paul Mackerras wrote:

> On my G5 it takes ~200 cycles to zero a whole page.  In other words it
> takes about the same time to zero a page as to bring in a single cache
> line from memory.  (PPC has an instruction to establish a whole cache
> line of zeroes in modified state without reading anything from
> memory.)
>
> Thus I can't see how prezeroing can ever be a win on ppc64.

You need to think about this in a different way. Prezeroing only makes
sense if it can avoid using cache lines that the zeroing in the
hot paths would have to use since it touches all cachelines on
the page (the ppc instruction is certainly nice and avoids a cacheline
read but it still uses a cacheline!). The zeroing in itself (within the
cpu caches) is extraordinarily fast and the zeroing of large portions of
memory is so too. That is why the impact of scrubd is negligible since
its extremely fast.

The point is to save activating cachelines not the time zeroing in itself
takes. This only works if only parts of the page are needed immediately
after the page fault. All of that has been documented in earlier posts on
the subject.
