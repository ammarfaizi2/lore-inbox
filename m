Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJKTeH>; Thu, 11 Oct 2001 15:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276746AbRJKTd7>; Thu, 11 Oct 2001 15:33:59 -0400
Received: from mail.oceanlake.com ([216.191.142.226]:33826 "EHLO
	postman.oceanlake.com") by vger.kernel.org with ESMTP
	id <S276716AbRJKTdi>; Thu, 11 Oct 2001 15:33:38 -0400
Message-ID: <3BC5F512.2090004@oceanlake.com>
Date: Thu, 11 Oct 2001 15:37:54 -0400
From: Luke Reeves <lukelist@oceanlake.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Koby Kahane <kobyk@bigfoot.com>
Subject: Re: Linux 2.4.12 fails to compile with IEEE 1284 parport enabled
In-Reply-To: <20011011212015.A7983@darkstar>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem, it was originally posted by Tim Waugh.

-- 
     Luke Reeves, Director of Development
     Oceanlake Commerce Inc.
     http://www.oceanlake.com/
     luke.reeves@oceanlake.NOSPAM.com

--- linux/drivers/parport/ieee1284_ops.c.orig	Thu Oct 11 09:40:39 2001
+++ linux/drivers/parport/ieee1284_ops.c	Thu Oct 11 09:40:42 2001
@@ -362,7 +362,7 @@
  	} else {
  		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
  	 
	 port->name);
- 
	port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+ 
	port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
  	}

  	return retval;
@@ -394,7 +394,7 @@
  		DPRINTK (KERN_DEBUG
  	 
	 "%s: ECP direction: failed to switch forward\n",
  	 
	 port->name);
- 
	port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+ 
	port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
  	}




Koby Kahane wrote:

> Hello,
> 
> while attempting to compile 2.4.12, during the module compilation phase, the following errors occur:
> 
> ...
> make -C parport modules
> make[2]: Entering directory `/usr/src/linux/drivers/parport'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o share.o share.c
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o ieee1284.o ieee1284.c
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o ieee1284_ops.o ieee1284_ops.c
> ieee1284_ops.c: In function `ecp_forward_to_reverse':
> ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
> ieee1284_ops.c:365: for each function it appears in.)
> ieee1284_ops.c: In function `ecp_reverse_to_forward':
> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
> make[2]: *** [ieee1284_ops.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/parport'
> make[1]: *** [_modsubdir_parport] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
> 
> The following configuration options which appear to be related are enabled:
> 
> ...
> #
> # Parallel port support
> #
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PARPORT_SERIAL=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> # CONFIG_PARPORT_PC_PCMCIA is not set
> # CONFIG_PARPORT_AMIGA is not set
> # CONFIG_PARPORT_MFC3 is not set
> # CONFIG_PARPORT_ATARI is not set
> # CONFIG_PARPORT_SUNBPP is not set
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> ...
> 
> This configuration worked fine with 2.4.11.
> 
>   Koby Kahane
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


