Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132615AbRDKQEJ>; Wed, 11 Apr 2001 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDKQEA>; Wed, 11 Apr 2001 12:04:00 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:53512 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132615AbRDKQDv>;
	Wed, 11 Apr 2001 12:03:51 -0400
Date: Wed, 11 Apr 2001 18:02:35 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: 5740@mail.ru, acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 compile error No 3
Message-ID: <20010411180235.A29195@vana.vc.cvut.cz>
In-Reply-To: <4AB83BD5FB4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <4AB83BD5FB4@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Apr 11, 2001 at 05:40:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # CONFIG_IPX_INTERN is not set
> # CONFIG_SYSCTL is not set

> net/network.o: In function `ipx_init':
> net/network.o(.text.init+0x1008): undefined reference to `ipx_register_sysctl'

Do not do it! You cannot control some very important features of IPX without
sysctl! Anyway below is patch, Alan please apply (although I must say that
this Makefile changed a bit my opinion on how obj-y and obj-m works...).

As for your other reports - No1 is fixed in Alan tree and patch is flying somewhere
around, and No2 looks like that your semaphore.h is corrupted. For parport
problems in No4, you have broken compiler or you changed some options in the
middle of compilation.
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/net/ipx/Makefile linux/net/ipx/Makefile
--- linux/net/ipx/Makefile	Fri Dec 29 22:07:24 2000
+++ linux/net/ipx/Makefile	Wed Apr 11 15:52:59 2001
@@ -13,13 +13,12 @@
 
 export-objs = af_ipx.o af_spx.o
 
-obj-y	:= af_ipx.o
+obj-y	:= af_ipx.o sysctl_net_ipx.o
 
 ifeq ($(CONFIG_IPX),m)
   obj-m += $(O_TARGET)
 endif
 
-obj-$(CONFIG_SYSCTL) += sysctl_net_ipx.o
 obj-$(CONFIG_SPX) += af_spx.o
 
 include $(TOPDIR)/Rules.make

