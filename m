Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUGCUXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUGCUXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUGCUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:23:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:54224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265247AbUGCUXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:23:23 -0400
Date: Sat, 3 Jul 2004 13:22:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc 1/3: Add refcount to ipc_rcu_alloc
Message-Id: <20040703132217.2754ea75.akpm@osdl.org>
In-Reply-To: <40E6EE71.9050402@colorfullife.com>
References: <40E6EE71.9050402@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> the lifetime of the ipc objects (sem array, msg queue, shm mapping) is 
>  controlled by kern_ipc_perms->lock - a spinlock. There is no simple way 
>  to reacquire this spinlock after it was dropped to 
>  schedule()/kmalloc/copy_{to,from}_user/whatever.
> 
>  The attached patch adds a reference count as a preparation to get rid of 
>  sem_revalidate().

The pointer offsetting tricks are rather unattractive.  Is it not possible
to simple aggregate the refcount into the refcounted structure, use
container_of()?

