Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVLSEoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVLSEoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLSEoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:44:12 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27356 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030255AbVLSEoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:44:11 -0500
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013718.GA28038@elte.hu>
References: <20051219013718.GA28038@elte.hu>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 23:43:48 -0500
Message-Id: <1134967428.13138.227.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> +static inline void
> +__mutex_wakeup_waiter(struct mutex *lock __IP_DECL__)
> +{
> +       struct mutex_waiter *waiter;
> +
> +       SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
> +       DEBUG_WARN_ON(list_empty(&lock->wait_list));
> +
> +       /*
> +        * Get the first entry from the wait-list:
> +        */
> +       waiter = list_entry(lock->wait_list.next, struct mutex_waiter,
> list);
> +

Any thought about adding priorities to the queue here? Maybe another
time we can add the plist?  But maybe I'm getting ahead of myself.

-- Steve


