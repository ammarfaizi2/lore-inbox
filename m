Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWGXWIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWGXWIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGXWIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:08:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:59779 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932276AbWGXWIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:08:45 -0400
Subject: Re: [patch] inotify: fix deadlock found by lockdep
From: Robert Love <rml@novell.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Ingo Molnar <mingo@elte.hu>,
       John McCutchan <john@johnmccutchan.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, rml@ximian.com,
       viro@zeniv.linux.org.uk
In-Reply-To: <1153761671.3043.89.camel@laptopd505.fenrus.org>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <44C2C90B.6090108@reub.net>
	 <1153761671.3043.89.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 18:08:37 -0400
Message-Id: <1153778917.2808.14.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 19:21 +0200, Arjan van de Ven wrote:

> inotify_dev_queue_event schedules a kernel_event which does a
> kmem_cache_alloc( , GFP_KERNEL) which may try to shrink slabs, including
> the inode cache .. which then takes iprune_mutex. 
> 
> And voila, there is an AB, a BC, a CD relationship (even a direct BCD),
> and also now a DA relationship -> a circular type AB-BA deadlock but
> involving 4 locks.
> 
> The solution is simple: kernel_event() is NOT allowed to use GFP_KERNEL,
> but must use GFP_NOFS to not cause recursion into the VFS.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Nice catch.

Signed-off-by: Robert Love <rml@novell.com>

	Robert Love


