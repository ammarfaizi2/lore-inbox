Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUFYEDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUFYEDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 00:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUFYEDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 00:03:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:49824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266195AbUFYEDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 00:03:06 -0400
Date: Thu, 24 Jun 2004 21:01:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: willy@debian.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.6 patch] fix arch/i386/pci/Makefile
Message-Id: <20040624210150.46e68ded.akpm@osdl.org>
In-Reply-To: <20040625001513.GB18303@fs.tum.de>
References: <20040625001513.GB18303@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I got the following compile error in 2.6.7-mm2 (but it doesn't seem to 
>  be specific to -mm2):
> ..
>  drivers/built-in.o(.text+0x6c24a): In function `acpi_pci_root_add':
>  : undefined reference to `pci_acpi_scan_root'
>  make: *** [.tmp_vmlinux1] Error 1

> 
>  This problem occurs with
>    CONFIG_ACPI_PCI=y && (CONFIG_X86_VISWS=y || CONFIG_X86_NUMAQ=y)
> 
> ....
>  --- linux-2.6.7-mm2-full/arch/i386/pci/Makefile.old	2004-06-25 02:08:29.000000000 +0200
>  +++ linux-2.6.7-mm2-full/arch/i386/pci/Makefile	2004-06-25 02:10:36.000000000 +0200
>  @@ -5,10 +5,11 @@
>   obj-$(CONFIG_PCI_DIRECT)	+= direct.o
>   
>   pci-y				:= fixup.o
>  -pci-$(CONFIG_ACPI_PCI)		+= acpi.o
>   pci-y				+= legacy.o irq.o
>   
>   pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
>   pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
>   
>  +pci-$(CONFIG_ACPI_PCI)		+= acpi.o
>  +

This causes my e100 NIC to not work.  Some initcall ordering dependency,
presumably.  A whole bunch of devices popped up on different IRQs.

Come to think about it, how can the above patch fix that linkage error
anyway?
