Return-Path: <linux-kernel-owner+w=401wt.eu-S1755291AbXABPOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbXABPOH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbXABPOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:14:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25154 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291AbXABPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:14:06 -0500
Date: Tue, 2 Jan 2007 16:14:02 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-ID: <20070102151401.GG2483@kernel.dk>
References: <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk> <459A32E5.70506@gmail.com> <20070102115757.GT2483@kernel.dk> <20070102121048.GU2483@kernel.dk> <459A7646.1070007@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459A7646.1070007@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Mark Lord wrote:
> Jens Axboe wrote:
> >On Tue, Jan 02 2007, Jens Axboe wrote:
> >>On Tue, Jan 02 2007, Rene Herman wrote:
> >>>Jens Axboe wrote:
> >>>
> >>>>On Mon, Jan 01 2007, Andrew Morton wrote:
> >>>>>The patch would appear to need this fix:
> >>>>>
> >>>>>--- a/block/cfq-iosched.c~a
> >>>>>+++ a/block/cfq-iosched.c
> >>>>>@@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
> >>>>>	if (cfqq == RQ_CFQQ(rq))
> >>>>>		return 1;
> >>>>>
> >>>>>-	return 1;
> >>>>>+	return 0;
> >>>>>}
> >>>>>
> >>>>>static inline void
> >>>>>_
> >>>>>
> >>>>>But that might not fix things...
> >>>>Yeah it is, but I don't think it'll fix it (if anything, it'll be more
> >>>>conservative).
> >>>(to possibly save others from trying -- no, doesn't fix any)
> >>As expected. The issue is rq_is_sync(rq) takes the data direction into
> >>account as well, while bio_sync() only checks the sync bit. This should
> >>fix it.
> >
> >And here a little more relaxed version, as Mark Lord suggested. We allow
> >merge of async bio into a sync request, but not vice versa.
> >
> >Both patches pending testing, will do so now.
> 
> Performance is right back where it should be now, thanks!

Good, thanks!

> I did have to massage the second patch to get it to apply cleanly
> after the first patch.  You may want to regenerate it against -rc3.

Hmm odd, I thought I did. Will double check.

-- 
Jens Axboe

