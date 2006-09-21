Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWIUI5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWIUI5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWIUI5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:57:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18640 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750992AbWIUI5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:57:46 -0400
Subject: Re: [PATCH 4/4] Blackfin: binfmt patch to enhance stacking checking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
References: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 10:22:00 +0100
Message-Id: <1158830520.11109.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 11:33 +0800, ysgrifennodd Luke Yang:
> diff -urN linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c
> linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c
> --- linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c	2006-09-21
> 09:37:18.000000000 +0800
> +++ linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c	2006-09-21
> 11:17:49.000000000 +0800
> @@ -959,6 +962,8 @@
>  }
>  #endif
> 
> +extern void *safe_dma_memcpy(void *, const void *, size_t);
> +

This shouldn't be here but in your header files for the arch (or in
linux/ somewhere if its a shared and missing include). Check and fix the
headers.



>  		if (strncmp(hdr->magic, "#!", 2))
>  			printk("BINFMT_FLAT: bad header magic\n");
> -		ret = -ENOEXEC;
> -		goto err;
> +		return -ENOEXEC;

These changes seem unneccessary and its hard to see the real change as a
result.


