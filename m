Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVBWPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVBWPxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBWPxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:53:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:36517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261486AbVBWPxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:53:36 -0500
Date: Wed, 23 Feb 2005 07:54:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Olof Johansson <olof@austin.ibm.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050223144940.GA880@tsunami.ccur.com>
Message-ID: <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
 <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
 <20050223144940.GA880@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Joe Korty wrote:
> 
> Perhaps this should be preempt_disable .... preempt_enable.

No, the problem with preempt_disable/enable is that they go away if 
preemption is not enabled. So you really do have to do it by hand with the 
"inc_preempt_count".

> Otherwise, a preempt attempt in get_user would not be seen
> until some future preempt_enable was executed.

True. I guess we should have a "preempt_check_resched()" there too. That's 
what "kunmap_atomic()" does too (which is what we rely on in the other 
case we do this..)

		Linus
