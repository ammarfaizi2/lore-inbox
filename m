Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUIULpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUIULpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbUIULpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:45:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:49352 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267585AbUIULo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:44:59 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <1095761113.30931.13.camel@localhost.localdomain>
References: <1095758630.3332.133.camel@gaston>
	 <1095761113.30931.13.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1095766919.3577.138.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 21:41:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 20:05, Alan Cox wrote:
> On Maw, 2004-09-21 at 10:23, Benjamin Herrenschmidt wrote:
> > Hi !
> > 
> > Linus, I don't know if you did that on purpose, but you removed the
> > "volatile" statement from the definition of the __raw_* IO accessors
> > on ppc64, which cause some real bad optisations to happen in some
> > fbdev's like matroxfb to happen (just imagine that matroxfb loops
> > reading an IO register waiting for a bit to change).
> 
> Why is it using __raw if it cares about ordering and not using barriers
> ? Way back when the original definition was that __raw didnt do
> barriers. Thats why I2O for example uses __raw_ so that messages can be
> generated as efficiently as possible.

It uses __raw for non-byteswap... The problem is that __raw does both
non-byteswap and non-barriers and there is no simple way to get one
and not the other...

Ben.


