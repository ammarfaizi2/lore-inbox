Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVAFFVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVAFFVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVAFFVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:21:34 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58692
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262733AbVAFFVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:21:24 -0500
Date: Thu, 6 Jan 2005 06:21:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106052135.GQ4597@dualathlon.random>
References: <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <41DCC75A.2050800@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCC75A.2050800@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:06:34PM +1100, Nick Piggin wrote:
> Yeah I guess that isn't a bad idea.
> 
> Doesn't that have the theoretical problem of slowing down reclaim
> of dirty pages backed by fast devices when you have slow devices
> writing?

Andrew just suggested to wait on any random page. That's a minor
modification to that logic. Effectively it's stupid to wait on a
specific random page, when we can wait wait on _any_ random page to
complete the writeback I/O.

With locking done right by setting the state to uninterruptible and
then registering in the new waitqueue when we know at least one page has
PG_writeback set, we can then drop the HZ anti-deadlock hacks too.
