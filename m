Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVAFFqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVAFFqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAFFqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:46:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57159
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262741AbVAFFqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:46:48 -0500
Date: Thu, 6 Jan 2005 06:46:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106054659.GS4597@dualathlon.random>
References: <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au> <20050105213207.721b1aae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105213207.721b1aae.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 09:32:07PM -0800, Andrew Morton wrote:
> > > The slight improvement you suggested of waiting on _any_ random
> > > PG_writeback to go away (instead of one particular one as I did in 2.4)
> 
> It's a HUGE improvement.

I didn't want to question the improvement in wall clock time terms.

> For the third time: "fixing" this involves delivering a wakeup to all zones
> in the page's classzone in end_page_writeback(), and passing the zone* into
> blk_congestion_wait().  Only deliver the wakeup on every Nth page to get a
> bit of batching and to reduce CPU consumption.  Then demonstrating that the
> change actually improves something.

Since I cannot reproduce oom kills with writeback, I sure can't
demonstrate it on bare hardware with unmodified kernel.

But I dislike code that works by luck, and sure I could demonstrate it
if I bothered to write an artificial testcase on simulated hardware.
This is the only reason I mentioned this bug in the first place, not
because I'm reproducing it.
