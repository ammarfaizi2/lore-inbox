Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCHSHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCHSHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCHSHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:07:47 -0500
Received: from peabody.ximian.com ([130.57.169.10]:13980 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261458AbVCHSEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:04:31 -0500
Subject: Re: Question regarding thread_struct
From: Robert Love <rml@novell.com>
To: Imanpreet Arora <imanpreet@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c26b959205030809551b3e9670@mail.gmail.com>
References: <c26b959205030809044364b923@mail.gmail.com>
	 <1110302000.23923.14.camel@betsy.boston.ximian.com>
	 <c26b959205030809271b8a5886@mail.gmail.com>
	 <1110302922.28921.3.camel@betsy.boston.ximian.com>
	 <c26b959205030809551b3e9670@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 12:58:13 -0500
Message-Id: <1110304693.28921.11.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 23:25 +0530, Imanpreet Arora wrote:

> Thanks again, but if the whole of the kernel is restricted to couple of pages.

NO.  I did not say this.  EACH PROCESS'S KERNEL STACK IS A PAGE OR TWO.
That is all I said.

The kernel can consume hundreds of megabytes of data if it wants.  And
it does.

> Does this mean
> 
> a) the whole of the kernel including drivers is restricted to couple of pages.

No.  Each process's stack is a page or two.  The rest of the kernel is
free to use a lot of memory.

> b) Or with a more probability, I think what you actually mean is that
> whenever there is an interrupt by any driver it runs in either context
> of the current process or depending upon CONFIG_IRQSTACKS.

Yes, the interrupt runs in the stack of the current process or (given
CONFIG_IRQSTACKS) its own stack.  Dynamic memory is free to come from
all over.

> If you could just quote the chapter, in your book which contains
> information  about this, that would be more than sufficient.

That explains what, exactly?  Kernel stacks are in Ch2 (1ed) and Ch3
(2ed), I think.

> > > b)        Or does it mean that a particular stack for a particular
> > > process, can't be resized?

Yes, a process's kernel stack cannot be resized.

> Actually what I asked above was "how exactly does one define and
> differentiate kernel stack", as against "user-stack". I think I always
> knew it but couple of clouds were coming over after reading your first
> mail. Also if each thread has a kernel stack how is it allocated at
> first place (alloc_thread_info)(?)

The user-space stack is handled by user-space.  It is tracked by
mm_struct->start_stack.

The kernel stack is handled by user-space.  It is stored in esp,
obviously, while inside of the kernel.  And, yes, alloc_thread_info()
allocates the stack.

	Robert Love


