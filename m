Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUKBXBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUKBXBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUKBXBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:01:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:18618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261847AbUKBXA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:00:59 -0500
Date: Tue, 2 Nov 2004 15:04:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: andrea@novell.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-Id: <20041102150426.4102e225.akpm@osdl.org>
In-Reply-To: <41880E0A.3000805@us.ibm.com>
References: <4187FA6D.3070604@us.ibm.com>
	<20041102220720.GV3571@dualathlon.random>
	<41880E0A.3000805@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> Andrea Arcangeli wrote:
> > Still I recommend investigating _why_ debug_pagealloc is violating the
> > API. It might not be necessary to wait for the pageattr universal
> > feature to make DEBUG_PAGEALLOC work safe.
> 
> This makes the DEBUG_PAGEALLOC stuff symmetric enough to boot for me, 
> and it's pretty damn simple.  Any ideas for doing this without bloating 
> 'struct page', even in the debugging case?

You could use a bit from page->flags.  But CONFIG_DEBUG_PAGEALLOC uses so
much additional memory nobody would notice anyway.

hm.  Or maybe page->mapcount is available on these pages.
