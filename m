Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUIUWRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUIUWRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUIUWRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:17:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:23185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268090AbUIUWRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:17:02 -0400
Date: Tue, 21 Sep 2004 15:16:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <roland@topspin.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
In-Reply-To: <52mzzjnuq7.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
References: <1095758630.3332.133.camel@gaston> <1095761113.30931.13.camel@localhost.localdomain>
 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> <52mzzjnuq7.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Sep 2004, Roland Dreier wrote:
> 
> That means using __raw_writel() is pretty much guaranteed to blow up
> on IBM pSeries (and I do care about pSeries for my driver).

Oh, that's true. And that's pretty clearly a bug, since it just means that 
__raw_writel() can't even work in general.

> Maybe something like the patch below would make sense?  (Reordering of
> code is to make sure IO_TOKEN_TO_ADDR() is defined before the
> __raw_*() functions; eeh.h has to be included after the in_*() and
> out_*() functions are defined)

I wonder if we could just remove the TOKEN/ADDR games. I think they were 
done entirely as a debugging aid (but I could be wrong). In particular, 
the compile-time type safefy should hopefully be better at finding these 
things in the long run, and in the short run the TOKEN games have 
obviously played their part.

I wasn't using pp64 back when, maybe there's some other reason for playing
games with the tokens? Who's the guity/knowledgeable party? Ben?

		Linus
