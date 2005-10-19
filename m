Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVJSRVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVJSRVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVJSRVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:21:12 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:5334 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751169AbVJSRVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:21:11 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed, 19 Oct 2005 19:20:43 +0200
In-reply-to: <43567C5C.4090905@ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@freescale.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx
Message-Id: <20051019172042.7B81422AEB2@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch fixes a numbers of issues regarding to that both 8xx and 82xx
>began to use ppc_sys model:
>	- Platform is now identified by default deviceless SOC, if no
>BOARD_CHIP_NAME is specified in the bard-specific header. For the list
>of supported names refer to (arch/ppc/syslib/) mpc8xx_sys.c and
>mpc82xx_sys.c for 8xx and 82xx respectively.
>	- Fixed a bug in identification by name - if the name was not found, it
>returned -1 instead of default deviceless ppc_spec.
>	- fixed devices amount in the 8xx platform system descriptions
>
>
>Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
>Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>-- 
>Sincerely,
>Vitaly
>
>
>diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
>--- a/arch/ppc/platforms/fads.h
>+++ b/arch/ppc/platforms/fads.h
>@@ -25,6 +25,8 @@
> 
> #if defined(CONFIG_MPC86XADS)
> 
>+#define BOARD_CHIP_NAME "MPC86X"
>+
> /* U-Boot maps BCSR to 0xff080000 */
> #define BCSR_ADDR		((uint)0xff080000)
> 
>diff --git a/arch/ppc/platforms/mpc885ads.h b/arch/ppc/platforms/mpc885ads.h
>--- a/arch/ppc/platforms/mpc885ads.h
>+++ b/arch/ppc/platforms/mpc885ads.h
>@@ -88,5 +88,7 @@
> #define SICR_ENET_MASK	((uint)0x00ff0000)
> #define SICR_ENET_CLKRT	((uint)0x002c0000)
> 
>+#define BOARD_CHIP_NAME "MPC885"
>+
> #endif /* __ASM_MPC885ADS_H__ */
> #endif /* __KERNEL__ */
>diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
>--- a/arch/ppc/syslib/m8260_setup.c
>+++ b/arch/ppc/syslib/m8260_setup.c
>@@ -62,6 +62,9 @@ m8260_setup_arch(void)
> 	if (initrd_start)
> 		ROOT_DEV = Root_RAM0;
> #endif
>+	
>+	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME, in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
80 columns at most on a line, please.

>+	
Whitespace weevils.

> 	m82xx_board_setup();
> }
> 
>diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
>--- a/arch/ppc/syslib/m8xx_setup.c
>+++ b/arch/ppc/syslib/m8xx_setup.c
>@@ -403,7 +403,9 @@ platform_init(unsigned long r3, unsigned
> 		*(char *)(r7+KERNELBASE) = 0;
> 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
> 	}
>-
>+	
>+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
>+	
Whitespace.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
