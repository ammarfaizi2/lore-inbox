Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932957AbWJIQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbWJIQMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932958AbWJIQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:12:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:52393 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932957AbWJIQMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:12:13 -0400
From: Nick Piggin <npiggin@suse.de>
To: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20061009140354.13840.71273.sendpatchset@linux.site>
Subject: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault handlers
Date: Mon,  9 Oct 2006 18:12:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've cleaned up and further improved this patchset, removed duplication
while retaining legacy nopage handling, restored page_mkwrite to the ->fault
path (due to lack of users upstream to attempt a conversion), converted the
rest of the filesystems to use ->fault, restored MAP_POPULATE and population
of remap_file_pages pages, replaced nopfn completely, and removed
NOPAGE_REFAULT because that can be done easily with ->fault.

In the process:
- GFS2, OCFS2 theoretically get nonlinear mapping support
- Nonlinear mappings gain page_mkwrite and dirty page throttling support
- Nonlinear mappings gain the fault vs truncate race fix introduced for linear 

All pretty much for free.

This is lightly compile tested only, unlike the last set, mainly
because it is presently just an RFC regarding the direction I'm going
(and it's bedtime).

Nick

