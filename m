Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWJSJDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWJSJDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJSJDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:03:14 -0400
Received: from [195.171.73.133] ([195.171.73.133]:12947 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1030351AbWJSJDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:03:12 -0400
Date: Thu, 19 Oct 2006 09:03:11 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: Re: make headers_install headers problem on sparc64
Message-ID: <20061019090311.GA17882@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com> <1161244222.3376.470.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161244222.3376.470.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 08:50:22AM +0100, David Woodhouse wrote:
> 
> Hm, yes. There's still a lot of crap being exposed there that we really
> don't need to be showing. Try this entirely untested patch...
> 
> The sparc64 version could do with something similar, too.
> 

I'm on sparc64 (pure 64bit) so I can't test your patch. For reference,
I used this (not as smart as yours) patch:

diff -Naur linux-2.6.18.1/include/asm-sparc64/elf.h linux-2.6.18.1-fix/include/asm-sparc64/elf.h
--- linux-2.6.18.1/include/asm-sparc64/elf.h    2006-09-20 03:42:06.000000000 +0000
+++ linux-2.6.18.1-fix/include/asm-sparc64/elf.h        2006-10-19 08:57:11.000000000 +0000
@@ -142,6 +142,7 @@
 #define ELF_ET_DYN_BASE         0x0000010000000000UL
 #endif

+#ifdef __KERNEL__

 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  */
@@ -163,6 +164,8 @@

 #define ELF_HWCAP      sparc64_elf_hwcap();

+#endif
+
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
    intent than poking at uname or /proc/cpuinfo.  */



Andrew Walrond
