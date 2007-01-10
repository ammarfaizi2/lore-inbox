Return-Path: <linux-kernel-owner+w=401wt.eu-S965114AbXAJWRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbXAJWRL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbXAJWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:17:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58441 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965114AbXAJWRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:17:09 -0500
Date: Wed, 10 Jan 2007 14:16:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] mm: pagefault_{disable,enable}()
In-Reply-To: <Pine.LNX.4.64.0701102256410.4331@anakin>
Message-ID: <Pine.LNX.4.64.0701101413130.3594@woody.osdl.org>
References: <200612071659.kB7GxGHa030259@hera.kernel.org>
 <Pine.LNX.4.64.0701102256410.4331@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2007, Geert Uytterhoeven wrote:
> 
> This change causes lots of compile errors of the following form on m68k:
> 
> | linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_disable':
> | linux-2.6.20-rc4/include/linux/uaccess.h:18: error: dereferencing pointer to incomplete type
> | linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_enable':
> | linux-2.6.20-rc4/include/linux/uaccess.h:33: error: dereferencing pointer to incomplete type

Ouch. However, I think your patch is bogus.

You're fixing somethign that doesn't need fixing: <linux/uaccess.h> 
already includes <linux/preempt.h> for the preemption functions.

The REAL problem seems to be that the m68k preempt.h (or rather, to be 
exact, asm/thread_info.h) doesn't do things right, and while it exposes 
"inc_preempt_count()", it doesn't expose enough information to actually 
use it.

I think your "current_thread_info()" is broken.

		Linus
