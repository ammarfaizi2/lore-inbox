Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUIIXzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUIIXzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUIIXzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:55:32 -0400
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:39931 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S264443AbUIIXza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:55:30 -0400
Message-ID: <4140ED57.3090704@quark.didntduck.org>
Date: Thu, 09 Sep 2004 19:55:03 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <20040909232532.GA13572@taniwha.stupidest.org>
In-Reply-To: <20040909232532.GA13572@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
X-Charter-Score: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> Right now CONFIG_4KSTACKS implies IRQ-stacks.  Some people though
> really need 8K stacks and it would be nice to have IRQ-stacks for them
> too.
> 
> This splits the option in two with the intention of removing the
> IRQ-stacks option completely.
> 
>  arch/i386/Kconfig.debug        |   13 ++++++++++---
>  arch/i386/defconfig            |    1 -
>  arch/i386/kernel/irq.c         |   14 +++++++-------
>  include/asm-i386/irq.h         |    6 +++---
>  include/asm-i386/module.h      |    6 +++---
>  include/asm-i386/thread_info.h |    6 +++---
>  6 files changed, 26 insertions(+), 20 deletions(-)
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> 
> 
> 
> diff -Nru a/arch/i386/Kconfig.debug b/arch/i386/Kconfig.debug
> --- a/arch/i386/Kconfig.debug	2004-09-09 16:06:04 -07:00
> +++ b/arch/i386/Kconfig.debug	2004-09-09 16:06:04 -07:00
> @@ -46,14 +46,21 @@
>  	  This results in a large slowdown, but helps to find certain types
>  	  of memory corruptions.
>  
> -config 4KSTACKS
> +config I386_4KSTACKS
>  	bool "Use 4Kb for kernel stacks instead of 8Kb"

What's the point of changing 4KSTACKS to I386_4KSTACKS?  Best to just 
leave this alone as external code is likely to check it.

--
				Brian Gerst
