Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWF0I4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWF0I4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWF0I4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:56:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:8646 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932766AbWF0I4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:56:16 -0400
Date: Tue, 27 Jun 2006 10:51:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627085124.GA1487@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627181632.A1297906@wobbly.melbourne.sgi.com> <20060627082240.GA672@elte.hu> <20060627184237.A1295371@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627184237.A1295371@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5033]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Scott <nathans@sgi.com> wrote:

> > and since XFS makes use of KM_SLEEP in 130+ callsites, that means it 
> > is in essence using GFP_NOFAIL massively!
> 
> Their locations have been carefully audited and understood.  The 
> original issue here was IRIX being able to do a very good of 
> preventing kernel memory allocation failures, which I suspect caused 
> the original XFS guys to be fairly relaxed in their handling of memory 
> allocation failures. Its caused us no end of pain with the Linux port, 
> I assure you.

i know it's a hard problem, and i'm not suggesting at all that this is 
easy to fix. Nevertheless there are 130 allocation callsites in XFS that 
do implicit GFS_NOFAIL in essence, and 7 callsites in GFS2 that mention 
__GFS_NOFAIL explicitly. Ext3 does __GFP_NOFAIL in its journalling code 
too. Reiser too.

	Ingo
