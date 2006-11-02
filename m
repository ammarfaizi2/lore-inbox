Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWKBUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWKBUER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWKBUER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:04:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752141AbWKBUEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:04:16 -0500
Date: Thu, 2 Nov 2006 12:04:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: Franck <vagabon.xyz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH update6] drivers: add LCD support
Message-Id: <20061102120412.bc25e2d0.akpm@osdl.org>
In-Reply-To: <653402b90611021133i35683ac4i5f4da4098373603c@mail.gmail.com>
References: <20061101014057.454c4f43.maxextreme@gmail.com>
	<4549B19C.70304@innova-card.com>
	<653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
	<454A0006.4090505@innova-card.com>
	<653402b90611020644m57dac018r443fc91bccf6db0c@mail.gmail.com>
	<20061102111311.1b2648c3.akpm@osdl.org>
	<653402b90611021133i35683ac4i5f4da4098373603c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 19:33:48 +0000
"Miguel Ojeda" <maxextreme@gmail.com> wrote:

> May 2.6.18-new vmalloc
> related functions help correlating userspace & kernel addresses? I
> will try them and come with an answer tomorrow.
> 
> Quoting http://lwn.net/Articles/2.6-kernel-api/
> 
> "Some functions have been added to make it easy for kernel code to
> allocate a buffer with vmalloc() and map it into user space. They are:
> 
>      void *vmalloc_user(unsigned long size);
>      void *vmalloc_32_user(unsigned long size);
>      int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
>                              unsigned long pgoff);
> 
> The first two functions are a form of vmalloc() which obtain memory
> intended to be mapped into user space; among other things, they zero
> the entire range to avoid leaking data. vmalloc_32_user() allocates
> low memory only. A call to remap_vmalloc_range() will complete the
> job; it will refuse, however, to remap memory which has not been
> allocated with one of the two functions above."

No, it doesn't look like those helper functions are designed to handle this.

I'm really not the person to be asking about this.  I can poke around in
arch/sparc64/kernel/sys_sparc.c:arch_get_unmapped_area() as well as the
next guy, and it seems to be doing the right thing for MAP_FIXED, but
how/whether it handles !MAP_FIXED I do not know.  Ask davem ;)
