Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUEFTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUEFTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUEFTrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:47:16 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56040 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262772AbUEFTrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:47:14 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2 does not build on AMD64 + essential patch is missing
Date: Thu, 6 May 2004 21:38:08 +0200
User-Agent: KMail/1.5
Cc: akpm@zip.com.au, ak@muc.de, linux-kernel@vger.kernel.org
References: <200405052210.18074.rjwysocki@sisk.pl> <20040505135834.5edfa5b1.akpm@osdl.org>
In-Reply-To: <20040505135834.5edfa5b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405062138.08701.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 of May 2004 22:58, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > Hi,
> >
> > The 2.6.6-rc3-mm2 kernel does not buld on AMD64 w/ NUMA, it appears. 
> > Here's what the gcc says:
> >
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> >
> > arch/x86_64/ia32/built-in.o(.text+0xa164): In function 
`ia32_setup_arg_pages':
> > : undefined reference to `mpol_set_vma_default'
> >
> > kernel/built-in.o(.text+0x9ba0): In function `do_exit':
> > : undefined reference to `mpol_free'
> >
> > make: *** [.tmp_vmlinux1] Error 1
>
> Thanks.  The below should fix it.

It does, but additionally "#include <linux/mempolicy.h>" has to be added in 
"ia32_binfmt.c":

diff -Naur linux-2.6.6-rc3-mm2/arch/x86_64/ia32/ia32_binfmt.c 
linux-2.6.6-rc3-mm2.new/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.6-rc3-mm2/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 
21:06:39.000000000 +0200
+++ linux-2.6.6-rc3-mm2.new/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 
21:01:43.398886976 +0200
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/binfmts.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/security.h>
 
 #include <asm/segment.h> 

> > (attached is the .config).  Also, IMHO, the patch:
[cut]
> > should be applied to it, so that it does not crash at init.
>
> Are you sure?  This patch should no longer be necessary, because the
> default was changed in kernel/fork.c

Of course you're right, though some other architectures (eg. i386) do have it 
(is it necessay there any longer?).

Greets,
RJW


