Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWG0M0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWG0M0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWG0M0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:26:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:52375 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750795AbWG0M0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:26:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=L6m3hw4EChXniLqQUpaRSpbmXFz65C1gIJtsGF6fmTNLjvdcJ/i7xZCVCG8nEkbqH9sY3yHOl4JNN3L1gEs1Tz+gL6KcQ+4LdujSx7aBLGtA2yJNI0hgBECpVzCNeFpL3+HRX+LvmYfcFMgZ3+FOYEOXas68+anT2weaGLzPPZg=
Date: Thu, 27 Jul 2006 14:26:30 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hostmaster@ed-soft.at
Subject: Re: 2.6.18-rc2-mm1
Message-ID: <20060727122630.GB3381@slug>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> 
Hi, 

Compiling on i386 without the CONFIG_EFI enabled complains because it can't find 
efi_init_e820_map prototype:

arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1560: warning: implicit declaration of function `efi_init_e820_map'

The attached corrects this, and also makes efi_init_e820_map static.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>


--- v2.6.18-rc2-mm1~ori/arch/i386/kernel/setup.c	2006-07-27 11:46:05.000000000 +0200
+++ v2.6.18-rc2-mm1/arch/i386/kernel/setup.c	2006-07-27 11:51:02.000000000 +0200
@@ -1453,7 +1453,7 @@ static void set_mca_bus(int x) { }
 /*
  * Make a e820 memory map
  */
-void __init efi_init_e820_map(void)
+static void __init efi_init_e820_map(void)
 {
 	efi_memory_desc_t *md;
 	unsigned long long start = 0;
@@ -1505,7 +1505,9 @@ void __init efi_init_e820_map(void)
 		}
 	}
 }
-#endif
+#else
+static void __init efi_init_e820_map(void) { }
+#endif /* CONFIG_EFI */
 
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
