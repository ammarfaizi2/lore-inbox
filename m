Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUI1NqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUI1NqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUI1NqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:46:21 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:48279 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267739AbUI1NqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:46:12 -0400
Date: Tue, 28 Sep 2004 15:46:11 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040928134611.GB24621@MAIL.13thfloor.at>
Mail-Followup-To: Jean-Luc Cooke <jlcooke@certainkey.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <415861C4.4030604@colorfullife.com> <20040927194502.GO28317@certainkey.com> <20040928000719.GA16956@thunk.org> <20040928022409.GQ28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928022409.GQ28317@certainkey.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:24:09PM -0400, Jean-Luc Cooke wrote:
> On Mon, Sep 27, 2004 at 08:07:19PM -0400, Theodore Ts'o wrote:
> > On Mon, Sep 27, 2004 at 03:45:02PM -0400, Jean-Luc Cooke wrote:
> > > > Actually trying to replace the partial MD4 might be worth an attempt: 
> > > > I'm certain that the partial MD4 is not the best/fastest way to generate 
> > > > sequence numbers.
> > > 
> > > It infact uses two full SHA1 hashs for tcp sequence numbers (endian and
> > > padding issues aside).  my patch aims to do this in 1 AES256 Encrypt or 2
> > > AES256 encrypts for ipv6.
> > 
> > No, that's not correct.  We rekey once at most every five minutes, and
> > that requires a SHA hash, but in the normal case, it's only a partial MD4.
> 
> Pardon, the SYN cookies use two SHA1's, not the TCP sequence numbers.  Easy
> to mistake to make with comments "Compute the secure sequence number." in the
> secure_tcp_syn_cookie() function.  :)
> 
> > An AES encrypt for every TCP connection *might* be faster, but I'd
> > want to time it to make sure, and doing a bulk test ala "openssl
> > speed" isn't necessarily going to be predictive, as I've discussed earlier.
> 
> Agreed.
> 
> Was meaning to ask:
>   add_timer_randomness()
> 
> There is a comment:
>   /* if over the trickle threshold, use only 1 in 4096 samples */
>   if ( random_state->entropy_count > trickle_thresh &&
> 	(__get_cpu_var(trickle_count)++ & 0xfff))
> 		return;
> 
> "if (x++ & 0xfff)" will return true 0xfff out of 0x1000 of the time.  Is this
> the goal, because I don't think this will trickle control very well.

and it will 'return' 0xfff times of 0x1000 ...

(just one case (x == 0) will pass this check)

best,
Herbert

> JLC
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
