Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275336AbTHMSrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275322AbTHMSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:47:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20352 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275355AbTHMSpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:45:02 -0400
Date: Wed, 13 Aug 2003 19:43:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jim Carter <jimc@math.ucla.edu>, "Theodore Ts'o" <tytso@mit.edu>,
       Matt Mackall <mpm@selenic.com>, James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: i810_rng.o on various Dell models
Message-ID: <20030813184319.GD4405@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030813035257.GB1244@think> <Pine.LNX.4.53.0308130830170.3016@xena.cft.ca.us> <20030813161459.GA19667@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813161459.GA19667@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Intel's RNG was slow anyway, compared to the AMG and now VIA RNGs, so
> you didn't want it anyway :)  I really like VIA's "xstore", which is an
> RNG implemented via a CPU instruction.  That way you don't need a kernel
> driver at all, really.

>From an electronic point of view, assuming similar technology, and
circuits of similar size, I would expect a slower source to be able to
give getter randomness than a very fast source.

Whether it does depends on the implementation, of course.

I don't know if "xstore" can execute on every clock cycle.  But
imagine if it could execute once every 1GHz cycle, and if there was
only one RNG circuit, not lots of them in parallel.  Then it would
seem difficult indeed to ensure that successive outputs of the RNG
were strongly independent.  Whereas the same circuit, integrating over
a signal 10^6 times to return a value every 1ms, would return better
results but fewer of them.

That said, it might be better to read lots of results from "xstore"
and feed them into a known algorithm like random.c, than to read just
a few results from a slow Intel black box and trust the quality of its
source.

-- Jamie
