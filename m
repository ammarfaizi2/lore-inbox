Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285492AbRLGUBh>; Fri, 7 Dec 2001 15:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284324AbRLGUBb>; Fri, 7 Dec 2001 15:01:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44296 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285492AbRLGUBM>; Fri, 7 Dec 2001 15:01:12 -0500
Message-ID: <3C111FE9.8E95DAA3@zip.com.au>
Date: Fri, 07 Dec 2001 12:00:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CP0X-0000uE-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au>,
		<3C110B3F.D94DDE62@zip.com.au> <E16CQwl-0000vL-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On December 7, 2001 07:32 pm, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > Because Ext2 packs multiple entries onto a single inode table block, the
> > > major effect is not due to lack of readahead but to partially processed
> > > inode table blocks being evicted.
> >
> > Inode and directory lookups are satisfied direct from the icache/dcache,
> > and the underlying fs is not informed of a lookup, which confuses the VM.
> >
> > Possibly, implementing a d_revalidate() method which touches the
> > underlying block/page when a lookup occurs would help.
> 
> Very interesting point, the same thing happens with file index blocks vs page
> cache accesses.  You're suggesting we need some kind of mechanism for
> propagating hits on cache items, either back to the underlying data or the
> information used to regenerate the cache items.

Not just to regenerate, but in the case of inodes: to write them back.  

We have situations in which sync_unlocked_inodes() stalls badly,
because it keeps on doing reads.

-
