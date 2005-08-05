Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVHEXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVHEXCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVHEXCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:02:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262004AbVHEXCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:02:33 -0400
Date: Fri, 5 Aug 2005 16:02:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stelian Pop <stelian@popies.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
In-Reply-To: <1123278912.8224.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508051558520.3258@g5.osdl.org>
References: <1123278912.8224.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2005, Stelian Pop wrote:
>
> handle_mm_fault changed from an inline function to a non-inline one
> (__handle_mm_fault), which is not available to external kernel modules.
> The patch below fixes this.

We didn't use to export handle_mm_fault before, and it wasn't an inline 
function in 2.6.12 either. 

And no modules I know of call handle_mm_fault(). What module causes 
problems? That's very much a kernel internal function.

IOW, there's something wrong in your setup. It can't have worked on 2.6.12 
either, 

The only thing that has ever exported it afaik is

	arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(handle_mm_fault); /* For MOL */

and that looks pretty suspicious too (what is MOL, and regardless, 
shouldn't it be an EXPORT_SYMBOL_GPL?).

		Linus
