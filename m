Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULEAlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULEAlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbULEAlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:41:55 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:56758 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261210AbULEAlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:41:52 -0500
Date: Sun, 5 Dec 2004 01:40:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041205004049.GF13244@dualathlon.random>
References: <20041130180337.GT4365@dualathlon.random> <E1Cajei-00040t-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cajei-00040t-00@mta1.cl.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 11:49:32PM +0000, Ian Pratt wrote:
> So, do we think the best /dev/mem patch is to change the call to
> io_remap_page_range, and have a #ifdef for the SPARC case until
> the number of arguments gets unified?

Yes from my part ;). It looks more correct than calling
io_remap_page_range under an #ifdef CONFIG_XEN. One thing I don't know
is why for example sparc isn't already doing that (like XEN is already
doing that with your patch).  Sparc and XEN are the only two archs where
io_remap_page_range isn't an alias to remap_pfn/page_range. It's much
nicer if we use io_remap_page_range in the same places for both sparc
and XEN. Though to get the final answer we should ask the sparc folks.
