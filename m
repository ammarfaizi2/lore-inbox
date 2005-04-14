Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVDNIap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDNIap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDNIap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:30:45 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:20844 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261465AbVDNIaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:30:19 -0400
Date: Thu, 14 Apr 2005 01:30:18 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Eric Rannaud <Eric.Rannaud@ens.fr>
Cc: Pedro Larroy <piotr@larroy.com>, linux-kernel@vger.kernel.org
Subject: Re: Call to atention about using hash functions as content indexers (SCM saga)
Message-ID: <20050414083018.GA24892@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412163549.GA7379@clipper.ens.fr>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 06:35:49PM +0200, Eric Rannaud wrote:
> Simply put, the best known attack of SHA-1 takes 2^69 hash operations.
> ( http://www.schneier.com/blog/archives/2005/02/sha1_broken.html )
> The attack is still only an unpublished paper and has not yet been
> implemented. An attack is: you try as hard as you can to find a collision
> between two arbitrary messages (i.e. two arbitrary --and nonsensical--
> source files).

Well, don't be quite so confident.  Yes, the attacks generally require a
significant uncontrollable chunk of data, but it's easy enough to encode
that in (for example) a comment.

And remember, attacks always get better, they never get worse.

Remaining cautious about the strength of your hash functions is a good
idea.

Especially because *nobody* has a real theory of operation behind online
hash functions.  The stories I've heard imply that even NSA doesn't
really "do" hash functions; they prefer HMAC-style keyed verifiers
(though of course, we on the outside can never be sure what's happening
in the puzzle palace.)

Every (practical) hash function in existence today is of the form "Well,
I mixed stuff up real good, and my friends and I tried and couldn't
break it".  And 160 bits still looks *fairly* secure, but so did 64-bit
symmetric key back in '93.

> In the context of git, a better estimation would be the number of hash
> operations needed to find a message that has the same hash than a given
> fixed message (e.g. mm/memory.c). This is more like 2^100 hash
> operations. And if a collision is found, this is very likely using a
> message that *doesn't* look like a C source file...

In particular, your defense here is specious.  I agree that second
preimage is an unmanagably large problem for SHA1 for the forseeable
future (say, 8 years out), but collision results almost always result in
partially-controlled attack text.  So I can choose my nefarious content,
and encode the collision entropy in non-operative text (a C comment, for
example).

When your tool breaks, replace it with a new one.  Don't say "well, the
jagged bits haven't hurt me *yet*."

-andy
