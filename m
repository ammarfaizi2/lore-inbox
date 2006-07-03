Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWGCN2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWGCN2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGCN2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:28:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751153AbWGCN2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:28:20 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, torvalds@osdl.org,
       teigland@redhat.com, pcaulfie@redhat.com, kanderso@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060627083544.GA32761@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu>
	 <20060627063339.GA27938@elte.hu> <20060627000633.91e06155.akpm@osdl.org>
	 <20060627083544.GA32761@elte.hu>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 03 Jul 2006 14:40:17 +0100
Message-Id: <1151934017.3856.1687.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-06-27 at 10:35 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Tue, 27 Jun 2006 08:33:39 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > Isnt this whole episode highly hypocritic to begin with?
> > 
> > Might be, but that's not relevant to GFS2's suitability.
> 
> it is relevant to a certain degree, because it creates a (IMO) false 
> impression of merging showstoppers. After months of being in -mm, and 
> after addressing all issues that were raised (and there was a fair 
> amount of review activity December last year iirc), one week prior the 
> close of the merge window a 'huge' list of issues are raised. (after 
> belovingly calling the GFS2 code a "huge mess", to create a positive and 
> productive tone for the review discussion i guess.)
> 
> So far in my reading there are only 2 serious ones in that list:
> 
>  - tty_* use in cluster-aware quota.c. Firstly, ocfs2 doesnt do quota -
>    which is fair enough, but this also means that there was no in-tree 
>    filesystem to base stuff off. Secondly, the tty_* use was inherited 
>    from fs/quota.c - hardly something i'd consider a fatal sin. Anyway, 
>    despite the mitigating factors it is an arguably lame thing and 
>    it should be (and will be) fixed.
> 
This one is now fixed in the git tree:
    git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git
Also fixed/changed in this tree is:

 o Mark GFS2 file_operations const
 o Mark GFS2 address_space_operations const
 o Update gfs2_statfs() API in line with change in Linus' tree
 o Update gfs2_get_sb() API in line with change in Linus' tree (thanks
to Andrew Morton for this one)
 o Updated to latest Linus tree

So I think that brings the code back uptodate after my holiday last
week.

>  - GFP_NOFAIL: most other journalling filesystems seem to be doing this
>    or worse. Fixing it is _hard_. Suddenly this becomes a showstopper? 
>    Huh?
> 
> (the "use the generic facilities" arguments are only valid if the 
> generic facilities can be used as-is, and if they are just optimal as 
> the one implemented by the filesystem.)
> 
> 	Ingo
I believe that this point is now resolved (so far as GFS2 going upstream
is concerned) from the discussions that have gone on in my absence. Its
obviously still an ongoing concern for a number of filesystems, not just
GFS2 and I'll be working on ways to reduce the current "nofail"
allocation calls in the future,

Steve.


