Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBVVU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBVVU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBVVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:20:27 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:7907 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261253AbVBVVUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:20:17 -0500
Message-ID: <421BA1FD.8030108@nortel.com>
Date: Tue, 22 Feb 2005 15:19:57 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Andrew Morton <akpm@osdl.org>, Olof Johansson <olof@austin.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org>
In-Reply-To: <20050222210752.GG22555@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> In futex.c:
> 
> 	down_read(&current->mm->mmap_sem);
> 	get_futex_key(...) etc.
> 	queue_me(...) etc.
> 	current->flags |= PF_MMAP_SEM;             <- new
> 	ret = get_user(...);
> 	current->flags &= PF_MMAP_SEM;             <- new
> 	/* the rest */

Should the second new line be this (with the inverse)?

	current->flags &= ~PF_MMAP_SEM;


Chris
