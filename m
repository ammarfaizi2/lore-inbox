Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVCTG2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVCTG2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCTG2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:28:21 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:11208 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S261560AbVCTG2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:28:16 -0500
Message-ID: <423D17EE.9000802@jg555.com>
Date: Sat, 19 Mar 2005 22:27:58 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Gifford <maillist@jg555.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Patch for iomap on MIPS was Re: Build issue current MIPS - RaQ2
References: <423C7AB5.2010200@jg555.com>
In-Reply-To: <423C7AB5.2010200@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford wrote:

> I have not been able to build kernels since 2.6.9 on my RaQ2 for some 
> time. I have tried the linux-mips.org port and the current 2.6.11.5 
> release. I keep getting the same error.
>
>  Building modules, stage 2.
>  MODPOST
> *** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
> *** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!
>
>
I Finally figured it out, Here is a patch

diff -Naur linux-2.6.11/arch/mips/lib/Makefile 
linux-mips-2.6.11/arch/mips/lib/Makefile
--- linux-2.6.11/arch/mips/lib/Makefile 2005-03-01 23:37:48 -0800
+++ linux-mips-2.6.11/arch/mips/lib/Makefile    2005-03-19 21:49:03 -0800
@@ -2,7 +2,10 @@
 # Makefile for MIPS-specific library files..
 #

-lib-y  += csum_partial_copy.o dec_and_lock.o iomap.o memcpy.o promlib.o \
+lib-y  += csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o \
           strlen_user.o strncpy_user.o strnlen_user.o

+
+obj-y   += iomap.o
+
 EXTRA_AFLAGS := $(CFLAGS)

-- 
----
Jim Gifford
maillist@jg555.com

