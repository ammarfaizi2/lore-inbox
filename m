Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318386AbSGRXFA>; Thu, 18 Jul 2002 19:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGRXFA>; Thu, 18 Jul 2002 19:05:00 -0400
Received: from www.transvirtual.com ([206.14.214.140]:15116 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318386AbSGRXE4>; Thu, 18 Jul 2002 19:04:56 -0400
Date: Thu, 18 Jul 2002 16:07:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Link errors with CONFIG_VT=n, CONFIG_SYSRQ=y
In-Reply-To: <20020717152929.A5856@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207181607270.16453-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed :-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Wed, 17 Jul 2002, Russell King wrote:

> lkml, James,
>
> When building 2.5.26 with CONFIG_VT=n and CONFIG_SYSRQ=y, the resulting
> kernel can't be linked:
>
> drivers/built-in.o: In function `sysrq_handle_unraw':
> drivers/built-in.o(.text+0x14694): undefined reference to `fg_console'
> drivers/built-in.o(.text+0x14698): undefined reference to `kbd_table'
>
> The following is a work-around for this problem.  There is probably
> a cleaner solution to this.
>
> --- orig/drivers/char/sysrq.c	Wed Jul 17 15:10:39 2002
> +++ linux/drivers/char/sysrq.c	Wed Jul 17 15:27:18 2002
> @@ -81,10 +81,12 @@
>  static void sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
>  			       struct tty_struct *tty)
>  {
> +#ifdef CONFIG_VT
>  	struct kbd_struct *kbd = &kbd_table[fg_console];
>
>  	if (kbd)
>  		kbd->kbdmode = VC_XLATE;
> +#endif
>  }
>  static struct sysrq_key_op sysrq_unraw_op = {
>  	handler:	sysrq_handle_unraw,
>
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>

