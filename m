Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVBWOuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVBWOuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 09:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBWOuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 09:50:06 -0500
Received: from users.ccur.com ([208.248.32.211]:509 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261242AbVBWOuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 09:50:00 -0500
Date: Wed, 23 Feb 2005 09:49:40 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Olof Johansson <olof@austin.ibm.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223144940.GA880@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 01:30:27PM -0800, Linus Torvalds wrote:
> 
> We really have this already, and it's called "current->preempt". It 
> handles any lock at all, and doesn't add yet another special case to all 
> the architectures.
> 
> Just do
> 
> 	repeat:
> 		down_read(&current->mm->mmap_sem);
> 		get_futex_key(...) etc.
> 		queue_me(...) etc.
> 		inc_preempt_count();
> 		ret = get_user(...);
> 		dec_preempt_count();

Perhaps this should be preempt_disable .... preempt_enable.

Otherwise, a preempt attempt in get_user would not be seen
until some future preempt_enable was executed.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey
