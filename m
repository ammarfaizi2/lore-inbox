Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWFGO1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWFGO1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFGO1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:27:07 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:38623 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932070AbWFGO1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:27:06 -0400
Date: Wed, 7 Jun 2006 15:27:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: PNX8550 fails to compile in 2.6.17-rc4
Message-ID: <20060607142702.GA20184@linux-mips.org>
References: <20060607105221.7b15b243.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607105221.7b15b243.vitalywool@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:52:21AM +0400, Vitaly Wool wrote:

> when I try to compile Linux kernel for pnx8550 in 2.6.17-rc4, I get the following error:
> 
>   CC      arch/mips/philips/pnx8550/common/setup.o
> /home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c: In function `plat_setup':
> /home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:133: warning: implicit declaration of function `ip3106_lcr'
> /home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:134: error: invalid lvalue in assignment
> /home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: warning: implicit declaration of function `ip3106_baud'
> /home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: error: invalid lvalue in assignment
> make[2]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
> make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
> make: *** [vmlinux] Error 2
> 
> I guess it's not what it should be ;-)

This seems to be one of the serial bits for the ip3106 which must have
been lost on the way to kernel.org.  Unfortunately the original author
does no longer take care of the code.  I just took a stab at the PNX8550
code and it has a significant number of other problems.  All small in
the sum large enough such that I will mark PNX8550 support broken.

  Ralf

[MIPS] Mark PNX8550 support broken.
    
Broken in too many way for me to fix it for 2.6.17.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0e25c1d..d87177f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -440,12 +440,12 @@ config MIPS_XXS1500
 
 config PNX8550_V2PCI
 	bool "Philips PNX8550 based Viper2-PCI board"
-	select PNX8550
+	select PNX8550 && BROKEN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_JBS
 	bool "Philips PNX8550 based JBS board"
-	select PNX8550
+	select PNX8550 && BROKEN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config DDB5074
