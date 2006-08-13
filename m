Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWHMTRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWHMTRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWHMTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:17:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751362AbWHMTRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:17:08 -0400
Date: Sun, 13 Aug 2006 12:17:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, okuji@enbug.org
Subject: Re: [PATCH] failslab - failmalloc for slab allocator
Message-Id: <20060813121702.78e72c1a.akpm@osdl.org>
In-Reply-To: <20060813102219.GA8784@miraclelinux.com>
References: <20060813102219.GA8784@miraclelinux.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 18:22:19 +0800
Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch is not intended for inclusion. But I could find
> several interesting crashes.
> 
> The idea behind failslab is to demonstrate what really happens if
> slab allocation fails. The idea of failslab is completely taken
> from failmalloc (http://www.nongnu.org/failmalloc/).
> 
> boot option:
> 
> failslab=<probability>,<interval>,<times>,<space>
> 
> <probability>
> 	specifies how often it should fail in percent.
> <interval>
> 	specifies the interval of failures.
> <times>
> 	specifies how many times failures may happen at most.
> <space>
> 	specifies the size of free space where memory can be allocated
> 	safely in bytes.
> 
> examples:
> 
> failslab=100,10,-1,0
> 
> slab allocation (kmalloc, kmem_cache_alloc,..) fails once per 10 times.

We would benefit from having some faul-injection capabilities in the
mainline kernel.

- kmalloc failures

- alloc_pages() failures

- disk IO errors (there are rumours of a DM module for this, but I
  haven't seen it).

They would need to be lightweight, clean and enabled/configured at runtime,
not at boot time.

This would end up being a fairly complex project.
