Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTEIQhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTEIQhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:37:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4368 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263323AbTEIQfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:35:41 -0400
Date: Fri, 9 May 2003 09:48:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Jamie Lokier <jamie@shareable.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: <3EBBD982.9070006@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0305090944420.9705-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 May 2003, Dave Hansen wrote:
> 
> We've been playing with patches in the -mjb tree which make PAGE_OFFSET
> and TASK_SIZE move to some weird values.  I have it to the point where I
> could do a 3.875:0.125 user:kernel split.

That's still not "weird" in the current sense.

We've always (well, for a long time) been able to handle a TASK_SIZE that 
has a 111..00000 pattern - and in fact we used to _depend_ on that kind of 
pattern, because macros like "virt_to_phys()" were simple bitwise-and 
operations. There may be some code in the kernel that still depends on 
that kind of bitwise operation with TASK_SIZE.

Your 3.875:0.125 split still fits that pattern, and thus doesn't create 
any new cases.

In contrast, a TASK_SIZE of 0xc1000000 can no longer just "mask off" the 
kernel address bits. And _that_ is what I meant with "strange value".

		Linus

