Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUEKCjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUEKCjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 22:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEKCjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 22:39:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:63968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261369AbUEKCji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 22:39:38 -0400
Date: Mon, 10 May 2004 19:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040510193901.59cebd6a.akpm@osdl.org>
In-Reply-To: <200405102031.i4AKVXLg022041@eeyore.valparaiso.cl>
References: <c7om3o$akd$1@gatekeeper.tmr.com>
	<200405102031.i4AKVXLg022041@eeyore.valparaiso.cl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> Bill Davidsen <davidsen@tmr.com> said:
> 
> [...]
> 
> > I tried 4k stack, I couldn't measure any improvement in anything (as in 
> > no visible speedup or saving in memory).
> 
> 4K stacks lets the kernel create new threads/processes as long as there is
> free memory; with 8K stacks it needs two consecutive free page frames in
> physical memory, when memory is fragmented (and large) they are hard to
> come by...

This is true to a surprising extent.  A couple of weeks ago I observed my
256MB box freeing over 20MB of pages before it could successfully acquire a
single 1-order page.

That was during an updatedb run.

And a 1-order GFP_NOFS allocation was actually livelocking, because
!__GFP_FS allocations aren't allowed to enter dentry reclaim.  Which is why
VFS caches are now forced to use 0-order allocations.


