Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275980AbTHOMt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275985AbTHOMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:49:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30849 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275980AbTHOMtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:49:12 -0400
Date: Fri, 15 Aug 2003 13:48:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Val Henson <val@nmt.edu>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815124857.GD15911@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815001713.GD5333@speare5-1-14>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson wrote:
> See Matt Mackall's earlier post on correlation, excerpted at the end
> of this message.  Basically, with two strings x and y, the entropy of
> x alone or y alone is always greater than or equal to the entropy of x
> xored with y.
> 
> entropy(x) >= entropy(x xor y)
> entropy(y) >= entropy(x xor y)

No.

Let x have zero entropy, i.e. a known value.
Let y be random, i.e. entropy(y) == bits(y), and non-empty, i.e. bits(y) > 0.

Then,
   entropy(x xor y) == entropy(y)

=> entropy(x) < entropy(x xor y)

In general, either condition is possible depending on the relationship
between x and y.

Entropy vs. information hiding
==============================

For our purpose, maximising entropy in F or G is one goal, to ensure
each output bit is maximally independent, but another goal is
preventing knowledge of the pool state, and that's a _different_ goal.

Reducing entropy in the output actually makes acquiring knowledge of
the pool state _more difficult_.

This is because the amount of information you can deduce about the
pool state is limited by (a) the output entropy and (b) the strength
of the hash function.

To xor or not to xor
====================

For an attacker unable to break SHA, F or G are equally unbreakable.
For an attacker who knows a weakness in SHA, then whether F or G is
stronger depends entirely on the nature of that weakness.  It could
even be that F is stronger against one attacker and G is stronger
against a different one.

Which begs the question, why throw away 50% of the bits?  Why not 25%,
or 75%?  The choice is arbitrary and not based on any known (perhaps
not knowable) properties of the hash function.  We are speculating
about weaknesses, yet cannot know which weaknesses to protect against.

-- Jamie
