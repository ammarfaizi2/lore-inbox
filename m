Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbRFKEsJ>; Mon, 11 Jun 2001 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFKEr7>; Mon, 11 Jun 2001 00:47:59 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:23282 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263400AbRFKErm>;
	Mon, 11 Jun 2001 00:47:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5-ac12: 3c590.c: Warning about 'nopnp' parameter 
In-Reply-To: Your message of "Mon, 11 Jun 2001 04:35:42 +0200."
             <20010611022716Z263344-17720+2633@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Jun 2001 14:48:40 +1000
Message-ID: <10820.992234920@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001 04:35:42 +0200, 
Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de> wrote:
>insmod: Warning: /lib/modules/2.4.5-ac12/kernel/drivers/net/3c509.o symbol 
>for parameter nopnp not found

MODULE_PARM(nopnp) is in open code but the declaration of nopnp is
wrapped in #ifdef CONFIG_ISAPNP.  The module parm needs to be wrapped
in #ifdef CONFIG_ISAPNP as well.  Against 2.4.5-ac13.

Index: 5.35/drivers/net/3c509.c
--- 5.35/drivers/net/3c509.c Sat, 09 Jun 2001 17:17:16 +1000 kaos (linux-2.4/l/c/31_3c509.c 1.2.1.6 644)
+++ 5.35(w)/drivers/net/3c509.c Mon, 11 Jun 2001 14:47:01 +1000 kaos (linux-2.4/l/c/31_3c509.c 1.2.1.6 644)
@@ -1014,8 +1014,10 @@ MODULE_PARM_DESC(debug, "EtherLink III d
 MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)");
 MODULE_PARM_DESC(xcvr,"EtherLink III tranceiver(s) (0=internal, 1=external)");
 MODULE_PARM_DESC(max_interrupt_work, "EtherLink III maximum events handled per interrupt");
+#ifdef CONFIG_ISAPNP
 MODULE_PARM(nopnp, "i");
 MODULE_PARM_DESC(nopnp, "EtherLink III disable ISA PnP support (0-1)");
+#endif	/* CONFIG_ISAPNP */
 
 int
 init_module(void)

