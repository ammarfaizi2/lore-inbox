Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271205AbTHRDYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 23:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271206AbTHRDYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 23:24:40 -0400
Received: from thunk.org ([140.239.227.29]:29610 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S271205AbTHRDYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 23:24:38 -0400
Date: Sun, 17 Aug 2003 23:23:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818032348.GA9456@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>,
	James Morris <jmorris@intercode.com.au>,
	Jamie Lokier <jamie@shareable.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815235501.GB325@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 06:55:01PM -0500, Matt Mackall wrote:
> I posted a proof of concept patch for discussion on $SUBJECT. In that
> patch, I removed the folding for the purposes of having a reasonable
> comparison between cryptoapi and native. Cryptoapi does FIPS-180-1 and
> thus does twice as much hashing on 512 bits. 

It would be nice if there was a Crypto API algorithm variant which
didn't do the FIPS-180-1 padding, for those applications (like
/dev/random) that don't need it.

> Removing the folding was a convenient and obvious way of addressing
> it for the purposes of discussing $SUBECT until a good way to work
> around the extra padding was found. I've already indicated my
> willingness to accept your
> SHA-may-be-backdoored-and-somehow-leverageable argument, so can we
> kindly discuss $SUBJECT instead of this trivia?

Multiple arguments were made for dropping the folding, not just as a
"temporary measure".  You were the one that made the excuse of "cat
/dev/urandom > /dev/hda1", not me...

> As for "screwing with /dev/random", it's got rather more serious and
> longstanding problems than speed that I've been addressing. For
> instance, I'm pretty sure there was never a time when entropy
> accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> you). Nor has there ever been a time when change_poolsize() wasn't an
> oops waiting to happen (patch queued for resend).

Agreed, fixing the locking is much more important than CryptoAPI
changes.  Can you send me a pointer to your latest locking patches?
I'd like to look them over.  Thanks!!

							- Ted
