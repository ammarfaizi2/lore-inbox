Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVABI7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVABI7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 03:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVABI7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 03:59:11 -0500
Received: from canuck.infradead.org ([205.233.218.70]:18447 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261244AbVABI7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 03:59:07 -0500
Subject: Re: 2.5isms
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <41D743BE.3060207@yahoo.com.au>
References: <20041231230624.GA29411@andromeda>
	 <41D60C35.9000503@yahoo.com.au> <m1acrt7bqy.fsf@muc.de>
	 <41D743BE.3060207@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 02 Jan 2005 09:58:59 +0100
Message-Id: <1104656340.4185.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I'm curious about a couple of points though. First, is that it is basically
> just adding a cache colouring to the stack, right? In that case why do only
> older HT CPUs have bad performance without it? And wouldn't it possibly make
> even non HT CPUs possibly slightly more efficient WRT caching the stacks of
> multiple processes?

it's a win on more than older HT cpus. It's just that those suffer it
the most... (since there you have 2 "cpus" share the cache, meaning you
get double the aliasing)


> Second, on what workloads does performance suffer, can you remember? I wonder
> if natural variations in the stack pointer as the program runs would mitigate
> the effect of this on all but micro benchmarks?

one of the problem cases I remember is network daemons all waiting in
accept() for connections. All from the same codepath basically.
Randomizing the stackpointer is a gain for that on all cpus that have
finite affinity on their caches.


> But even if that were so so, it seems simple enough that I don't have any
> real problem with keeping it of course.

The reason my patch does it much more is that it makes it a step harder
to write exploits for stack buffer overflows. 

