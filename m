Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTEFCpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTEFCpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:45:51 -0400
Received: from rth.ninka.net ([216.101.162.244]:32431 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262273AbTEFCpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:45:44 -0400
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030505185248.3c3a478f.akpm@digeo.com>
References: <20030505014729.5db76f70.akpm@digeo.com>
	 <20030506012846.18DD62C568@lists.samba.org>
	 <20030505185248.3c3a478f.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052187119.983.5.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 19:11:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 18:52, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > OK.  It has a size restriction: PERCPU_POOL_SIZE is the maximum total
> > kmalloc_percpu + static DECLARE_PER_CPU you'll get, ever.  This is the
> > main downside.  It's allocated at boot.
> 
> And is subject to fragmentation.
> 
> Is it not possible to go allocate another N * PERCPU_POOL_SIZE from
> slab if it runs out?

No, then you go back to things requireing multiple levels of
dereferencing.  It's hard to realloc() because you have to
freeze the whole kernel to do that properly, and that is not
simple at all.

I think the fixed size pool is perfectly reasonable.

-- 
David S. Miller <davem@redhat.com>
