Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271312AbTHIBrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271885AbTHIBrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:47:00 -0400
Received: from mail.suse.de ([213.95.15.193]:7432 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271312AbTHIBq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:46:59 -0400
Date: Sat, 9 Aug 2003 03:46:55 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
In-Reply-To: <20030809010736.GA10487@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.53.0308090343490.18879@Chaos.suse.de>
References: <20030808105321.GA5096@gondor.apana.org.au>
 <20030809010736.GA10487@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks a lot for analyzing this. Please see the patch I just posted unter
the subject:

  [PATCH] 2.4.22-rc2 steal_locks and load_elf_binary cleanups

That patch fixes the bug in a slightly cleaner way.

On Sat, 9 Aug 2003, Herbert Xu wrote:

> On Fri, Aug 08, 2003 at 08:53:21PM +1000, herbert wrote:
> >
> > The steal_locks() call in binfmt_elf.c is buggy.  It steals locks from
> > a files entry whose reference was dropped much earlier.  This allows it
> > to steal other process's locks.

This makes sense.

> > The following patch calls steal_locks() earlier so that this does not
> > happen.
>
> My patch is buggy too.  If a file is closed by another clone between
> the two steal_locks calls the lock will again be lost.  Fortunately
> this much harder to trigger than the previous bug.
>
> The following patch fixes that.
>
