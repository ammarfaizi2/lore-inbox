Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbSIZLHj>; Thu, 26 Sep 2002 07:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSIZLHj>; Thu, 26 Sep 2002 07:07:39 -0400
Received: from [195.223.140.120] ([195.223.140.120]:26466 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262237AbSIZLHi>; Thu, 26 Sep 2002 07:07:38 -0400
Date: Thu, 26 Sep 2002 13:12:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table, unmap_underlying_metadata)
Message-ID: <20020926111234.GC11333@dualathlon.random>
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com> <3D92BF0C.DBDDFA38@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92BF0C.DBDDFA38@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 01:02:20AM -0700, Andrew Morton wrote:
> Michael Clark wrote:
> > 
> > On 09/26/02 15:27, Andrew Morton wrote:
> > > Michael Clark wrote:
> > >
> > >>Hiya,
> > >>
> > >>Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
> > >>a moderately loaded server (100 users - 0.4 load avg).
> > >>
> > >>The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
> > >>and Qlogic 2300 Fibre channel HBA.
> > >>
> > >>We are running qla2300, e1000 and lvm modules unmodified as present in
> > >>2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.
> > >>
> > >
> > >
> > > It's not familiar, sorry.
> > 
> > Maybe I should try XFS? I've heard of people running this for
> > 80+ days and no downtime. I really would like to get past 8 days.
> 
> Well that would be one way of eliminating variables, and that's
> the only way to narrow this down.   Looks like something somewhere
> (software or hardware) has corrupted some memory.

yep. This is the hardest kind of bugs to fix, since the oops (or a lkcd
crash dump) would be almost totally useless in these cases. I'm quite
relaxed about the core, I would look into either scsi driver or e1000
first.

While I got good reports about qla drivers, I'm not sure how many people
is testing the e1000 in pre10aa4, that's an old driver, 4.2.x, the new
one in mainline 2.4.20 is 4.3.15. So I would suggest first of all to
upgrade the e1000 driver, just in case (I will shortly upload a new -aa
with all pending stuff included, but the latest one against 20pre5
is just in sync with mainline in terms of e1000).

> 
> The problem is that even if you _do_ fix the problem by switching
> something out, the cause could lie elsewhere.


Andrea
