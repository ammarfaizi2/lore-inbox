Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030754AbWF0IRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754AbWF0IRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030750AbWF0IRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:17:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13770 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030755AbWF0IRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:17:35 -0400
Date: Tue, 27 Jun 2006 18:16:32 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627181632.A1297906@wobbly.melbourne.sgi.com>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060627063339.GA27938@elte.hu>; from mingo@elte.hu on Tue, Jun 27, 2006 at 08:33:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 08:33:39AM +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > * Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > The code uses GFP_NOFAIL for slab allocator calls.  It's been 
> > > pointed out here numerous times that this can't work.  Andrew, what 
> > > about adding a check to slab.c to bail out if someone passes it?
> > 
> > reiserfs, jbd and NTFS are all using GFP_NOFAIL ...
> > 
> > i dont think this is a huge issue that should block merging.
> 
> oh, and XFS has this little gem in its journalling code:
> 

[snip misinterpreted code/flag]

>           */
>          buf = (xfs_caddr_t) kmem_zalloc(NBPP, KM_SLEEP);
>  [...]
> 
> where kmem_zalloc() may fail!!!

Not with the flags it was given.

> So XFS is apprarently hiding the "journalling allocations must not fail" 
> problem by ... crashing? Wow! Most of the other journalling filesystems 
> loop on the allocator: the honest ones do it via GFP_NOFAIL, others via 
> open-coded infinite retry loops.

No, please look more closely before making such claims.

> sophisticated filesystem, which has many dynamic (and delayed) decisions 
> that make the prediction of resource overhead difficult. That's the 
> fundamental reason why basically all journalling filesystems either loop 
> (or the really enterprise quality ones: crash ;) on allocation failure.

> other problems with the XFS code that are similar in nature to the ones 
> you pointed out. (mostly useless wrappers around Linux functionality) 

You've missed subtleties in those "useless wrappers", which are
preventing the problem you claim is there.

cheers.

-- 
Nathan
