Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUDHT35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUDHT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:29:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:29081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262347AbUDHT3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:29:53 -0400
Date: Thu, 8 Apr 2004 12:29:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] order>0 page freeing bug
Message-Id: <20040408122936.49a008d5.akpm@osdl.org>
In-Reply-To: <5213.1081441917@redhat.com>
References: <5213.1081441917@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Here's a patch to fix a bug that occurs when an order>0 page allocation is
>  freed.
> 
>  The bug can be demonstrated by this example:
> 
>   (1) if __alloc_page() returns an order 1 allocation, you get back two pages,
>       both with count == 1
> 
>   (2) __free_pages() only decrements the counter on the first page
> 
>   (3) __free_pages_ok() calls free_pages_check() on both pages
> 
>   (4) free_pages_check() complains that the second page is a bad_page because
>       its count is not 0 at that point.

That doesn't sound right - if this was the case, each and every order>0
page freeing would be generating warnings, would it not?

