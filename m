Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272156AbTHICxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 22:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHICxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 22:53:47 -0400
Received: from c211-28-63-178.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:22802
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272156AbTHICxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 22:53:24 -0400
Date: Sat, 9 Aug 2003 12:53:11 +1000
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Restore current->files in flush_old_exec
Message-ID: <20030809025311.GB11777@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <20030809010736.GA10487@gondor.apana.org.au> <20030809011116.GB10487@gondor.apana.org.au> <20030809014830.GA11509@gondor.apana.org.au> <Pine.LNX.4.53.0308090418270.18879@Chaos.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308090418270.18879@Chaos.suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 04:20:38AM +0200, Andreas Gruenbacher wrote:
> On Sat, 9 Aug 2003, Herbert Xu wrote:
> 
> > On Sat, Aug 09, 2003 at 11:11:16AM +1000, herbert wrote:
> > >
> > > At this point, I believe the unshare_files stuff should be fine from
> > > a correctness point of view.  However, there is still a performance
> > > problem as every ELF exec call ends up dupliating the files structure
> > > as well as walking through all file locks.
> >
> > Here is the patch that ensures files is only duplicated when necessary.
> 
> This patch is correct but unnecessary: steal_locks already tests for this
> condition.

Yes but when you call unshare_files twice one of them will have to
copy.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
