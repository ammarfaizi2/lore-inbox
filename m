Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCaDtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCaDtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCaDtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:49:15 -0500
Received: from pat.uio.no ([129.240.130.16]:16058 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261934AbVCaDs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:48:57 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1112237239.26732.8.camel@mindpipe>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
	 <20050330115640.0bc38d01.akpm@osdl.org>
	 <1112217299.10771.3.camel@lade.trondhjem.org>
	 <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org>
	 <1112237239.26732.8.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 22:48:38 -0500
Message-Id: <1112240918.10975.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.634, required 12,
	autolearn=disabled, AWL 1.32, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 21:47 (-0500) skreiv Lee Revell:
> On Wed, 2005-03-30 at 18:39 -0800, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > > Yes. Together with the radix tree-based sorting of dirty requests,
> > >  > that's pretty much what I've spent most of today doing. Lee, could you
> > >  > see how the attached combined patch changes your latency numbers?
> > >  > 
> > > 
> > >  Different code path, and the latency is worse.  See the attached ~7ms
> > >  trace.
> > 
> > Is a bunch of gobbledygook.  Hows about you interpret it for us?
> > 
> 
> Sorry.  When I summarized them before, Ingo just asked for the full
> verbose trace.
> 
> The 7 ms are spent in this loop:
> 
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
>  nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
>  radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)


Which is basically confirming what the guys from Bull already told me,
namely that the radix tree tag stuff is much less efficient that what
we've got now. I never saw their patches, though, so I was curious to
try it for myself.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

