Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVCaCr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVCaCr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCaCrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:47:25 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14808 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262495AbVCaCrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:47:20 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050330183957.2468dc21.akpm@osdl.org>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
	 <20050330115640.0bc38d01.akpm@osdl.org>
	 <1112217299.10771.3.camel@lade.trondhjem.org>
	 <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 21:47:19 -0500
Message-Id: <1112237239.26732.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 18:39 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > > Yes. Together with the radix tree-based sorting of dirty requests,
> >  > that's pretty much what I've spent most of today doing. Lee, could you
> >  > see how the attached combined patch changes your latency numbers?
> >  > 
> > 
> >  Different code path, and the latency is worse.  See the attached ~7ms
> >  trace.
> 
> Is a bunch of gobbledygook.  Hows about you interpret it for us?
> 

Sorry.  When I summarized them before, Ingo just asked for the full
verbose trace.

The 7 ms are spent in this loop:

 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
 radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
 radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
 radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
 radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 nfs_set_page_writeback_locked+0xe/0x60 <c01c357e> (nfs_scan_lock_dirty+0x8d/0xf0 <c01c39fd>)
 radix_tree_tag_set+0xe/0xa0 <c01e036e> (nfs_set_page_writeback_locked+0x4b/0x60 <c01c35bb>)
 radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
 radix_tree_gang_lookup_tag+0xe/0x80 <c01e074e> (nfs_scan_lock_dirty+0x69/0xf0 <c01c39d9>)
 __lookup_tag+0xe/0x130 <c01e061e> (radix_tree_gang_lookup_tag+0x59/0x80 <c01e0799>)

Lee

