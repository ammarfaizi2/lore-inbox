Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270955AbUJUUbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270955AbUJUUbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270949AbUJUU05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:26:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55755 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270938AbUJUUXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:23:09 -0400
Subject: Re: [PATCH] kernel/timer.c: xtime lock missing
From: john stultz <johnstul@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021190312.GA30847@kvack.org>
References: <20041021190312.GA30847@kvack.org>
Content-Type: text/plain
Message-Id: <1098390198.20778.226.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 13:23:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 12:03, Benjamin LaHaise wrote:
> Hello all,
> 
> While looking at the time keeping code for related work, I came across 
> the following bug.  During 2.5 development, the smptimers patch removed 
> a lock from update_times() that is actually needed over the xtime 
> update, since the second overflow is not an atomic operation.  This 
> patch fixes that by doing a write_seqlock() over the course of the 
> update.

Errrr... 

Looking at the comment above that function, the xtime_lock should
already be held when executing that code. timer_interrupt() should be
the function which grabs the lock and calls do_timer_interrupt() then
do_timer() then update_times().

Or am I missing something?

thanks
-john



