Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbUKRDMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUKRDMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRDKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:10:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:49380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262395AbUKRDKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:10:03 -0500
Date: Wed, 17 Nov 2004 19:09:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Ian.Pratt@cl.cam.ac.uk, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-Id: <20041117190933.16e8b8ed.akpm@osdl.org>
In-Reply-To: <200411180508.iAI58iQ3007886@ccure.user-mode-linux.org>
References: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk>
	<200411180508.iAI58iQ3007886@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> Ian.Pratt@cl.cam.ac.uk said:
> > Pages that have been allocated by our custom allocators get passed
> > into standard linux subsystems where we get no control over how
> > they're freed. We want the normal page ref counting etc to happen as
> > per normal, we just want to intercept the final free so that we can
> > return it to our allocator rather than the standard one.
> 
> I have to agree with Dave - this is just a wierd solution.  I added 
> arch_free_page to do arch-specific, invisible-to-the-generic-kernel things.
> My intent may not be the be-all and end-all for this, but I think the semantics
> you want to add to it are not that reasonable.
> 
> My gut reaction (without knowing your problem in any detail) would be that 
> you need too add some more structure to whatever mechanism you have
> so that the pages land in your allocator automatically, like a slab or a new
> zone or something.
> 

I can't immediately think of any way of doing that.

One could perhaps hide it with

#ifdef CONFIG_ZEN
#define __free_pages_ok xen_free_page
#else
#define __free_pages_ok everybody_else_free_page
#endif

and rename __free_pages_ok() to everybody_else_free_page().

But heck - why bother?  The current patch adds just one line of code in one
place, and the compiler will toss it away anyway for all but xen and um.

I think we can live with that.
