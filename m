Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTFROf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTFROf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:35:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43483 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265263AbTFROfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:35:17 -0400
Date: Wed, 18 Jun 2003 15:49:12 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.72 and a move to OSDL
In-Reply-To: <Pine.LNX.4.44.0306162131350.1644-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.53.0306181541430.27745@skynet>
References: <Pine.LNX.4.44.0306162131350.1644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Linus Torvalds wrote:

>
> Ok, I waited too long for 2.5.71, so here's a more timely 2.5.72
> release.
>

Building the 3c509 network driver as a module depends on
netdev_boot_setup_check() which is not exported as a symbol. Patch to
export it is at the end of the email but is probably the wrong fix as this
dependancy was only introduced between 2.5.70 and 2.5.72 somewhere. Other
drivers which now appear to need this symbol are

drivers/net/tokenring/skisa.c
drivers/net/tokenring/smctr.c
drivers/net/tokenring/proteon.c

> The other big news - well, for me personally, anyway - is that I've
> decided to take a leave-of-absense after 6+ years at Transmeta to
> actually work full-time on the kernel.
>

I would give a "Good luck from me too" but I appear to have left it in my
other email account :-)

-- 
Mel Gorman

--- linux-2.5.72-clean/net/core/dev.c   Tue Jun 17 05:20:02 2003
+++ linux-2.5.72-mel/net/core/dev.c     Wed Jun 18 12:03:09 2003
@@ -3029,3 +3029,4 @@
 }

 subsys_initcall(net_dev_init);
+EXPORT_SYMBOL(netdev_boot_setup_check);
