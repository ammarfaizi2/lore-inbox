Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRDKQQT>; Wed, 11 Apr 2001 12:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRDKQQJ>; Wed, 11 Apr 2001 12:16:09 -0400
Received: from mx6.port.ru ([194.67.23.42]:64529 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S132622AbRDKQP6>;
	Wed, 11 Apr 2001 12:15:58 -0400
From: info <5740@mail.ru>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: 2.4.3 compile error No 3
Date: Wed, 11 Apr 2001 20:15:52 +0400
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
In-Reply-To: <4AB83BD5FB4@vcnet.vc.cvut.cz> <20010411180235.A29195@vana.vc.cvut.cz>
In-Reply-To: <20010411180235.A29195@vana.vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, John Jasen <jjasen@datafoundation.com>
MIME-Version: 1.0
Message-Id: <01041120181705.30945@sh.lc>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr, greatest  thanks!!! Now I try to aplly patch.... and will
report after results.

By the way, I thung that it is a good idea - to modify
xconfig/meniconfig script  in manner to make disable ipx if sysctl
setted off - like in many other cross-dependance options. 

You know better than I who can do it.


Срд, 11 Апр 2001 в сообщении на тему "Re: 2.4.3 compile error No 3" Вы написали:
> > # CONFIG_IPX_INTERN is not set
> > # CONFIG_SYSCTL is not set
> 
> > net/network.o: In function `ipx_init':
> > net/network.o(.text.init+0x1008): undefined reference to `ipx_register_sysctl'


> 
> Do not do it! You cannot control some very important features of IPX without
> sysctl! Anyway below is patch, Alan please apply (although I must say that
> this Makefile changed a bit my opinion on how obj-y and obj-m works...).
> 
> As for your other reports - No1 is fixed in Alan tree and patch is flying somewhere
> around, and No2 looks like that your semaphore.h is corrupted. For parport
> problems in No4, you have broken compiler or you changed some options in the
> middle of compilation.
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
> 
> diff -urdN linux/net/ipx/Makefile linux/net/ipx/Makefile
> --- linux/net/ipx/Makefile	Fri Dec 29 22:07:24 2000
> +++ linux/net/ipx/Makefile	Wed Apr 11 15:52:59 2001
> @@ -13,13 +13,12 @@
>  
>  export-objs = af_ipx.o af_spx.o
>  
> -obj-y	:= af_ipx.o
> +obj-y	:= af_ipx.o sysctl_net_ipx.o
>  
>  ifeq ($(CONFIG_IPX),m)
>    obj-m += $(O_TARGET)
>  endif
>  
> -obj-$(CONFIG_SYSCTL) += sysctl_net_ipx.o
>  obj-$(CONFIG_SPX) += af_spx.o
>  
>  include $(TOPDIR)/Rules.make

