Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270473AbTGNAaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270474AbTGNAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:30:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44264 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270473AbTGNAaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:30:07 -0400
Date: Mon, 14 Jul 2003 02:44:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ed Okerson <eokerson@quicknet.net>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] let CONFIG_PHONE_IXJ_PCMCIA depend on CONFIG_PCMCIA
Message-ID: <20030714004451.GH12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PHONE_IXJ_PCMCIA needs CONFIG_PCMCIA but there was no Kconfig
pendency. The link errors with CONFIG_PHONE_IXJ_PCMCIA and
!CONFIG_PCMCIA are at the bottom of this mail.

The fis is simple:

--- linux-2.5.75-mm1/drivers/telephony/Kconfig.old	2003-07-14 02:26:31.000000000 +0200
+++ linux-2.5.75-mm1/drivers/telephony/Kconfig	2003-07-14 02:27:13.000000000 +0200
@@ -39,7 +39,7 @@
 
 config PHONE_IXJ_PCMCIA
 	tristate "QuickNet Internet LineJack/PhoneJack PCMCIA support"
-	depends on PHONE_IXJ
+	depends on PHONE_IXJ && PCMCIA
 	help
 	  Say Y here to configure in PCMCIA service support for the Quicknet
 	  cards manufactured by Quicknet Technologies, Inc.  This changes the


Please apply
Adrian


<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x7a7b16): In function `ixj_attach':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7b34): In function `ixj_attach':
: undefined reference to `cs_error'
drivers/built-in.o(.text+0x7a7bef): In function `ixj_detach':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7c00): In function `ixj_detach':
: undefined reference to `cs_error'
drivers/built-in.o(.text+0x7a7c56): In function `ixj_get_serial':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7c6a): In function `ixj_get_serial':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7e1a): In function `ixj_config':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7e36): In function `ixj_config':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7e59): In function `ixj_config':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a7e97): more undefined references to 
`CardServices' follow
drivers/built-in.o(.text+0x7a7fa9): In function `ixj_config':
: undefined reference to `cs_error'
drivers/built-in.o(.text+0x7a7fcf): In function `ixj_config':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a807f): In function `ixj_cs_release':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a808d): In function `ixj_cs_release':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a813c): In function `ixj_event':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a8170): In function `ixj_event':
: undefined reference to `CardServices'
drivers/built-in.o(.text+0x7a8189): In function `ixj_pcmcia_exit':
: undefined reference to `pcmcia_unregister_driver'
drivers/built-in.o(.init.text+0x9efe9): In function `ixj_pcmcia_init':
: undefined reference to `pcmcia_register_driver'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


