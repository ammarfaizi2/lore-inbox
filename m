Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTHRMAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271418AbTHRMAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:00:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56704 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271414AbTHRMA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:00:28 -0400
Date: Mon, 18 Aug 2003 12:59:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818115954.GA7147@mail.jlokier.co.uk>
References: <20030818004313.T3708@schatzie.adilger.int> <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> > It wasn't even vanishingly small...  We had a problem in our code where
> > two readers got the same 64-bit value calling get_random_bytes(), and
> > we were depending on this 64-bit value being unique.  This problem was
> > fixed by putting a spinlock around the call to get_random_bytes().
> 
> if the number is truely random then there should be a (small but finite)
> chance that any two reads will return the same data. counting on a random
> number to be unique is not a good idea.

The whole field of modern cryptography is based on things with a small
but finite chance of failure.  The point is to mathematically engineer
that chance to be _vanishingly_ small, such as probabilities like 2^-256.

When the "random" number is 64 bits wide, the probability is so small
that if you _do_ see two numbers the same you should be very
suspicious.  But it is not so small to be out of the question.

When you fetch 128 bits or more and see two numbers the same, then you
should be very suspicious indeed.  But even that is not out of the
question if you have many machines generating numbers night and day.

At 256 bits, there is a real fault in your random number generator if
you manage to generate two numbers the same.

> now if you can repeatably get the same number then you probably have a bug
> in the random number code, but if you need uniqueness you need something
> else.

Can you think of another, reliable, source of uniqueness?

-- Jamie
