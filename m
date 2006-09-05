Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWIELj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWIELj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWIELj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:39:58 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:968 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751356AbWIELj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:39:57 -0400
Date: Tue, 5 Sep 2006 07:39:39 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060905113939.GA5130@tachyon.int.mcmartin.ca>
References: <44FC193C.4080205@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FC193C.4080205@openvz.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 04:17:00PM +0400, Kirill Korotaev wrote:
> --- a/include/asm-generic/mman.h
> +++ b/include/asm-generic/mman.h
> @@ -39,4 +39,10 @@ #define MADV_DOFORK	11		/* do inherit ac
> #define MAP_ANON	MAP_ANONYMOUS
> #define MAP_FILE	0
> 
> +#ifdef __KERNEL__
> +#ifndef arch_mmap_check
> +#define arch_mmap_check(addr, len, flags)	(0)
> +#endif
> +#endif
> +
> #endif

This breaks all arches that don't use asm-generic/mman.h, and that you
didn't add arch_mmap_check to asm/mman.h for.
