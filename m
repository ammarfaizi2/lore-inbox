Return-Path: <linux-kernel-owner+w=401wt.eu-S964913AbXAGSrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXAGSrz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXAGSrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:47:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52986 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964910AbXAGSry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:47:54 -0500
Date: Sun, 7 Jan 2007 19:43:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
Subject: Re: [patch] paravirt: isolate module ops
Message-ID: <20070107184329.GA30270@elte.hu>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain> <20070106071424.GB11232@elte.hu> <1168100325.20372.37.camel@localhost.localdomain> <20070106193152.GA26153@infradead.org> <20070107183946.GB8158@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107183946.GB8158@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Sat, Jan 06, 2007 at 07:31:52PM +0000, Christoph Hellwig wrote:
> > On Sun, Jan 07, 2007 at 03:18:45AM +1100, Rusty Russell wrote:
> > > PS.  drm_memory.h has a "drm_follow_page": this forces us to uninline
> > > various page tables ops.  Can this use follow_page() somehow, or do we
> > > need an "__follow_page" export for this case?
> >
> > Not if avoidable.  And it seems avoidable as drm really should be using
> > vmalloc_to_page.  Untested patch below:
>
> Even better we can actualy avid most of the page table walks 
> completely.

agreed. I think there's an important side-observation here as well: 
having inlined functions uninlined and exported puts them under a lot 
more scrutiny. Hence individual exports instead of the global 
paravirt_ops export is a big plus.

        Ingo

