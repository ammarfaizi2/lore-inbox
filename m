Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTKJSGC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTKJSGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:06:02 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:28032 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263064AbTKJSF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:05:58 -0500
Date: Mon, 10 Nov 2003 19:05:51 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
Message-ID: <20031110180551.GA20168@vana.vc.cvut.cz>
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com> <3FAFC831.4090108@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFC831.4090108@colorfullife.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 06:17:37PM +0100, Manfred Spraul wrote:
> DEBUG_PAGEALLOC unmaps pages on kmem_cache_free and __free_pages(). The 
> pages are mapped again during get_free_pages and kmem_cache_alloc.
> 
> 0x86000 looks like a normal page - what guarantees that it's not used by 
> the kernel?

With DEBUG_PAGEALLOC there is no problem with page if it is USED by the kernel.
Problem is if page is NOT USED - in this case kernel does not have it in its
mapping, and bad thing happen.

x86info (and other simillar tools for dumping different BIOS structures) just
scans physical memory for some well known signatures - hoping that kernel did
not smash these structures.

Up to now it was possible to read whole physical memory from userspace - some 
pages by reading /dev/mem, some pages by mmaping /dev/mem. Now it is not possible 
anymore - which I think is bad, as /dev/mem has semantic of it. Manual (mem(4)) 
says that "mem is a character device file that is an image of the main memory 
of the computer. It may be used, for example, to examine (and even patch) the 
system." I have no idea what POSIX says about /dev/mem being unreadable...

Thanks anyway. As DEBUG_PAGEALLOC did not catch memory corruption I'm seeing,
I'll disable it.
							Best regards,
								Petr Vandrovec


