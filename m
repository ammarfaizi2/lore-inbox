Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUI0PVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUI0PVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUI0PVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:21:07 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:56772 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S266362AbUI0PVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:21:00 -0400
Date: Mon, 27 Sep 2004 11:19:48 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040927151948.GK28317@certainkey.com>
References: <20040923234340.GF28317@certainkey.com> <20040927045828.GA13887@thunk.org> <20040927133203.GF28317@certainkey.com> <20040927145555.GB15589@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927145555.GB15589@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

My re-writing wilol appear as more like an editorial revision than a
re-write.

I will certainly talk to Jamal et al.  Thanks

JLC

On Mon, Sep 27, 2004 at 10:55:55AM -0400, Theodore Ts'o wrote:
> On Mon, Sep 27, 2004 at 09:32:03AM -0400, Jean-Luc Cooke wrote:
> > 
> > I'll read over this once I finish re-writing my patch to use your entropy
> > estimation.
> 
> While you're at it, please re-read RFC 793 and RFC 1185.  You still
> don't have TCP sequence generation done right.  The global counter
> is being increased for every TCP connection, and with only eight bits,
> it can wrap very frequently.  Encrypting the source/destination
> address/port tuple and using that as an offset to the global clock,
> and then only bumping the counter when you rekey would be much more in
> the spirit of RFC 1185, and would result in sequence numbers much less
> likely to cause stale packets to get mistakenly accepted.
> 
> I'm still a bit concerned about whether doing AES is going to be a
> speed issue.  Your comparisons against MD4 using openssl don't really
> prove much, because (a) the original code used a cut-down MD4, and (b)
> the openssl benchmark does a large number of encryptions and nothing
> else, so all of the AES key schedule and tables will be in cache. 
> 
> The only real way to settle this would be to ask Jamal and some of the
> other networking hackers to repeat their benchmarks and see if the AES
> encryption for every TCP SYN is a problem or not.  CPU's have gotten
> faster (but then again so have networks, and memory has *not* gotten
> much faster), so only a real benchmark will tell us for sure.
> 
> 					- Ted
