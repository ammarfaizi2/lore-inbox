Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbWAMHrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbWAMHrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWAMHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:47:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161284AbWAMHrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:47:46 -0500
Date: Thu, 12 Jan 2006 23:47:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-Id: <20060112234726.676c3873.akpm@osdl.org>
In-Reply-To: <43C75834.3040007@yahoo.com.au>
References: <20051213193735.GE3092@opteron.random>
	<20051213130227.2efac51e.akpm@osdl.org>
	<20051213211441.GH3092@opteron.random>
	<20051216135147.GV5270@opteron.random>
	<20060110062425.GA15897@opteron.random>
	<43C484BF.2030602@yahoo.com.au>
	<20060111082359.GV15897@opteron.random>
	<20060111005134.3306b69a.akpm@osdl.org>
	<20060111090225.GY15897@opteron.random>
	<20060111010638.0eb0f783.akpm@osdl.org>
	<20060111091327.GZ15897@opteron.random>
	<Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
	<43C75834.3040007@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> (I guess reclaim might be one, but quite rare -- any other significant
>  lock_page users that we might hit?)

The only time 2.6 holds lock_page() for a significant duration is when
bringing the page uptodate with readpage or memset.

The scalability risk here is 100 CPUs all faulting in the same file in the
same pattern.  Like the workload which caused the page_table_lock splitup
(that was with anon pages).  All the CPUs could pretty easily get into sync
and start arguing over every single page's lock.
