Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267600AbUHMVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUHMVey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUHMVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:34:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3233 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267600AbUHMVeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:34:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813104817.GI8135@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe>  <20040813104817.GI8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092432929.3450.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 17:35:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:48, Ingo Molnar wrote:

>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7
> 

Here is the trace resulting from the apt-get filemap_sync() issue:

preemption latency trace v1.0
-----------------------------
 latency: 3656 us, entries: 4000 (8605)
 process: apt-get/21227, uid: 0
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): filemap_sync_pte_range (filemap_sync)
 0.000ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.002ms (+0.001ms): set_page_dirty (filemap_sync_pte)
 0.002ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 0.004ms (+0.001ms): radix_tree_tag_set (__set_page_dirty_buffers)
 0.006ms (+0.001ms): __mark_inode_dirty (__set_page_dirty_buffers)
 0.008ms (+0.001ms): filemap_sync_pte (filemap_sync_pte_range)
 0.009ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 0.009ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 0.010ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)
 0.011ms (+0.000ms): __mark_inode_dirty (__set_page_dirty_buffers)
 0.011ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.012ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 0.012ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 0.013ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)
 0.013ms (+0.000ms): __mark_inode_dirty (__set_page_dirty_buffers)
 0.014ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.014ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.015ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.016ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.016ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.017ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 0.017ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 0.018ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)
 0.019ms (+0.000ms): __mark_inode_dirty (__set_page_dirty_buffers)
 0.019ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.019ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.020ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.020ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.021ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 0.022ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 0.022ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 0.023ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)
 0.023ms (+0.000ms): __mark_inode_dirty (__set_page_dirty_buffers)
 
[ zillons of these deleted ]

 1.960ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 1.960ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 1.961ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 1.961ms (+0.000ms): preempt_schedule (__set_page_dirty_buffers)
 1.961ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)
 1.962ms (+0.000ms): preempt_schedule (__set_page_dirty_buffers)
 1.962ms (+0.000ms): __mark_inode_dirty (__set_page_dirty_buffers)
 1.963ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
 1.964ms (+0.000ms): set_page_dirty (filemap_sync_pte)
 1.964ms (+0.000ms): __set_page_dirty_buffers (set_page_dirty)
 1.964ms (+0.000ms): preempt_schedule (__set_page_dirty_buffers)
 1.965ms (+0.000ms): radix_tree_tag_set (__set_page_dirty_buffers)

Lee



