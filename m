Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVGLUCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVGLUCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGLUCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:02:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:2792 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262362AbVGLUBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:01:15 -0400
Date: Tue, 12 Jul 2005 22:01:14 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tglx@linutronix.de
Subject: Re: [MTD] XIP cleanup
Message-ID: <20050712200114.GA6165@suse.de>
References: <200507111906.j6BJ6fDu007639@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200507111906.j6BJ6fDu007639@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 11, Linux Kernel Mailing List wrote:

> tree d571cdae6507be90d4ee67d4937b765e2b332d77
> parent b9c86d595d2a11009c58c84a9a8792aeb4a8f278
> author Thomas Gleixner <tglx@tglx.tec.linutronix.de> Thu, 07 Jul 2005 16:50:16 +0200
> committer Thomas Gleixner <tglx@mtd.linutronix.de> Thu, 07 Jul 2005 16:50:16 +0200
> 
> [MTD] XIP cleanup
> 
> Move the architecture dependend code into include/asm/mtd-xip.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
>  drivers/mtd/chips/cfi_cmdset_0001.c   |    2 -
>  drivers/mtd/chips/cfi_cmdset_0002.c   |    2 -
>  include/asm-arm/arch-pxa/mtd-xip.h    |   37 ++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-sa1100/mtd-xip.h |   26 +++++++++++++++++++++++
>  include/asm-arm/mtd-xip.h             |   26 +++++++++++++++++++++++
>  include/linux/mtd/xip.h               |   31 +++++++++++-----------------
>  6 files changed, 104 insertions(+), 20 deletions(-)

> diff --git a/include/linux/mtd/xip.h b/include/linux/mtd/xip.h
> --- a/include/linux/mtd/xip.h
> +++ b/include/linux/mtd/xip.h
> @@ -58,22 +58,16 @@
>   * 		returned value is <= the real elapsed time.
>   * 	note 2: this should be able to cope with a few seconds without
>   * 		overflowing.
> + *
> + * xip_iprefetch()
> + *  
> + *      Macro to fill instruction prefetch
> + *	e.g. a series of nops:  asm volatile (".rep 8; nop; .endr"); 
>   */
>  
> -#if defined(CONFIG_ARCH_SA1100) || defined(CONFIG_ARCH_PXA)
> +#include <asm/mtd-xip.h>

How is that supposed to work?
Should each arch provide their own header file?
Should certion .config options depend on ARM or $FOO?
I assume most of the mtd drivers are not intended for the average
Walmart PC.


