Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUJ0BJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUJ0BJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUJ0BJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:09:50 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:63375 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261436AbUJ0BJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:09:48 -0400
Date: Wed, 27 Oct 2004 03:10:43 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027011043.GQ14325@dualathlon.random>
References: <20041027005425.GO14325@dualathlon.random> <Pine.LNX.4.44.0410262059020.21548-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410262059020.21548-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:00:11PM -0400, Rik van Riel wrote:
> However, doesn't the protection also serve a purpose for
> NUMA fallback ?  How is that handled by your code ?

It doesn't.

The only reason any NUMA folk were interested in this stuff was to nuke
the incremental min weak band-aid that Linus introduced in 2.4 while
rejecting my real lowmem_reserve algorithm (that has been reinvented in
2.6.5 first and against 2.6.7 with the name of protection but still
buggy and disabled by default, so not very useful.., especially after
even the incremental-min was gone from 2.6.8+).

NUMA folks only want to nuke the incremental-min hack since that
escalated to huge waste of ram on the hundred nodes.

the major point of the rework in the protection algorithm happened
between 2.6.5 and 2.6.8 was to drop any NUMA effect from the algorithm
that guarantees DMA allocations on x86-64 and NORMAL allocations on x86
PAE. So being it unrelated to NUMA is a feature as far as I can tell.
