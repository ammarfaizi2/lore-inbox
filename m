Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTHMD0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271355AbTHMD0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:26:44 -0400
Received: from thunk.org ([140.239.227.29]:19085 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S271353AbTHMD0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:26:41 -0400
Date: Tue, 12 Aug 2003 23:20:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030813032038.GA1244@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>,
	James Morris <jmorris@intercode.com.au>,
	Jamie Lokier <jamie@shareable.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810174528.GZ31810@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 12:45:28PM -0500, Matt Mackall wrote:
> I suppose the comment you deleted was a little light on details, sigh.
> 
> The idea with the folding was that we can cover up any systemic
> patterns in the returned hash by xoring the first half of the hash
> with the second half of the hash. While this might seem like a good
> technique intuitively, it's mathematically flawed.

No, that's not why the folding was done.  You could have asked me
first....

First of all, I wasn't worried about simple correlations.  There are
enough statistical tests done that we don't need to worry about xor
causing problems.

The real issue is discarding information.  By folding, we hide
information about the output of the SHA hash that will hopefully deny
information that a Very Sophisticated Attacker (say, at the level of a
certain agency that designed the SHA algorithm) that might make it
easier for them to attack the SHA algorithm.

> just x. With the former, every bit of input goes through SHA1 twice,
> once in the input pool, and once in the output pool, along with lots
> of feedback to foil backtracking attacks. In the latter, every output
> bit is going through SHA four times, which is just overkill. 

Speed really doesn't matter here.  /dev/random is supposed to produce
somethign which is close to true randomness, not crypto
psuedo-randomness.  So overkill is a good thing.  It should only be
used for generating long-term keys, so speed is really not a concern. 

						- Ted
