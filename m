Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULWLOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULWLOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULWLOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:14:55 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:61642 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261208AbULWLOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=XKCWaFLNvqMwsj+hvzMjgMHUPJvO9jupzakP14EJGT9VEybJsZS9c1rb5juByOsDYdq2cefyaR2twIyKp49TZ+Ob6/tBwqo++bRzHhW2lzfciWw9Qjxh3huYfU38qOs5QWEiuDf8STcCAPR1atvATfWazLZp8rD001yGX6NiBcg=
Message-ID: <e7b30b240412230314395fbf29@mail.gmail.com>
Date: Thu, 23 Dec 2004 19:14:52 +0800
From: Mildred Frisco <mildred.frisco@gmail.com>
Reply-To: Mildred Frisco <mildred.frisco@gmail.com>
To: linux-arm@lists.arm.linux.org.uk
Subject: setting gpio on MX1
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using an MX1-based board and would like to use one of its GPIO
pins for interrupt.  I tried to initlialize it in
arch/arm/mach-xxx/arch.c  by the __fixup function. Here's the part of
the code I added ...


#include <asm/arch/mx1board-gpio.h>

/* Configure interrupt setting, for bitnum of port configured as input.
 * */
void mx1board_init_gpio(void)
{
	int i,j;
	i=mx1_register_gpio(PORT_B,17,INPUT);
	j=mx1_gpio_config_intr(PORT_B,17,POSITIVE_LEVEL);
}  

void mx1board_init_devices(void)
{
	mx1board_init_gpio();
}

static void __init
mx1skx4043_fixup(struct machine_desc *desc, struct param_struct *unused,
		 char **cmdline, struct meminfo *mi)
{
	mx1board_init_devices();
}


MACHINE_START....

-------

I've generated a kernel image but it only goes until "Uncompressing linux..."
The kernel booted successfully when this part is not included yet.

Or maybe I am initializing the gpio in the wrong place or I forgot to
call an some function.  Is the kernel console already enabled by this
time so I can see the kernel messages?

Thanks in advance,
Mildred
