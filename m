Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUGKI0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUGKI0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 04:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUGKI0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 04:26:36 -0400
Received: from colin2.muc.de ([193.149.48.15]:57105 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266514AbUGKI0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 04:26:32 -0400
Date: 11 Jul 2004 10:26:30 +0200
Date: Sun, 11 Jul 2004 10:26:30 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: aoliva@redhat.com, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040711082630.GA63148@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br> <20040711055352.GB87770@muc.de> <20040710235536.14718bae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710235536.14718bae.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 11:55:36PM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > I guess it could be readded if the inlining heuristics were fixed,
> >  but even in gcc 3.5 it still looks quite bleak.
> 
> It's very simple.  For use in the kernel we don't *want* any inlining
> heuristics.  What we want is:
> 
> a) If the programmer says "inline", then inline it.

The problem is that we have a lot of "stale" inlines. Inlines that 
made sense a long time ago, but then people added a lot more code
to the function and it would be better to out line it again.
You should know, you seem to do this kind of out-lining most ...

For those it may even make sense to let the compiler chose.

> 
> b) If the programmer didn't say "inline" then don't inline it.
> 
> Surely it is not hard to add a new option to gcc to provide these semantics?

That option is -O2 -Dinline="__attribute__((always_inline))"
But for some reason it was turned off for 3.4/3.5.

-Andi

