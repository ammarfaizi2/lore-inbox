Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVCTGbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVCTGbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCTGbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:31:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:13274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261991AbVCTGbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:31:32 -0500
Date: Sat, 19 Mar 2005 22:30:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jim Gifford <maillist@jg555.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build issue current MIPS - RaQ2
Message-Id: <20050319223044.616935f1.akpm@osdl.org>
In-Reply-To: <423C7AB5.2010200@jg555.com>
References: <423C7AB5.2010200@jg555.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford <maillist@jg555.com> wrote:
>
>  I have not been able to build kernels since 2.6.9 on my RaQ2 for some 
>  time. I have tried the linux-mips.org port and the current 2.6.11.5 
>  release. I keep getting the same error.
> 
>    Building modules, stage 2.
>    MODPOST
>  *** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
>  *** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!

Does this fix it?

--- 25/arch/mips/lib/Makefile~mips-linkage-fix	2005-03-19 22:29:34.000000000 -0800
+++ 25-akpm/arch/mips/lib/Makefile	2005-03-19 22:30:07.000000000 -0800
@@ -2,7 +2,9 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o dec_and_lock.o iomap.o memcpy.o promlib.o \
+lib-y	+= csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o \
 	   strlen_user.o strncpy_user.o strnlen_user.o
 
+obj-y	+= iomap.o
+
 EXTRA_AFLAGS := $(CFLAGS)
_

