Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317688AbSGKAES>; Wed, 10 Jul 2002 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317689AbSGKAER>; Wed, 10 Jul 2002 20:04:17 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:39350 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317688AbSGKAEQ>; Wed, 10 Jul 2002 20:04:16 -0400
Date: Wed, 10 Jul 2002 17:06:14 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile error (starfire ethernet) on 2.5.25 for crc32_le
Message-ID: <174620000.1026345974@flay>
In-Reply-To: <3D2CC764.6080002@mandrakesoft.com>
References: <165080000.1026343268@flay> <3D2CC764.6080002@mandrakesoft.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> drivers/built-in.o: In function `set_rx_mode':
>> drivers/built-in.o(.text+0x2138c): undefined reference to `crc32_le'
>> make: *** [vmlinux] Error 1
>> 
>> starfire.c calls ether_crc_le which is defined in include/linux/crc32.h as
>> # define ether_crc_le(length, data) crc32_le(~0, data, length)
>> 
>> crc32_le is defined in lib/crc32.c .... which is only compiled if CONFIG_CRC32
>> is set  ... setting this fixes the problem ... shouldn't drivers that need this turn it
>> on automatically somehow?
> 
> They do already.  drivers/net/Makefile.lib.  The culprit is a typo. Wanna submit 
> the obvious patch that does s/CONFIG_STARFIRE/CONFIG_ADAPTEC_STARFIRE/ 
> in dr/ne/Makefile.lib?

Done. Tested. Works. Thankyou!
Could you forward to Linus so it looks blessed?

Thanks,

M.

--- virgin-2.5.25/drivers/net/Makefile.lib	Fri Jul  5 16:42:33 2002
+++ linux-2.5.25-starfire/drivers/net/Makefile.lib	Wed Jul 10 16:55:07 2002
@@ -25,7 +25,7 @@
 obj-$(CONFIG_PCNET32)		+= crc32.o
 obj-$(CONFIG_SIS900)		+= crc32.o
 obj-$(CONFIG_SMC9194)		+= crc32.o
-obj-$(CONFIG_STARFIRE)		+= crc32.o
+obj-$(CONFIG_ADAPTEC_STARFIRE)	+= crc32.o
 obj-$(CONFIG_SUNBMAC)		+= crc32.o
 obj-$(CONFIG_SUNDANCE)		+= crc32.o
 obj-$(CONFIG_SUNGEM)		+= crc32.o

