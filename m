Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVAFFDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVAFFDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVAFFDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:03:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50754
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262725AbVAFFD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:03:27 -0500
Date: Thu, 6 Jan 2005 06:03:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106050339.GO4597@dualathlon.random>
References: <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCC4C6.8000205@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:55:34PM +1100, Nick Piggin wrote:
> However, if you had a plain io_schedule_timeout there, at least you
> would sleep for the full extend of the specified timeout.

I agree it sure would be safer but OTOH it may screwup performance by
waiting for unnecessary long times on fast stroage.

So it's ok for a test, but still it wouldn't be a final fix since the
timeout may be still too short in some case.

Waiting on one (or more) PG_writeback bitflags to go away should fix it
completely. This is how 2.4 throttles on the writeback I/O too of
course. How we choose which random page to pick may vary though.
