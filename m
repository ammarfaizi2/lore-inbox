Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVCQXws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVCQXws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCQXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:52:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:64972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261383AbVCQXwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:52:23 -0500
Date: Thu, 17 Mar 2005 15:52:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-Id: <20050317155208.22b72984.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503171518030.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	<20050317140831.414b73bb.akpm@osdl.org>
	<Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
	<20050317151151.47fd6e5f.akpm@osdl.org>
	<Pine.LNX.4.58.0503171518030.10205@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> > And given that we have separate buddy structures for zeroed and not-zeroed
>  > pages, why is this tagging needed at all?
> 
>  Because the buddy pointers may point to a page of the different kind. Then
>  a merge is not possible.

In that case I still don't understand, sorry.

If each zone has two buddy lists, one for zeroed and one for not-zeroed,
how can we ever get known-to-be-zeroed pages on the not-known-to-be-zeroed
list or vice versa?

>  > These are all design decisions which have been made, but they're not
>  > communicated either in the patch description or in code comments.  It's to
>  > everyone's advantage to fix that, no?
> 
>  Of course. Try to do this ASAP. Testing a patch that defines the
>  following:
> 
>  Index: linux-2.6.11/include/linux/gfp.h
>  ===================================================================
>  --- linux-2.6.11.orig/include/linux/gfp.h       2005-03-01
>  23:37:50.000000000 -0800
>  +++ linux-2.6.11/include/linux/gfp.h    2005-03-17 14:59:06.000000000
>  -0800
>  @@ -125,6 +125,8 @@ extern void FASTCALL(__free_pages(struct
>   extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
>   extern void FASTCALL(free_hot_page(struct page *page));
>   extern void FASTCALL(free_cold_page(struct page *page));
>  +extern void FASTCALL(free_hot_zeroed_page(struct page *page));
>  +extern void FASTCALL(free_cold_zeroed_page(struct page *page));
> 
>   #define __free_page(page) __free_pages((page), 0)
>   #define free_page(addr) free_pages((addr),0)
> 
>  This is what you want right?

Well, it was more a question that a request.  If we do this, does it speed
anything up?

