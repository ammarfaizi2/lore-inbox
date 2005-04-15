Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVDOQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVDOQWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDOQWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:22:49 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:46527 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261859AbVDOQWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:22:44 -0400
Date: Fri, 15 Apr 2005 12:22:25 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050415162225.GA23277@certainkey.com>
References: <20050414133336.GA16977@thunk.org> <20050415013417.3536.qmail@science.horizon.com> <20050415144216.GA9352@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415144216.GA9352@thunk.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 10:42:16AM -0400, Theodore Ts'o wrote:
> > Just to be clear, I don't remember it ever throwing entropy away, but
> > it hoards some for years, thereby making it effectively unavailable.
> > Any catastrophic reseeding solution has to hold back entropy for some
> > time.
> 
> It depends on how often you reseed, but my recollection was that it
> was far more than years; it was *centuries*.  And as far as I'm
> concerned, that's equivalent to throwing it away, especially given the
> pathetically small size of the Fortuna pools.

"pathetically" is an interesting term to call it.  256 bits is the most any
one of the 32 pools can hold, true.  And the n-th pool is used only once
every 2^n times (where the first pool is the 0-th pool, hence it's used
everytime).

2^31 * 0.1s reseeds, mean the 31st (aka. last) pool will be drawn from once
every 6.8 years.

And the argument that "random.c doesn't rely on the strength of crypto
primitives" is kinda lame, though I see where you're coming from.  random.c's
entropy mixing and output depends on the (endian incorrect) SHA-1
implementation hard coded in that file to be pre-image resistant.  If that
fails (and a few other things) then it's broken.

Fortuna depends on known cipher-text attacks on the cipher in use (in this
case AES-256) and the digest algo in use (in this case SHA-256) to be
pre-image resistant.  Cryptographers like reducing things to known
quantities, it may be flaw.

Once I set some personal things sorted out I'll take another crack at making
/dev/fortuna with it's claws in random.c to feed it some of that entropy as 
linux@horizon.com suggested.

JLC
