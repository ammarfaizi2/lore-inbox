Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUB0MeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUB0Mbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:31:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:60164 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261810AbUB0M2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:28:52 -0500
Date: Fri, 27 Feb 2004 12:28:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64 iommu rewrite part 2/5
Message-ID: <20040227122849.A31898@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1077883862.22213.365.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1077883862.22213.365.camel@gaston>; from benh@kernel.crashing.org on Fri, Feb 27, 2004 at 11:11:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:11:02PM +1100, Benjamin Herrenschmidt wrote:
> @@ -67,6 +67,14 @@
>  	 * On ia64, we ignore O_SYNC because we cannot tolerate memory attribute aliases.
>  	 */
>  	return !(efi_mem_attributes(addr) & EFI_MEMORY_WB);
> +#elif defined(CONFIG_PPC64)
> +	/* On PPC64, we always do non-cacheable access to the IO hole and
> +	 * cacheable elsewhere. Cache paradox can checkstop the CPU and
> +	 * the high_memory heuristic below is wrong on machines with memory
> +	 * above the IO hole... Ah, and of course, XFree86 doesn't pass
> +	 * O_SYNC when mapping us to tap IO space. Surprised ?
> +	 */
> +	return !page_is_ram(addr);
>  #else

Umm, can't we plaese define a hook in all pors and use it here instead
of one hack per port?

