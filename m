Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTJNKUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJNKUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:20:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:47759 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262241AbTJNKUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:20:49 -0400
Date: Tue, 14 Oct 2003 11:18:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Piet Delaney <piet@www.piet.net>, George Anzinger <george@mvista.com>,
       Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
Message-ID: <20031014101853.GA28905@mail.shareable.org>
References: <20031006161733.24441.qmail@email.com> <3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net> <20031014094655.GC24812@mail.shareable.org> <3F8BCAB3.2070609@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BCAB3.2070609@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> I don't know anything about it, but I don't see what exactly you'd be
> trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
> obviously. Also, "best use of system resources" wrt scheduling is a big
> ask considering there isn't one ideal scheduling pattern for all but the
> most trivial loads, even on a single processor computer (fairness, latency,
> priority, thoughput, etc). Its difficult to even say one pattern is better
> than another.

Hmm.  Prediction is potentially useful.

Instead of an educated ad-hoc pile of heuristics for _dictating_
scheduling behaviour, you can systematically analyse just what is it
you're trying to achieve, and design a behaviour which achieves that
as closely as possible.

This is where good predictors come in: you feed all the possible
scheduling decisions at any point in time into the predictor, and use
the output to decide which decision gave the most desired result -
taking into account the likelihood of future behaviours.  Of course
you have to optimise this calculation.

This is classical control theory.  In practice it comes up with
something like what we have already :)  But the design path is
different, and if you're very thoroughly analytical about it, maybe
there's a chance of avoiding weird corner behaviours that weren't
intended.

The down side is that crafted heuristics, like the ones we have, tend
to run a _lot_ faster.

-- Jamie
