Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272168AbTHIDNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHIDNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:13:54 -0400
Received: from mail.suse.de ([213.95.15.193]:59656 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272168AbTHIDNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:13:53 -0400
Date: Sat, 9 Aug 2003 05:13:52 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
In-Reply-To: <20030809025232.GA11777@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.53.0308090509020.18879@Chaos.suse.de>
References: <20030808105321.GA5096@gondor.apana.org.au>
 <20030809010736.GA10487@gondor.apana.org.au> <Pine.LNX.4.53.0308090357290.18879@Chaos.suse.de>
 <20030809025232.GA11777@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Herbert Xu wrote:

> On Sat, Aug 09, 2003 at 04:04:53AM +0200, Andreas Gruenbacher wrote:
> >
> > > My patch is buggy too.  If a file is closed by another clone between
> > > the two steal_locks calls the lock will again be lost.  Fortunately
> > > this much harder to trigger than the previous bug.
> >
> > I think this is not a strict bug---this scenario is not covered by POSIX
> > in the first place. Unless lock stealing is done atomically with
> > unshare_files there is a window of oportunity between unshare_files() and
> > steal_locks(), so locks can still get lost.
>
> It's not a standard compliance issue.  In this case the lock will never
> be released and it will eventually lead to a crash when someone reads
> /proc/locks.

I don't see how this would happen. Could you please elaborate?
