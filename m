Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWBGWhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWBGWhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWBGWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:37:15 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:51910 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932073AbWBGWhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:37:13 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] IA64_GENERIC shouldn't select other stuff 
In-reply-to: Your message of "Tue, 07 Feb 2006 23:11:57 BST."
             <20060207221157.GA3524@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Feb 2006 09:37:11 +1100
Message-ID: <9883.1139351831@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk (on Tue, 7 Feb 2006 23:11:57 +0100) wrote:
>IA64_GENERIC shouldn't select other stuff.
>
>select'ing ACPI without select'ing PCI had broken ACPI in the past (the 
>current workaround is that ACPI select's PCI).
>
>Select'ing NUMA means that the illegal configuration NUMA=y, FLATMEM=y 
>is possible.
>
>The generic setting might be required in some places, but select'ing 
>some options like NUMA while not select'ing some other similar 
>important options like PCI doesn't make much sense.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig.old	2006-02-07 23:07:29.000000000 +0100
>+++ linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig	2006-02-07 23:07:55.000000000 +0100
>@@ -72,9 +72,6 @@
> 
> config IA64_GENERIC
> 	bool "generic"
>-	select ACPI
>-	select NUMA
>-	select ACPI_NUMA
> 	help
> 	  This selects the system type of your hardware.  A "generic" kernel
> 	  will run on any supported IA-64 system.  However, if you configure
>

A generic IA64 kernel requires (at least) the ACPI and NUMA options in
order to run on all the IA64 platforms out there.  Omitting those
options and relying on the user to set them by hand is going to cause
more problems.

If anything, there should be more options being set as a side effect of
selecting IA64_GENERIC, including ARCH_DISCONTIGMEM_ENABLE,
ARCH_SPARSEMEM_ENABLE, PCI and even SMP.

