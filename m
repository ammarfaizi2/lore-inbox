Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVEMT5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVEMT5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVEMTxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:53:50 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:6007 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262474AbVEMTty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:49:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=igHNyDnt8ayusQ+5Qp2ZrQAqZrwXGwmOpL5dvDOY7RiU0eFwyAa320tCZyKPwKZ9wHnE48Cce6BDAVTNybBjrjyg20oqbtxiZ8uJr8xHe/87RXo08RkWcVuWkuBa721kxd6MD9Tocs/7Ijggcg1PD6R2wrqvmhDaUqGI7Pn4V5A=
Message-ID: <fc67f8b705051312494a0badf7@mail.gmail.com>
Date: Fri, 13 May 2005 15:49:48 -0400
From: Ritesh Kumar <digitalove@gmail.com>
Reply-To: ritesh@cs.unc.edu
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: NPTL: stack limit limiting number of threads
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
     I recently had a chance to benchmark Linux/NPTL vs FreeBSD to
compare thread creation performance on both the systems. Let me not
disclose the results as I am sure my methodology is not the best one
;-). However, I did notice something queer which I would like to
discuss.
    I noticed that on my system (which has a 3G:1G split linux-2.6.1
NPTL gentoo), with the (possibly default) stack size limit of 8M, I
couldn't create more than around 380 threads in a process. On
searching the web, I found that a reason for this could be that in 3G
of userspace, there is space for exactly 384 8M chunks of memory.
Thus, because it is not possible to create more than 384 thread stacks
in the user space, the NPTL disallows creation of threads greater than
around 380. When I reduced the stack limit (using ulimit in bash), I
could create enough number of threads for my benchmarks to run
properly.
However, I was most amazed to see that the limit on stack size on
FreeBSD (5.3 Release) was 64M by default! I was just wondering, how is
FreeBSD able to create about a 1000 threads with that kind of a stack
limit. Also, is there anything specific in its implementation which
makes it difficult to incorporate in Linux? Wouldn't it be a good idea
to remove this "trade-off" between stack limit and number of threads
and fail thread creation only when we have run out of address space
being *actually used* in the stacks in a process.

Ritesh
-- 
http://www.cs.unc.edu/~ritesh/
