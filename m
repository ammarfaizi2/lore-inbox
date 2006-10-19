Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946078AbWJSHl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946078AbWJSHl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946079AbWJSHl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:41:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946078AbWJSHl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:41:27 -0400
Date: Thu, 19 Oct 2006 00:41:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: dmonakhov@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm:D-cache aliasing issue in cow_user_page
Message-Id: <20061019004118.37741cad.akpm@osdl.org>
In-Reply-To: <20061019.002237.130236131.davem@davemloft.net>
References: <20061018233302.a067d1e7.akpm@osdl.org>
	<20061019.000027.41635681.davem@davemloft.net>
	<20061019001747.7da58920.akpm@osdl.org>
	<20061019.002237.130236131.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 00:22:37 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> > > Architectures typically take care of this in copy_user_page() and
> > > clear_user_page().  The absolutely depend upon those two routines
> > > being used for anonymous pages, and handle the D-cache issues there.
> > 
> > Only anonymous pages?  There are zillions of places where we modify
> > pagecache without a flush, especially against the blockdev mapping (fs
> > metadata).
> 
> It's cpu stores that matter, not device DMA and the like, and we have
> flush_dcache_page() calls in the correct spots.  You can see that
> we take care of this even in places such as the loop driver :-)

grep b_data fs/*/*.c

All of them ;)

It's possible to mmap /dev/hda, but it's a rather odd thing to do (INND
can do it, but not a live filesystem).

