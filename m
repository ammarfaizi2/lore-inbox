Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUCOOti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCOOti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:49:38 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64777
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262587AbUCOOth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:49:37 -0500
Date: Mon, 15 Mar 2004 15:50:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315145020.GC30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4055BF90.5030806@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:37:04AM +1100, Nick Piggin wrote:
> This case I think is well worth the unfairness it causes, because it
> means your zone's pages can be freed quickly and without freeing pages
> from other zones.

freeing pages from other zones is perfectly fine, the classzone design
gets it right, you have to free memory from the other zones too or you
have no way to work on a 1G machine. you call the thing "unfair" when it
has nothing to do with fariness, your unfariness is the slowdown I
pointed out, it's all about being able to maintain a more reliable cache
information from the point of view of the pagecache users (the pagecache
users cares at the _classzone_, they can't care about the zones
themself), it has nothing to do with fairness.
