Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJBDxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 23:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTJBDxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 23:53:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:59067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263229AbTJBDxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 23:53:21 -0400
Date: Wed, 1 Oct 2003 20:52:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: shinemohamed_j@naturesoft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initializedd the module parameters in
 drivers/net/wireless/arlan-main.c
Message-Id: <20031001205228.3bee8c69.rddunlap@osdl.org>
In-Reply-To: <20031002011622.192752C2BC@lists.samba.org>
References: <200309291644.06043.shinemohamed_j@naturesoft.net>
	<20031002011622.192752C2BC@lists.samba.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Oct 2003 19:01:04 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:

| In message <200309291644.06043.shinemohamed_j@naturesoft.net> you write:
| > Quick patch to  Initialize  the module parameters in 
| > drivers/net/wireless/arlan-main.c
| > @@ -33,6 +33,7 @@
| >  static int retries = 5;
| >  static int tx_queue_len = 1;
| >  static int arlan_EEPROM_bad;
| > +static int probe = 0; /* Initially it is setting to be 'Probing Disabled' */
| > 
| >  #ifdef ARLAN_DEBUGGING
| 
| This is clearly wrong: it's declared below.

Hello.  Anybody there?

This is what you get with 2.6.0-test6 plain vanilla:

[rddunlap@midway linux-260-test6-work]$ make modules
  SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/net/wireless/arlan-main.o
drivers/net/wireless/arlan-main.c: In function `init_module':
drivers/net/wireless/arlan-main.c:1923: `probe' undeclared (first use in this function)
drivers/net/wireless/arlan-main.c:1923: (Each undeclared identifier is reported only once
drivers/net/wireless/arlan-main.c:1923: for each function it appears in.)
make[3]: *** [drivers/net/wireless/arlan-main.o] Error 1
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


so is MODULE_PARM(probe, "i");
supposed to be declaring <probe>?  It's not.
If it is supposed to be, then why are most/many/all other MODULE_PARM's
in that file also declared separately (i.e., again)?


The only wrong part I see is that it doesn't need to be init to 0.

--
~Randy
