Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUJ3VJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUJ3VJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUJ3VJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:09:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:9677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261321AbUJ3VJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:09:37 -0400
Date: Sat, 30 Oct 2004 14:07:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-Id: <20041030140732.2ccc7d22.akpm@osdl.org>
In-Reply-To: <20041030141059.GA16861@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> I think it's much better to have PG_zero in the main page allocator than
>  to put the ptes in the slab. This way we can share available zero pages with
>  all zero-page users and we have a central place where people can
>  generate zero pages and allocate them later efficiently.

Yup.

>  This gives a whole internal knowledge to the whole buddy system and
>  per-cpu subsystem of zero pages.

Makes sense.  I had a go at this ages ago and wasn't able to demonstrate
much benefit on a mixed workload.

I wonder if it would help if the page zeroing in the idle thread was done
with the CPU cache disabled.  It should be pretty easy to test - isn't it
just a matter of setting the cache-disable bit in the kmap_atomic()
operation?

There are quite a few patches happening in this area - the
make-kswapd-aware-of-higher-order-pages patches and the no-buddy-bitmap
patches are queued in -mm.  It'll take some time to work through them
all...
