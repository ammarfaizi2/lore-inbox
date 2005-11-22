Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVKVSHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVKVSHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVKVSHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:07:51 -0500
Received: from 81-179-232-225.dsl.pipex.com ([81.179.232.225]:11973 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965085AbVKVSHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:07:50 -0500
Date: Tue, 22 Nov 2005 18:07:24 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, kravetz@us.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] SPARSEMEM: pfn_to_nid implementation v2
Message-ID: <exportbomb.1132682844@pinky>
References: <20051119233151.01ce6c50.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20051119233151.01ce6c50.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are three places we define pfn_to_nid().  Two in linux/mmzone.h
and one in asm/mmzone.h.  These in essence represent the three memory
models.  The definition in linux/mmzone.h under !NEED_MULTIPLE_NODES
is both the FLATMEM definition and the optimisation for single
NUMA nodes; the one under SPARSEMEM is the NUMA sparsemem one;
the one in asm/mmzone.h under DISCONTIGMEM is the discontigmem one.
This is not in the least bit obvious, particularly the connection
between the non-NUMA optimisations and the memory models.

Following in the email are two patches:

flatmem-split-out-memory-model: simplifies the selection of
    pfn_to_nid() implementations.  The selection is based primarily
    off the memory model selected.  Optimisations for non-NUMA are
    applied where needed.

sparse-provide-pfn_to_nid: implement pfn_to_nid() for SPARSEMEM

Boot tested on for both SPARSEMEM and DISCONTIGMEM on all my test
boxes.  Also compile tested for FLATMEM and SPARSEMEM without NUMA.
Against 2.6.15-rc2.

Next I'll review the configuration options to see if we can simplify
them any.

-apw
