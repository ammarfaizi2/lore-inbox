Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVAFFY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVAFFY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVAFFY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:24:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19781
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262732AbVAFFY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:24:56 -0500
Date: Thu, 6 Jan 2005 06:25:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106052507.GR4597@dualathlon.random>
References: <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCCA68.3020100@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:19:36PM +1100, Nick Piggin wrote:
> This is practically what blk_congestion_wait does when the queue
> isn't congested though, isn't it?

The fundamental difference that makes it reliable is that:

1) only the I/O we're throttling against will be considered for the
   wakeup event, which means only clearing PG_writeback will be
   considered eligible for wakeup
   Currently _all_ unrelated write I/O was considered eligible
   for wakeup events and that could cause spurious oom kills.
2) we won't need unreliable anti-deadlock timeouts anymore
