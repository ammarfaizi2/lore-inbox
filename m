Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVFPHN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVFPHN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVFPHN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:13:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56228 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261770AbVFPHN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:13:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17073.9865.218749.808736@alkaid.it.uu.se>
Date: Thu, 16 Jun 2005 09:13:13 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Corey Minyard <wf-rch!minyard@relay.EU.net>,
       "Donald J. Becker" <becker@cesdis.gsfc.nasa.gov>,
       Alan Cox <Alan.Cox@linux.org>, "Bjorn Ekwall." <bj0rn@blox.se>,
       Pekka Riikonen <priikone@poseidon.pspt.fi>
Subject: Re: [PATCH] fix gcc -W warning in netdevice.h
In-Reply-To: <Pine.LNX.4.62.0506160053210.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506160053210.3842@dragon.hyggekrogen.localhost>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:
 > --- linux-2.6.12-rc6-mm1-orig/include/linux/netdevice.h	2005-06-12 15:58:58.000000000 +0200
 > +++ linux-2.6.12-rc6-mm1/include/linux/netdevice.h	2005-06-16 00:52:14.000000000 +0200
 > @@ -778,7 +778,7 @@ enum {
 >  static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 >  {
 >  	/* use default */
 > -	if (debug_value < 0 || debug_value >= (sizeof(u32) * 8))
 > +	if (debug_value < 0 || debug_value >= (int)(sizeof(u32) * 8))
 >  		return default_msg_enable_bits;

I'd change debug_value to unsigned, and drop the "< 0" test and the
now redundant "(int)" cast. Both cleaner and faster. Win Win :-)
