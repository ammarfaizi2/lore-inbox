Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946848AbWKAMIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946848AbWKAMIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946838AbWKAMH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:07:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423978AbWKAMHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:07:37 -0500
Message-Id: <20061101114435.234474405@chello.nl>
User-Agent: quilt/0.45-1
Date: Wed, 01 Nov 2006 12:44:35 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] on do_page_fault() and *copy*_inatomic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of the recent work on fault handlers and generic_file_buffered_write()
I've gone over some of the arch specific stuff that supports this work.

The following three patches are ready for inclusion IMHO, please apply.

The first patch fixes up some arch fault handlers to respect the
'take no locks in atomic context' rule; this also fixes CONFIG_PREEMPT bugs
on those platforms.

The second patch introduces pagefault_{disable,enable}() - an abtraction that
replaces the now open coded {inc,dec}_preempt_count() calls when we mean to
create atomic pagefault scope. The added barrier() calls in the new 
primitives might fix some CONFIG_PREEMPT bugs.

The third patch make k{,un}map_atomic denote an atomic pagefault scope. All
non-trivial implementation already do this, and this allows us to rely on that
in generic. This might also fix some bugs where people already assumed this.

Peter

--

