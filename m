Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbSIPXxK>; Mon, 16 Sep 2002 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbSIPXxK>; Mon, 16 Sep 2002 19:53:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15112
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263405AbSIPXxJ>; Mon, 16 Sep 2002 19:53:09 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209161644210.2029-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209161644210.2029-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 19:58:09 -0400
Message-Id: <1032220689.1203.85.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 19:45, Linus Torvalds wrote:

> Ahhah! I know. You just make lock_depth 0 when you exit, without actually 
> taking the kernel lock. Which fools the logic into accepting a 
> preempt-disable, since it thinks that the preempt disable is due to 
> holding the kernel lock.

I was this -> <- close to celebrating.  Not so fast, smarty.

What about release_kernel_lock() ?

It sees task->lock_depth>=0 and calls spin_unlock() on a lock that it
does not hold.

	Robert Love

