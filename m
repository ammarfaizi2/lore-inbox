Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUI0Onj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUI0Onj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUI0Onj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:43:39 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:42436 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S266263AbUI0Onh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:43:37 -0400
Date: Mon, 27 Sep 2004 10:42:10 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com,
       cryptoapi@lists.logix.cz, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040927144210.GH28317@certainkey.com>
References: <20040926052308.GB8314@thunk.org> <20040927005033.14622.qmail@science.horizon.com> <20040927142352.GA15589@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927142352.GA15589@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:23:52AM -0400, Theodore Ts'o wrote:
> On Mon, Sep 27, 2004 at 12:50:33AM -0000, linux@horizon.com wrote:
> > > And the ring-buffer system which delays the expensive mixing stages untill a
> > > a sort interrupt does a great job (current and my fortuna-patch).  Difference
> > > being, fortuna-patch appears to be 2x faster.
> > 
> > Ooh, cool!  Must play with to steal the speed benefits.  Thank you!
> 
> This is somewhat fundamental to the philosophical question of whether
> you store a large amount of entropy, taking advantage of the fact that
> the kernel has easy access to hardware-generated entropy, or use tiny
> pools and put a greater faith in crypto primitives.

Tiny in that at most you can only pull out 256bits of entropy from one pool,
you are correct.  SHA-256 buffers 64 bytes at time.  The transform requires
512 bytes for its mixing.  The mixing of the 512 byte W[] array is done
serially.

random_state->pool is POOLBYTES in size.  Which is poolwords*4, which is
DEFAULT'd to 512 bytes.  The "5 tap" LFSR reaches all over that 512byte
memory for its mixing.

If page sizes get big enough and we page-align the pool[] member, the
standard RNG will get faster.

JLC
