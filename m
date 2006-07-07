Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWGGHFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWGGHFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWGGHFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:05:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63371
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751243AbWGGHFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:05:10 -0400
Date: Fri, 07 Jul 2006 00:05:24 -0700 (PDT)
Message-Id: <20060707.000524.112600047.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607060937.k669bZT3017256@harpo.it.uu.se>
References: <200607060937.k669bZT3017256@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 6 Jul 2006 11:37:35 +0200 (MEST)

> On Wed, 05 Jul 2006 20:40:36 -0700 (PDT), David Miller wrote:
> >> I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
> >> something PCI-related, presumably the ATI card. The protection
> >> bits passed into io_remap_pfn_range() are 0x80...0788, while
> >> pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
> >> which, if I read things correctly, means that _PAGE_W_4U and
> >> _PAGE_MODIFIED_4U don't get set any more.
> >> 
> >> I guess something else in the kernel should have set those
> >> bits before they got to io_remap_pfn_range()?
> >
> >The problem is with X, it should not be doing a MAP_SHARED
> >mmap() of the framebuffer device.  It should be using
> >MAP_PRIVATE instead.
> >
> >The kernel is trying to provide copy-on-write semantics for
> >the mapping, which doesn't make any sense for device registers.
> >That's why the kernel isn't setting the writable or modified
> >bits in the protection bitmask.
> 
> Now I'm confused. That COW behaviour would be consistent with
> MAP_PRIVATE, not MAP_SHARED which is what X did use.

Yes, I'm totally wrong here, MAP_SHARED is correct.

I'll have to figure out how the writeable bits get lost
in the call chain.

Thanks.
