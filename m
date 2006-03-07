Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWCGXKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWCGXKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWCGXKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:10:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964858AbWCGXKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:10:16 -0500
Date: Tue, 7 Mar 2006 15:12:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: roe@sgi.com, linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH] Prevent NULL pointer deref in grab_swap_token
Message-Id: <20060307151200.7a41943a.akpm@osdl.org>
In-Reply-To: <20060307224926.GA13147@infradead.org>
References: <20060307211344.GA2946@sgi.com>
	<20060307224926.GA13147@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 07, 2006 at 03:13:44PM -0600, Dean Roe wrote:
> > grab_swap_token() assumes that the current process has an mm struct,
> > which is not true for kernel threads invoking get_user_pages().  Since
> > this should be extremely rare, just return from grab_swap_token()
> > without doing anything.
> 
> There's a few things that will break if a kernel thread calls
> get_user_pages, so we should rather fix those.

What things will break?  Anything which dinks with current->mm in or
under get_user_pages() is probably already broken.
