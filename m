Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWGaAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWGaAlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWGaAls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:41:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:56993 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932493AbWGaAlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:41:47 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:41:42 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 11] knfsd: Introduction - Make knfsd more NUMA-aware
Message-ID: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 11 patches from Greg Banks which combine to make knfsd
more Numa-aware.  They reduce hitting on 'global' data structures, and
create some data-structures that can be node-local.

knfsd threads are bound to a particular node, and the thread to handle
a new request is chosen from the threads that are attach to the node
that received the interrupt.

The distribution of threads across nodes can be controlled by a new
file in the 'nfsd' filesystem, though the default approach of an even
spread is probably fine for most sites.

Some (old) numbers that show the efficacy of these patches:
N == number of NICs == number of CPUs == nmber of clients.
Number of NUMA nodes == N/2

N	Throughput, MiB/s	CPU usage, % (max=N*100)
	Before	After		Before	After
---	------	----		-----	-----
4	312	435		350	228
6	500	656		501	418
8	562	804		690	589


 [PATCH 001 of 11] knfsd: move tempsock aging to a timer
 [PATCH 002 of 11] knfsd: convert sk_inuse to atomic_t
 [PATCH 003 of 11] knfsd: use new lock for svc_sock deferred list
 [PATCH 004 of 11] knfsd: convert sk_reserved to atomic_t
 [PATCH 005 of 11] knfsd: test and set SK_BUSY atomically
 [PATCH 006 of 11] knfsd: split svc_serv into pools
 [PATCH 007 of 11] knfsd: add svc_get
 [PATCH 008 of 11] knfsd: add svc_set_num_threads
 [PATCH 009 of 11] knfsd: use svc_set_num_threads to manage threads in knfsd
 [PATCH 010 of 11] knfsd: make rpc threads pools numa aware
 [PATCH 011 of 11] knfsd: allow admin to set nthreads per node
