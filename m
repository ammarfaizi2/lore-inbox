Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUI2Vlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUI2Vlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUI2Vlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:41:51 -0400
Received: from [69.25.196.29] ([69.25.196.29]:62176 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S269048AbUI2Vlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:41:49 -0400
Date: Wed, 29 Sep 2004 17:40:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Message-ID: <20040929214051.GA6769@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>, linux@horizon.com,
	linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com> <20040929193117.GB6862@thunk.org> <20040929202707.GO16057@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929202707.GO16057@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:27:07PM -0400, Jean-Luc Cooke wrote:
> 
> When reading nbytes from /dev/{u}random, Legacy /dev/random would:
>  - Mix nbytes of data from primary pool into secondary pool
>  - Then generate nbytes from secondary pool
> 
> When reading nbytes from /dev/{u}random, Fortuna-patch /dev/random would:
>  - Mix ??? of data from input pools into the AES key for output generation
>  - Then generate nbytes from AES256-CTR
> 
> Perhaps I miss the subtlety of the difference in terms of security.  If
> nbytes >= size of both pools - wouldn't Legacy also be vulnerable to the
> same attack?

Sure, but the Fortuna is supposed to be "more secure" because it
resists the state extension attack.  I don't think the state extension
attack is at all realistic, for the reasons cited above.  But if your
implementation doesn't resist the state extension attack, then why
bloat the kernel with an alternate random algorithm that's no better
as far as security is concerned?  (And is more heavy weight, and is
more wasteful with its entropy, etc., etc.?)

						- Ted

P.S.  I'll also note by the way, that in more recent versions of
/dev/random, we use a separate pool for /dev/urandom and /dev/random.
A further enhancement which I'm thinking might be a good one to add is
to limit the rate at which we transfer randomness from the primary
pool to the urandom pool.  So that it's not that I'm against making
changes; it's just that I want the changes to make sense, and protect
against realistic threats, not imaginary ones.

