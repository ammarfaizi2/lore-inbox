Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVCJSze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVCJSze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVCJSqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:46:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:45966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262863AbVCJSid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:38:33 -0500
Date: Thu, 10 Mar 2005 10:40:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
In-Reply-To: <20050310123714.GA22068@attica.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0503101034400.2530@ppc970.osdl.org>
References: <20050310123714.GA22068@attica.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Robin Holt wrote:
> 
> reparent_to_init() does write_lock_irq(&tasklist_lock) then calls
> switch_uid() which calls free_uid() which grabs the uidhash_lock.
> 
> Independent of that, we have seen a different cpu call free_uid as a
> result of sys_wait4 and, immediately after acquiring the uidhash_lock,
> receive a timer interrupt which eventually leads to an attempt to grab
> the tasklist_lock.

Hmm..  We fixed this already, and the current tree doesn't have this 
problem (and the fix was much simpler: just move "switch_uid()" to outside 
the tasklist_lock.

That fix was done late december last year (current BK revision: 
1.1938.446.38), and I really think your patch is stale. Please 
double-check,

		Linus
