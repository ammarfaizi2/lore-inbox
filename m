Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275910AbTHOLrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275911AbTHOLrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:47:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23425 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275910AbTHOLrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:47:37 -0400
Date: Fri, 15 Aug 2003 12:47:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Val Henson <val@nmt.edu>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815114721.GA15911@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030814213600.GA12420@mail.jlokier.co.uk> <20030815002537.GE5333@speare5-1-14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815002537.GE5333@speare5-1-14>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson wrote:
> > I still do not see why either F or G are any more secure than SHA.
> 
> They aren't, in the sense of cryptographically signing a document.
> They do reveal less information about the input than SHA-1.

Not really.  There are two ways in which these functions can reveal
something about the input:

   1. Non-random input.  An 80 bit signature is virtually as good as a
      160 bit signature at confirming an attacker's hypothesis about
      the input being among a set of known inputs.  It's not like the
      kernel is deliberately trying to induce collisions, which is the
      usual reason for wanting more signature bits.

   2. Random input, i.e. plenty of real entropy.  If there is a weakness
      in the hash which NSA can use to determine the bit state, then
      it's true that F or G _might_ reveal half of the information that
      SHA would, if the weakness is also present in F and G.  Or it
      might reveal much less (Ted's hypothesis for F), or more (see 1).

      But!  When someone reads x bytes from /dev/urandom, twice as many
      hash transforms are performed with F or G than with SHA.

      So, if someone reads x bytes, the amount of information revealed
      through weakness could be less or more with F or G than with SHA.

> > Unless we're postulating that SHA is deliberately weak, so that the
> > designers have a back door, that is not present in F or G.
> 
> That's exactly what Ted described as his reason for doing the folding
> in the first place.

At least that reason makes sense :)

> Matt Mackall simply pointed out that a little bit of information
> theory will show you that throwing away half the output is more
> effective.

No, that depends on the nature of the hypothetical back door.

They could have engineered a back door which is completely present
when you throw the second half of the bits away.  Or any half of the
bits.  Or when you fold the bits together.  Or which reveals some but
less information when you do any of these.

In other words, you can't protect against a deliberate back door in
SHA, you can only try to scramble the output in some way that NSA
didn't prepare for.  And then you cannot be sure you succeeded.

-- Jamie

