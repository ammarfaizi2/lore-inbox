Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTHKFhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHKFhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:37:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38277 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272064AbTHKFgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:36:15 -0400
Date: Mon, 11 Aug 2003 06:36:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811053602.GL10446@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <bh77pp$rhq$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bh77pp$rhq$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Jamie Lokier  wrote:
> >If you return xy, you are returning a strong digest of the pool state.
> >Even with the backtrack-prevention, if the attacker reads 20 bytes
> >from /dev/random and sees a _recognised_ pattern, they immediately
> >know the entire state of the secondary pool.
> 
> Irrelevant.  I think you missed something.
> 
> If you pick a pattern in advance, the chance that your pattern appears
> at the output of SHA1 is about 2^-160 (assuming SHA1 is secure).

This is true if you assume the pool state is random (totally
unpredictable by the attacker).  Then, indeed, looking for known
patterns is useless.

However, if you _do_ spot a known pattern, there are two
possibilities: either it came up randomly, or it came up because the
pool state is not really random/unpredictable.

You may safely assume that if this happens, it's far more likely to be
a systemic problem, possibly of unknown type (explained below), than
it is to be due to randomness.  This is because random hits are found
on the order of 2^-160, assuming SHA1 is that good, whereas we can't
rule out systemic failures with that much confidence no matter how
carefully we try.

It may be that an attacker knows about a systemic problem with our
machine that we don't know about.  For example the attacker might know
our pool state well enough shortly after boot time, to have a chance
at matching a dictionary of 2^32 hashes.  The attacker might have had
a chance to read our disk, which reseeding the pool at boot time does
not protect against.

With the right algorithm, we can protect against weaknesses of this kind.
The protection is not absolute, but ruling out a category of attacks
is good if we can do it.

-- Jamie
