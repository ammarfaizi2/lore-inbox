Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUEWJVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUEWJVn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUEWJVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:21:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:60879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbUEWJVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:21:42 -0400
Date: Sun, 23 May 2004 02:20:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: arjanv@redhat.com, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-Id: <20040523022058.19661c67.akpm@osdl.org>
In-Reply-To: <20040523084415.GB16071@alpha.home.local>
References: <20040522234059.GA3735@infradead.org>
	<1085296400.2781.2.camel@laptop.fenrus.com>
	<20040523084415.GB16071@alpha.home.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
>
>  On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
>  > on first look it seems to be missing a bunch of get_user() calls and
>  > does direct access instead....
> 
>  It was intentional for speed purpose. The areas are checked once with
>  verify_area() when we need to access memory, then data is copied directly
>  from/to memory. I don't think there's any risk, but I can be wrong.

verify_area() simply checks that the address is a legal one for a userspace
access (it's not a chunk of kernel memory).  But the kernel can still take
a pagefault when accessing the address, so you need to use the uaccess
functions which will handle the fault appropriately.

That's put_user(), get_user(), copy_*_user(), etc.  Those functions
internally perform verify_area(), so if you've already done a verify_area()
you can use __put_user(), __get_user(), etc which skip the verify_area()
but which still know how to deal with user address faults.

