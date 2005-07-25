Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVGYPHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVGYPHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVGYPHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:07:07 -0400
Received: from tim.rpsys.net ([194.106.48.114]:19343 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261286AbVGYPHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:07:04 -0400
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050725054642.GA6651@elf.ucw.cz>
References: <20050725054642.GA6651@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 16:06:57 +0100
Message-Id: <1122304018.7942.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 07:46 +0200, Pavel Machek wrote:
> I took battery charging code from sharp and placed it in
> arch/arm/mach-sa1100/battery-collie.c (hope that's good place...). It
> still does not link, and will need complete rewrite, but... If you
> have done this already please let me know.
>
> #define CF_BUF_CTRL_BASE 0xF0800000
> #define        SCP_REG(adr) (*(volatile unsigned short*)(CF_BUF_CTRL_BASE+(adr)))
> 
> #define        SCP_MCR  0x00
> #define        SCP_CDR  0x04
> #define        SCP_CSR  0x08
> #define        SCP_CPR  0x0C
> #define        SCP_CCR  0x10
> #define        SCP_IRR  0x14
> #define        SCP_IRM  0x14
> #define        SCP_IMR  0x18
> #define        SCP_ISR  0x1C
> #define        SCP_GPCR 0x20
> #define        SCP_GPWR 0x24
> #define        SCP_GPRR 0x28
> #define        SCP_REG_MCR     SCP_REG(SCP_MCR)
> #define        SCP_REG_CDR     SCP_REG(SCP_CDR)
> #define        SCP_REG_CSR     SCP_REG(SCP_CSR)
> #define        SCP_REG_CPR     SCP_REG(SCP_CPR)
> #define        SCP_REG_CCR     SCP_REG(SCP_CCR)
> #define        SCP_REG_IRR     SCP_REG(SCP_IRR)
> #define        SCP_REG_IRM     SCP_REG(SCP_IRM)
> #define        SCP_REG_IMR     SCP_REG(SCP_IMR)
> #define        SCP_REG_ISR     SCP_REG(SCP_ISR)
> #define        SCP_REG_GPCR    SCP_REG(SCP_GPCR)
> #define        SCP_REG_GPWR    SCP_REG(SCP_GPWR)
> #define        SCP_REG_GPRR    SCP_REG(SCP_GPRR)

You'll find the scoop driver deals with the above
(arch/arm/common/scoop.c).

> #define FLASH_MEM_BASE 0xe8ffc000
> #define        FLASH_DATA(adr) (*(volatile unsigned int*)(FLASH_MEM_BASE+(adr)))
> #define        FLASH_DATA_F(adr) (*(volatile float32 *)(FLASH_MEM_BASE+(adr)))
> #define FLASH_MAGIC_CHG(a,b,c,d) ( ( d << 24 ) | ( c << 16 )  | ( b << 8 ) | a )
> 
> // AD
> #define FLASH_AD_MAJIC FLASH_MAGIC_CHG('B','V','A','D')
> #define        FLASH_AD_MAGIC_ADR      0x30
> #define        FLASH_AD_DATA_ADR       0x34

and arch/arm/common/sharpsl_param.c with these.

> #define IRQ_GPIO_CO                IRQ_GPIO20
> #define IRQ_GPIO_AC_IN             IRQ_GPIO1

There will (or if not, there should) be an equivalent in collie.h for
the above.

I have similar problems with the corgi battery driver which is probably
even more of a mess than this. My conclusion is the whole lot needs
rewriting in a nice fashion before it can be included in mainline. My
work so far on the corgi code is here:

http://www.rpsys.net/openzaurus/patches/corgi_power-r24.patch
http://www.rpsys.net/openzaurus/patches/corgi_power1-r1.patch

I'm making progress in areas but I'm not sure how much can be shared
between devices. My plan is to split the above into two sections, a
battery driver and some power management code. The powermanagement code
can probably then make mainline. The battery driver still needs a lot of
work.

-- 
Richard



