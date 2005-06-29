Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVF2OXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVF2OXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVF2OXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:23:30 -0400
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:47918 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262588AbVF2OXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:23:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc1
References: <4kEoS-Am-3@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 29 Jun 2005 16:23:11 +0200
In-Reply-To: <4kEoS-Am-3@gated-at.bofh.it>
Message-ID: <m37jgd9r8w.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> ARM, x86[-64], ppc, sparc updates, networking, sound, infiniband, input
> layer, ISDN, MD, DVB, V4L, network drivers, pcmcia, isofs, jfs, nfs,
> xfs, knfsd.. You name it.
> 
> Git trees and traditional patches/tar-balls are out there, or at least 
> slowly mirroring out. Go wild,
> 
> 		Linus

On x86_64 with reiserfs and ext3 on dm (using cfq scheduler) the log
is full of this:

Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424

Call Trace:<ffffffff8022e9a2>{blk_remove_plug+49} <ffffffff8022f093>{__generic_unplug_device+21}
       <ffffffff80230da3>{get_request_wait+155} <ffffffff8013e6d0>{autoremove_wake_function+0}
       <ffffffff80231252>{__make_request+789} <ffffffff8022f3e9>{generic_make_request+502}
       <ffffffff8013e6d0>{autoremove_wake_function+0} <ffffffff8016a378>{bio_clone+130}
       <ffffffff8803cadc>{:dm_mod:clone_bio+37} <ffffffff8803cdf5>{:dm_mod:__split_bio+327}
       <ffffffff8803d11e>{:dm_mod:dm_request+171} <ffffffff8022f3e9>{generic_make_request+502}
       <ffffffff8013e6d0>{autoremove_wake_function+0} <ffffffff8014d81c>{mempool_alloc+49}
       <ffffffff8022f4ba>{submit_bio+188} <ffffffff80169dd0>{bio_alloc_bioset+232}
       <ffffffff801674fd>{submit_bh+254} <ffffffff80169158>{__block_write_full_page+419}
       <ffffffff8016c0e1>{blkdev_get_block+0} <ffffffff8018308f>{mpage_writepages+418}
       <ffffffff8016b39b>{blkdev_writepage+0} <ffffffff8013afe6>{worker_thread+0}
       <ffffffff8014ac31>{__filemap_fdatawrite_range+81} <ffffffff881c6752>{:reiserfs:flush_async_commits+103}
       <ffffffff881c66eb>{:reiserfs:flush_async_commits+0}
       <ffffffff8013b13f>{worker_thread+345} <ffffffff8012aef0>{default_wake_function+0}
       <ffffffff8013afe6>{worker_thread+0} <ffffffff8013e533>{kthread+191}
       <ffffffff8013afe6>{worker_thread+0} <ffffffff8010eee7>{child_rip+8}
       <ffffffff8013afe6>{worker_thread+0} <ffffffff8013e358>{keventd_create_kthread+0}
       <ffffffff8013e474>{kthread+0} <ffffffff8010eedf>{child_rip+0}
       

-- 
Ronny V. Vindenes <s864@ii.uib.no>
