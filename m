Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUGKIdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUGKIdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUGKIdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 04:33:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266517AbUGKIdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 04:33:44 -0400
Date: Sun, 11 Jul 2004 01:32:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: aoliva@redhat.com, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-Id: <20040711013218.414941ce.akpm@osdl.org>
In-Reply-To: <20040711082630.GA63148@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it>
	<2fG2F-4qK-3@gated-at.bofh.it>
	<2fG2G-4qK-9@gated-at.bofh.it>
	<2fPfF-2Dv-21@gated-at.bofh.it>
	<2fPfF-2Dv-19@gated-at.bofh.it>
	<m34qohrdel.fsf@averell.firstfloor.org>
	<orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20040711055352.GB87770@muc.de>
	<20040710235536.14718bae.akpm@osdl.org>
	<20040711082630.GA63148@muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Sat, Jul 10, 2004 at 11:55:36PM -0700, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > I guess it could be readded if the inlining heuristics were fixed,
> > >  but even in gcc 3.5 it still looks quite bleak.
> > 
> > It's very simple.  For use in the kernel we don't *want* any inlining
> > heuristics.  What we want is:
> > 
> > a) If the programmer says "inline", then inline it.
> 
> The problem is that we have a lot of "stale" inlines. Inlines that 
> made sense a long time ago, but then people added a lot more code
> to the function and it would be better to out line it again.
> You should know, you seem to do this kind of out-lining most ...

We've already fixed zillions of those, and patches are accepted.  I think
someone wrote a tool to hunt those functions down, too.

> For those it may even make sense to let the compiler chose.

We can see how far that's getting us ;)

> > 
> > b) If the programmer didn't say "inline" then don't inline it.
> > 
> > Surely it is not hard to add a new option to gcc to provide these semantics?
> 
> That option is -O2 -Dinline="__attribute__((always_inline))"
> But for some reason it was turned off for 3.4/3.5.
> 

Please tell me that was just a bug, and it will be fixed very soon.
