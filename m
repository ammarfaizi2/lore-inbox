Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUI1AIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUI1AIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 20:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUI1AIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 20:08:25 -0400
Received: from [69.25.196.29] ([69.25.196.29]:12999 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267411AbUI1AIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 20:08:23 -0400
Date: Mon, 27 Sep 2004 20:07:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040928000719.GA16956@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <415861C4.4030604@colorfullife.com> <20040927194502.GO28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927194502.GO28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 03:45:02PM -0400, Jean-Luc Cooke wrote:
> > Actually trying to replace the partial MD4 might be worth an attempt: 
> > I'm certain that the partial MD4 is not the best/fastest way to generate 
> > sequence numbers.
> 
> It infact uses two full SHA1 hashs for tcp sequence numbers (endian and
> padding issues aside).  my patch aims to do this in 1 AES256 Encrypt or 2
> AES256 encrypts for ipv6.

No, that's not correct.  We rekey once at most every five minutes, and
that requires a SHA hash, but in the normal case, it's only a partial MD4.

An AES encrypt for every TCP connection *might* be faster, but I'd
want to time it to make sure, and doing a bulk test ala "openssl
speed" isn't necessarily going to be predictive, as I've discussed earlier.

						- Ted
