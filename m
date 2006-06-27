Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWF0Ikg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWF0Ikg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF0Ikg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:40:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:732 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751239AbWF0Ikf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:40:35 -0400
Date: Tue, 27 Jun 2006 10:35:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, swhiteho@redhat.com, torvalds@osdl.org,
       teigland@redhat.com, pcaulfie@redhat.com, kanderso@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627083544.GA32761@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627000633.91e06155.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627000633.91e06155.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 27 Jun 2006 08:33:39 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > Isnt this whole episode highly hypocritic to begin with?
> 
> Might be, but that's not relevant to GFS2's suitability.

it is relevant to a certain degree, because it creates a (IMO) false 
impression of merging showstoppers. After months of being in -mm, and 
after addressing all issues that were raised (and there was a fair 
amount of review activity December last year iirc), one week prior the 
close of the merge window a 'huge' list of issues are raised. (after 
belovingly calling the GFS2 code a "huge mess", to create a positive and 
productive tone for the review discussion i guess.)

So far in my reading there are only 2 serious ones in that list:

 - tty_* use in cluster-aware quota.c. Firstly, ocfs2 doesnt do quota -
   which is fair enough, but this also means that there was no in-tree 
   filesystem to base stuff off. Secondly, the tty_* use was inherited 
   from fs/quota.c - hardly something i'd consider a fatal sin. Anyway, 
   despite the mitigating factors it is an arguably lame thing and 
   it should be (and will be) fixed.

 - GFP_NOFAIL: most other journalling filesystems seem to be doing this
   or worse. Fixing it is _hard_. Suddenly this becomes a showstopper? 
   Huh?

(the "use the generic facilities" arguments are only valid if the 
generic facilities can be used as-is, and if they are just optimal as 
the one implemented by the filesystem.)

	Ingo
