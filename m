Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbSIZCeu>; Wed, 25 Sep 2002 22:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSIZCeu>; Wed, 25 Sep 2002 22:34:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:43981 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262144AbSIZCet>;
	Wed, 25 Sep 2002 22:34:49 -0400
Date: Wed, 25 Sep 2002 19:39:50 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.20-pre8] irtty MODEM_BITS additional fix
Message-ID: <20020926023950.GA17708@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

	Alan did fix the compile of the irtty driver for i386 in
pre8. Unfortunately, there is still many platforms which doesn't
compile, including some that I know where IrDA is heavily used (PPC,
ARM).
	This patch make sure the code works on all platforms. It's
2.4.X, so I guess the code *must* work.

	Regards,

	Jean

P.S. : Russel : this is an opportunity to fix the ARM platform
difference in the proper way. I guess irtty is still used on some ARM
platforms (especially with serial dongles).

-----------------------------------------------

--- linux/drivers/net/irda/irtty.a0.c	Wed Sep 25 19:10:25 2002
+++ linux/drivers/net/irda/irtty.c	Wed Sep 25 19:18:14 2002
@@ -46,6 +46,19 @@ static struct tty_ldisc irda_ldisc;
 
 static int qos_mtt_bits = 0x03;      /* 5 ms or more */
 
+/* To workaround some of the difference in the serial driver over various
+ * arch, some people have introduced TIOCM_MODEM_BITS.
+ * Unfortunately, this is not yet defined on all architectures, so
+ * we make sure the code is still usable. - Jean II */
+#ifndef TIOCM_MODEM_BITS
+#warning "Please define TIOCM_MODEM_BITS in termios.h !"
+#ifdef TIOCM_OUT2
+#define TIOCM_MODEM_BITS	TIOCM_OUT2	/* Most architectures */
+#else
+#define TIOCM_MODEM_BITS	0		/* Not defined for ARM */
+#endif
+#endif
+
 /* Network device fuction prototypes */
 static int  irtty_hard_xmit(struct sk_buff *skb, struct net_device *dev);
 static int  irtty_net_init(struct net_device *dev);
