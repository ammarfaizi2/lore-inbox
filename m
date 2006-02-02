Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWBBO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWBBO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBBO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:29:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:6057 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751088AbWBBO3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:29:23 -0500
Date: Thu, 2 Feb 2006 15:29:17 +0100
From: Olaf Hering <olh@suse.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce __iowrite32_copy
Message-ID: <20060202142917.GA10870@suse.de>
References: <200602011820.k11IKUBo024575@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200602011820.k11IKUBo024575@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Feb 01, Linux Kernel Mailing List wrote:

> tree c4d797b413bb6f8a1b8507213294a291ab5114f8
> parent f7589f28d7dd4586b4e90ac3b2a180409669053a
> author Bryan O'Sullivan <bos@pathscale.com> Wed, 01 Feb 2006 19:05:16 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 02 Feb 2006 00:53:13 -0800
> 
> [PATCH] Introduce __iowrite32_copy
> 
> This arch-independent routine copies data to a memory-mapped I/O region,
> using 32-bit accesses.  The naming is double-underscored to make it clear
> that it does not guarantee write ordering, nor does it perform a memory
> barrier afterwards; the kernel doc also explicitly states this.  This style
> of access is required by some devices.
> 
> This change also introduces include/linux/io.h, at Andrew's suggestion.  It
> only has one occupant at the moment, but is a logical destination for
> oft-replicated contents of include/asm-*/{io,iomap}.h to migrate to.

> +++ b/lib/iomap_copy.c

> +void __attribute__((weak)) __iowrite32_copy(void __iomem *to,
> +					    const void *from,
> +					    size_t count)
> +{
> +	u32 __iomem *dst = to;
> +	const u32 *src = from;
> +	const u32 *end = src + count;
> +
> +	while (src < end)
> +		__raw_writel(*src++, dst++);
> +}

lib/iomap_copy.c: In function '__iowrite32_copy':
lib/iomap_copy.c:40: error: implicit declaration of function '__raw_writel'

We compile with -Werror-implicit-function-declaration, and s390 does not
have a __raw_writel.
Should it just define __raw_writel to writel, like uml does a few
commits later?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
