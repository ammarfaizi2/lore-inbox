Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWG0Mja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWG0Mja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWG0Mja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:39:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33994 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751108AbWG0Mj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:39:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=C5UNpujosYaQQ3eDnOyrWt3TN7ShaMMehJX2oRT/F0l+CBwUB9KErsazHyDdVgo9WgU0sEoH/DY2Bms16aSVoXjkZwvNWy9WC3FDHSVsU4Dm2Yyk3instGq+5YQtXcNeWyHIunx5nKwwvHV2tsQZb5ibpBBbUS44DaZ7TgbsJtk=
Date: Thu, 27 Jul 2006 14:39:23 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hostmaster@ed-soft.at
Subject: [patch] fix "efi_init_e820_map undefined" warning
Message-ID: <20060727123922.GC3381@slug>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060727122630.GB3381@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727122630.GB3381@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> 
(Sorry for the resend, I forgot to add a proper subject line)
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

