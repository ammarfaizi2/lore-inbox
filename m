Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVCHRfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVCHRfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVCHRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:35:00 -0500
Received: from peabody.ximian.com ([130.57.169.10]:57755 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261370AbVCHRe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:34:58 -0500
Subject: Re: Question regarding thread_struct
From: Robert Love <rml@novell.com>
To: Imanpreet Arora <imanpreet@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c26b959205030809271b8a5886@mail.gmail.com>
References: <c26b959205030809044364b923@mail.gmail.com>
	 <1110302000.23923.14.camel@betsy.boston.ximian.com>
	 <c26b959205030809271b8a5886@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 12:28:42 -0500
Message-Id: <1110302922.28921.3.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:57 +0530, Imanpreet Arora wrote:

> This has been a doubt for a couple of days, and I am wondering if this
> one could also be cleared. When you say kernel stack, can't be resized
> 
> 
> a)       Does it mean that the _whole_ of the kernel is restricted to
> that 8K or 16K of memory?

Actually, 4K or 8K these days for x86.  But, no, it means that EACH
PROCESS is constrained to the kernel stack.  The stacks are per-process.
The kernel never "runs on its own" -- it is always in the context of a
process (which has its own kernel stack) or an interrupt handler (which
either shares the previous process's stack or has its own stack,
depending on CONFIG_IRQSTACKS).

> b)        Or does it mean that a particular stack for a particular
> process, can't be resized?

Yes, I just said that in the previous email.  The kernel stack cannot be
resized.  It is fixed.  It is one or two pages, depending on configure
option.  That is, 4 or 8K.

The _user-space_ stack, what the application actually uses, is
dynamically resizable.  But we are not talking about that.

> c)         And for that matter how exactly do we define a kernel stack?

I don't know what you mean.  alloc_thread_info() creates the thread_info
structure and stack.

	Robert Love


