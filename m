Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272153AbTHICwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 22:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272156AbTHICwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 22:52:53 -0400
Received: from c211-28-63-178.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:21522
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272153AbTHICww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 22:52:52 -0400
Date: Sat, 9 Aug 2003 12:52:32 +1000
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
Message-ID: <20030809025232.GA11777@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <20030809010736.GA10487@gondor.apana.org.au> <Pine.LNX.4.53.0308090357290.18879@Chaos.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308090357290.18879@Chaos.suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 04:04:53AM +0200, Andreas Gruenbacher wrote:
>
> > My patch is buggy too.  If a file is closed by another clone between
> > the two steal_locks calls the lock will again be lost.  Fortunately
> > this much harder to trigger than the previous bug.
> 
> I think this is not a strict bug---this scenario is not covered by POSIX
> in the first place. Unless lock stealing is done atomically with
> unshare_files there is a window of oportunity between unshare_files() and
> steal_locks(), so locks can still get lost.

It's not a standard compliance issue.  In this case the lock will never
be released and it will eventually lead to a crash when someone reads
/proc/locks.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
