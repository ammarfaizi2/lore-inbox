Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUIVBey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUIVBey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIVBey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 21:34:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:17358 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266308AbUIVBew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 21:34:52 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <52mzzjnuq7.fsf@topspin.com>
References: <1095758630.3332.133.camel@gaston>
	 <1095761113.30931.13.camel@localhost.localdomain>
	 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1095816710.21230.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 11:31:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 08:05, Roland Dreier wrote:

> That means using __raw_writel() is pretty much guaranteed to blow up
> on IBM pSeries (and I do care about pSeries for my driver).

Yah, this is junk, they should filter out the token at least even if
they don't do the actual checking. I don't know why somebody did that
token thing in the first place, I'll do some investigations, but I hate
it. Note that only devices for which eeh has been enabled will be
affected.

> Maybe something like the patch below would make sense?  (Reordering of
> code is to make sure IO_TOKEN_TO_ADDR() is defined before the
> __raw_*() functions; eeh.h has to be included after the in_*() and
> out_*() functions are defined)
> 
> By the way, I notice that <asm-ppc64/eeh.h> has a bunch of eeh_raw_*
> functions that appear to be completely unused.  I didn't use them in
> my patch because they add memory ordering (isync or sync) that Alan
> says __raw_* functions shouldn't have.
> 
>     Linus> Ok, so that _is_ insane. Mind telling what kind of insane
>     Linus> hardware is BE in this day and age?
> 
> :) Mellanox InfiniBand HCAs....

Note that I intend to clean up that mess sooner or later...

Your patch looks ok.

Ben.


