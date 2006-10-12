Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWJLOJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWJLOJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWJLOJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:09:38 -0400
Received: from mail.suse.de ([195.135.220.2]:60352 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751417AbWJLOJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:09:38 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [rfc][patch 0/5] 2.6.19-rc1: oom killer fixes
Date: Thu, 12 Oct 2006 16:09:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been prompted to take another look through the OOM killer because it
turns out it is killing tasks that have had their oom_adj set to -17 (which
is supposed to make them unkillable).

So there are a number of problems, firstly, the child and sibling thread
killing routines do not account for -17 children/siblings.

Secondly, most architecture specific pagefault handlers do a direct kill
of the current process if it takes a VM_FAULT_OOM. This is a pretty rare
thing to happen, because there isn't a lot of higher order allocations
happening, but it is not impossible. I think we can just call into the
OOM killer here, and return to userspace... but I'd like comments about
this.

Thanks,
Nick
--
SuSE Labs
 
