Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTD3QCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbTD3QCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:02:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60688 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262219AbTD3QCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:02:45 -0400
Date: Wed, 30 Apr 2003 09:16:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <87el3kt1kt.fsf@student.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Apr 2003, Falk Hueffner wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > There is _never_ any excuse to use a lookup table for something that
> > can be calculated with a few simple instructions. That's just
> > stupid.
> 
> Well, the "few simple instructions" are 28 instructions on Alpha for
> example, including 6 data-dependent branches. So I don't think it's
> *that* stupid.

You're comparing apples to oranges.

Clearly you're not going to make _one_ load to get fls, since having a 
4GB lookup array for a 32-bit fls would be "somewhat" wasteful.

So the lookup table would probably look up just the last 8 bits.

So the lookup table version is several instructions in itself, doing about
half of what the calculating version needs to do _anyway_. Including those
data-dependent branches.

		Linus

