Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUGCWpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUGCWpW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 18:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUGCWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 18:45:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:55234 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265276AbUGCWpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 18:45:19 -0400
Date: Sat, 3 Jul 2004 15:44:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc 1/3: Add refcount to ipc_rcu_alloc
Message-Id: <20040703154412.1d03ed41.akpm@osdl.org>
In-Reply-To: <40E72AB7.50802@colorfullife.com>
References: <40E6EE71.9050402@colorfullife.com>
	<20040703132217.2754ea75.akpm@osdl.org>
	<40E72AB7.50802@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> +struct ipc_rcu_hdr
>  +{
>  +	int refcount;
>  +	int is_vmalloc;
>  +	void *data[0];
>  +};

That's not what I meant ;)

struct ipc_rcu_hdr
{
	int refcount;
	int is_vmalloc;
};

Then place one of these inside struct msg_queue, one inside struct
sem_array, etc.

#define ipc_rcu_putref(p)
	if (--p->rcu_hdr.refcount == 0)
		ipc_rcu_putref_final(p, &p->rcu_hdr)

or whatever.

That's assuming struct kref isn't suitable.  I guess you don't want the
atomic_t.
