Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVAFE0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVAFE0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 23:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVAFE0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 23:26:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:41600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262715AbVAFE0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 23:26:37 -0500
Date: Wed, 5 Jan 2005 20:26:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: riel@redhat.com, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105202611.65eb82cf.akpm@osdl.org>
In-Reply-To: <41DCB577.9000205@yahoo.com.au>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
	<20050105020859.3192a298.akpm@osdl.org>
	<20050105180651.GD4597@dualathlon.random>
	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
	<20050105174934.GC15739@logos.cnet>
	<20050105134457.03aca488.akpm@osdl.org>
	<20050105203217.GB17265@logos.cnet>
	<41DC7D86.8050609@yahoo.com.au>
	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
	<20050105173624.5c3189b9.akpm@osdl.org>
	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
	<41DCB577.9000205@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > 
> > I suspect something might still be broken.  It may take a few
> > days of continuous testing to trigger the bug, though ...
> > 
> 
> It is possible to be those blk_congestion_wait paths, because
> the queue simply won't be congested. So doing io_schedule_timeout
> might help.

If the queue is not congested, blk_congestion_wait() will still sleep.  See
freed_request().

> I wonder if reducing the size of the write queue in CFQ would help
> too? IIRC, it only really wants a huge read queue.

Surely it will help - but we need to be able to handle the situation
because memory can still become full of PageWriteback pages if there are
many disks.
