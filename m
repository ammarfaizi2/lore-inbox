Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTEaTB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTEaTB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:01:27 -0400
Received: from holomorphy.com ([66.224.33.161]:36502 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264416AbTEaTB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:01:26 -0400
Date: Sat, 31 May 2003 12:14:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk5-2
Message-ID: <20030531191448.GA20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release corrects a showstopping list handling bug in the pgd slab
management code. When PAGE_MMUCOUNT > 1, the pgd : struct page relation
becomes N:1, so that pgd_ctor() and pgd_dtor() may be called multiple
times for each page dedicated to the pgd slab. The bug was that
pgd_ctor() did an unconditional list_add(&page->lru, &pgd_list) and
pgd_dtor() did an unconditional list_del(&page->lru, &pgd_list)
regardless of whether the page backing the pgd's passed as an argument
was already on the pgd_list. There was also a bug in pageattr.c where
the pieces of a pgd slab page weren't iterated over when looping over
pgd slab pages.

A minor highmem compilefix and a fixes for /proc/vmstat reporting
inaccuracies are also included.

pgcl-2.5.70-bk5-2 survives a couple of hours of running dbench and
tiobench in a loop.

Available as an incremental patch atop pgcl-2.5.70-bk5-1 from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
