Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWGFJhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGFJhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWGFJhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:37:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10118 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965182AbWGFJhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:37:46 -0400
Date: Thu, 6 Jul 2006 11:37:35 +0200 (MEST)
Message-Id: <200607060937.k669bZT3017256@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, mikpe@it.uu.se
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2006 20:40:36 -0700 (PDT), David Miller wrote:
>> I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
>> something PCI-related, presumably the ATI card. The protection
>> bits passed into io_remap_pfn_range() are 0x80...0788, while
>> pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
>> which, if I read things correctly, means that _PAGE_W_4U and
>> _PAGE_MODIFIED_4U don't get set any more.
>> 
>> I guess something else in the kernel should have set those
>> bits before they got to io_remap_pfn_range()?
>
>The problem is with X, it should not be doing a MAP_SHARED
>mmap() of the framebuffer device.  It should be using
>MAP_PRIVATE instead.
>
>The kernel is trying to provide copy-on-write semantics for
>the mapping, which doesn't make any sense for device registers.
>That's why the kernel isn't setting the writable or modified
>bits in the protection bitmask.

Now I'm confused. That COW behaviour would be consistent with
MAP_PRIVATE, not MAP_SHARED which is what X did use.
