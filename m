Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVCAVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVCAVjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:39:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:57564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262037AbVCAVj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:39:28 -0500
Date: Tue, 1 Mar 2005 13:44:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <200503012129.11840.adobriyan@mail.ru>
References: <200503012129.11840.adobriyan@mail.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@mail.ru> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Thanks.  Many of these fixups are due to a 64-bit-resource patch in Greg's
bk-pci tree which he has now reverted.  That being said:

- That patch will come back sometime

- Fixes like the below make sense anyway and can be merged any time.

- All the fixes which were only applicable when the 64-bit-resource patch
  is present have been sent to Greg for when that patch reemerges.


> --- linux-2.6.11-rc5-mm1/arch/sparc/kernel/ioport.c.orig	2005-03-01 21:11:30.000000000 +0200
> +++ linux-2.6.11-rc5-mm1/arch/sparc/kernel/ioport.c	2005-03-01 21:12:48.000000000 +0200
> @@ -54,11 +54,11 @@ static void _sparc_free_io(struct resour
>  
>  /* This points to the next to use virtual memory for DVMA mappings */
>  static struct resource _sparc_dvma = {
> -	"sparc_dvma", DVMA_VADDR, DVMA_END - 1
> +	.name = "sparc_dvma", .start = DVMA_VADDR, .end = DVMA_END - 1
>  };
>  /* This points to the start of I/O mappings, cluable from outside. */
>  /*ext*/ struct resource sparc_iomap = {
> -	"sparc_iomap", IOBASE_VADDR, IOBASE_END - 1
> +	.name = "sparc_iomap", .start = IOBASE_VADDR, .end = IOBASE_END - 1
>  };
>  
>  /*
