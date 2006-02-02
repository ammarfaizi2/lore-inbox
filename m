Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWBBUy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWBBUy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWBBUy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:54:27 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:24475 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932235AbWBBUy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:54:26 -0500
Subject: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with 1 arg
	-- now takes 2
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602022040020.10639@goblin.wat.veritas.com>
References: <1138911375.5204.31.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602022040020.10639@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Thu, 02 Feb 2006 15:54:04 -0500
Message-Id: <1138913644.5204.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 20:46 +0000, Hugh Dickins wrote:
> On Thu, 2 Feb 2006, Lee Schermerhorn wrote:
> 
> > Apparent race between reiser4 and direct migration patches in 16-rc1-
> > mm4.
> > Direct migration added arg to rmap.c:try_to_unmap()--int ignore_refs--
> > and
> > fixed up existing refs.  reiser4 adds new call with single arg. 
> > 
> > One doesn't see this when building mm4 w/ reiser4 because the ref under
> > an
> > "#if REISER4_COPY_ON_CAPTURE" that is apparently not enabled.  I  just
> > noticed
> > it while looking at direct migration patches.  So, this patch is
> > essentially
> > UNTESTED.  Supplied simply to illustrate the location of the single arg
> 
> That's worrying code to find down in a filesystem.  But never mind,
> it refers to pte_chain_lock(), which hasn't existed since 2.6.5.  So
> REISER4_COPY_ON_CAPTURE is long untested and should just be deleted.
> 
> Hugh

OK.  I had a 16-rc1-mm4 build problem earlier because of a similar patch
race between an SGI patch bundle and one of gregkh's patches [ATE_MAKE()
arg changes], so I just wanted to give folks a heads up.

Thanks for the response.

Lee
> 
> > 
> > Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> > 
> > Index: linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c
> > ===================================================================
> > --- linux-2.6.16-rc1-mm4.orig/fs/reiser4/txnmgr.c	2006-01-31
> > 16:51:39.000000000 -0500
> > +++ linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c	2006-02-02
> > 14:43:01.659744418 -0500
> > @@ -3693,7 +3693,7 @@ static int create_copy_and_replace(jnode
> >  		pte_chain_lock(page);
> >  
> >  		if (page_mapped(page)) {
> > -			result = try_to_unmap(page);
> > +			result = try_to_unmap(page, 0);
> >  			if (result == SWAP_AGAIN) {
> >  				result = RETERR(-E_REPEAT);
> 

