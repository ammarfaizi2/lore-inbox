Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVBCDHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVBCDHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVBCDHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:07:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19095 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262790AbVBCDG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:06:59 -0500
Date: Wed, 2 Feb 2005 22:06:20 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Christoph Lameter <clameter@sgi.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <20050202163110.GB23132@logos.cnet>
Message-ID: <Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
 <20050202163110.GB23132@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Marcelo Tosatti wrote:

> Someone should try implementing the zeroing driver for a fast x86 PCI 
> device. :)

I'm not convinced.  Zeroing a page takes 2000-4000 CPU
cycles, while faulting the page from RAM into cache takes
200-400 CPU cycles per cache line, or 6000-12000 CPU
cycles.

If the page is being used immediately after it is
allocated, it may be faster to prezero the page on
the fly.  On some CPUs these writes bypass the "read
from RAM" stage and allow things to just live in cache
completely.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
