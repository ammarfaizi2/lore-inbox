Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTEFBij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEFBij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:38:39 -0400
Received: from [12.47.58.20] ([12.47.58.20]:46334 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262251AbTEFBii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:38:38 -0400
Date: Mon, 5 May 2003 18:52:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505185248.3c3a478f.akpm@digeo.com>
In-Reply-To: <20030506012846.18DD62C568@lists.samba.org>
References: <20030505014729.5db76f70.akpm@digeo.com>
	<20030506012846.18DD62C568@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 01:51:04.0590 (UTC) FILETIME=[F435BAE0:01C31371]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> > +#define PERCPU_POOL_SIZE 32768
> > 
> > What's this?
> 
> OK.  It has a size restriction: PERCPU_POOL_SIZE is the maximum total
> kmalloc_percpu + static DECLARE_PER_CPU you'll get, ever.  This is the
> main downside.  It's allocated at boot.

And is subject to fragmentation.

Is it not possible to go allocate another N * PERCPU_POOL_SIZE from
slab if it runs out?

That way, PERCPU_POOL_SIZE only needs to be sized for non-modular static
percpu data, which sounds more robust.

