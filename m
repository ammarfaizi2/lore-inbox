Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUIYSwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUIYSwT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269389AbUIYSwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:52:18 -0400
Received: from [69.25.196.29] ([69.25.196.29]:20662 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S269384AbUIYSwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:52:16 -0400
Date: Sat, 25 Sep 2004 14:43:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux@horizon.com, jmorris@redhat.com, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040925184352.GB7278@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>, linux@horizon.com,
	jmorris@redhat.com, cryptoapi@lists.logix.cz,
	linux-kernel@vger.kernel.org
References: <20040924023413.GH28317@certainkey.com> <20040924214230.3926.qmail@science.horizon.com> <20040925145444.GW28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925145444.GW28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 10:54:44AM -0400, Jean-Luc Cooke wrote:
> 
> I was trying to point out a flaw in Ted's logic.  He said "we've recently
> discoverd these hashs are weak because we found collsions.  Current
> /dev/random doesn't care about this."
> 
> I certainly wasn't saying padding was a requirment.  But I was trying to
> point out that the SHA-1 implementaion crrently in /dev/random by design is
> collision vulnerable.  Collision resistance isn't a requirment for it's
> purposes obviously.

You still haven't shown the flaw in the logic.  My point is that an
over-reliance on crypto primitives is dangerous, especially given
recent developments.  Fortuna relies on the crypto primitives much
more than /dev/random does.  Ergo, if you consider weaknesses in
crypto primitives to be a potential problem, then it might be
reasonable to take a somewhat more jaundiced view towards Fortuna
compared with other alternatives.

Whether or not /dev/random performs the SHA finalization step (which
adds the padding and the length to the hash) is completely and totally
irrelevant to this particular line of reasoning.  

And actually, not doing the padding does not make the crypto hash
vulnerable to collisions, as you claim.  This is because in
/dev/random, we are always using the full block size of the crypto
hash.  It is true that it is vulernable to extension attacks, but
that's irrelevant to this particular usage of the SHA-1 round
function.  Whether or not we should trust the design of something as
critical to the security of security applications as /dev/random to
someone who fails to grasp the difference between these two rather
basic issues is something I will leave to the others on LKML.

							- Ted
