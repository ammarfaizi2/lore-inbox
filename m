Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945985AbWBDJtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWBDJtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWBDJtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:49:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945985AbWBDJtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:49:06 -0500
Date: Sat, 4 Feb 2006 01:48:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from
 cahep->spinlock to l3 lock
Message-Id: <20060204014828.44792327.akpm@osdl.org>
In-Reply-To: <20060204012800.GI3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
	<20060203140748.082c11ee.akpm@osdl.org>
	<Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
	<20060204010857.GG3653@localhost.localdomain>
	<20060204012800.GI3653@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Earlier, we had to disable on chip interrupts while taking the cachep->spinlock
>  because, at cache_grow, on every addition of a slab to a slab cache, we 
>  incremented colour_next which was protected by the cachep->spinlock, and
>  cache_grow could occur at interrupt context.  Since, now we protect the 
>  per-node colour_next with the node's list_lock, we do not need to disable 
>  on chip interrupts while taking the per-cache spinlock, but we
>  just need to disable interrupts when taking the per-node kmem_list3 list_lock.

It'd be nice to have some comments describing what cachep->spinlock
actually protects.

Does __cache_shrink() need some locking to prevent nodes from going offline?
