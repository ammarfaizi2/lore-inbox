Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWHHPnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWHHPnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWHHPnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:43:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:42288 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964974AbWHHPnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:43:02 -0400
Message-ID: <44D8B12C.40200@sw.ru>
Date: Tue, 08 Aug 2006 19:43:40 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
References: <44D865FD.1040806@sw.ru> <1155050817.19249.42.camel@localhost.localdomain>
In-Reply-To: <1155050817.19249.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Accessing freed memory is a bug, always, not just *only* when slab
> debugging is on, right?  Doesn't this mean we could get junk, or that
> the reader could potentially run off a bad pointer?
no, read the comment in sys_getppid.
It is a valid optimization. _safe_ and alowing to bypass taking the lock.
BUT! This optimization relies on the fact that kernel memory (DMA + normal zone)
is always mapped into virtual address space.
Which is invalid for debug kernels only.

> It seems that this patch only papers over the problem in the case when
> it is observed, but doesn't really even fix the normal case.
> 
> Could we use a seqlock to determine when real_parent is in flux, and
> re-read real_parent until we get a consistent one?  We could use in in
> lieu of the existing for() loop.

Kirill

