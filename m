Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272464AbTHOX4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272469AbTHOX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:56:03 -0400
Received: from waste.org ([209.173.204.2]:55439 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272464AbTHOXzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:55:20 -0400
Date: Fri, 15 Aug 2003 18:55:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815235501.GB325@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815221211.GA4306@think>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 06:12:11PM -0400, Theodore Ts'o wrote:

> However, if people insist on doing silly things like "cat
> /dev/urandom > /dev/hda", and worse yet, screwing with the
> /dev/random and /dev/urandom with the excuse that speed is of
> importance, then perhaps following OpenBSD and implementing
> /dev/frandom is a better choice.

Sigh..

I posted a proof of concept patch for discussion on $SUBJECT. In that
patch, I removed the folding for the purposes of having a reasonable
comparison between cryptoapi and native. Cryptoapi does FIPS-180-1 and
thus does twice as much hashing on 512 bits. Removing the folding was
a convenient and obvious way of addressing it for the purposes of
discussing $SUBECT until a good way to work around the extra padding
was found. I've already indicated my willingness to accept your
SHA-may-be-backdoored-and-somehow-leverageable argument, so can we
kindly discuss $SUBJECT instead of this trivia?

As for "screwing with /dev/random", it's got rather more serious and
longstanding problems than speed that I've been addressing. For
instance, I'm pretty sure there was never a time when entropy
accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
you). Nor has there ever been a time when change_poolsize() wasn't an
oops waiting to happen (patch queued for resend).

And frankly, given that my local version of /dev/urandom does 18MB/s
without starving /dev/random, I see no reason to reinvent strong PRNGs
in userspace for most applications.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
