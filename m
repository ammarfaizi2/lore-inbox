Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267544AbUHWWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUHWWSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUHWWP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:15:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:56261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268080AbUHWWM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:12:57 -0400
Date: Mon, 23 Aug 2004 15:16:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "bradgoodman.com" <bkgoodman@bradgoodman.com>
Cc: Atul.Mukker@lsil.com, bgoodman@acopia.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, torvalds@osdl.org
Subject: Re: [PATCH] 2.6.8.1 MegaRAID Driver Race
Message-Id: <20040823151614.278a5ee4.akpm@osdl.org>
In-Reply-To: <200408232157.i7NLvmB30968@bradgoodman.com>
References: <200408232157.i7NLvmB30968@bradgoodman.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bradgoodman.com" <bkgoodman@bradgoodman.com> wrote:
>
> [PATCH] 2.6.8.1 to LSI Logic MegaRAID Adapter - ioctl function calls 
> mega_internal_command, which uses wait_event, which calls schedule.
> This means schedule() is called while big kernel_lock is held.
> 
> Locks/Unlocks were done here because 
> 
> 1. There are a lot of return()s in the ioctl function to dodge.
> 2. mega_internal_command is also called by read and writes,
>    which don't hold big kernel_lock

Calling schedule() inside lock_kernel() is legal.

It may, however, be wrong within the context of the particular caller
because schedule() will drop the lock.  So new races might have been
introduced.
