Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDEK4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUDEK4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:56:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:23786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261931AbUDEK4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:56:18 -0400
Date: Mon, 5 Apr 2004 03:56:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-Id: <20040405035606.0b470efb.akpm@osdl.org>
In-Reply-To: <4071394A.1060007@abbeynet.it>
References: <406D3E8F.20902@abbeynet.it>
	<20040402153628.4a09d979.akpm@osdl.org>
	<4071394A.1060007@abbeynet.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Fais <marco.fais@abbeynet.it> wrote:
>
> Andrew Morton ha scritto:
> 
> >>kernel BUG at page_alloc.c:98!
> > uh-oh.
> 
> That was the same thing that I've said when I saw all the leds blinking 
> in *all* the keyboards ... :)
> 
> > distcc uses sendfile().  The 8139too hardware and driver are
> > zerocopy-capable so the kernel uses zerocopy direct-from-user-pages for
> > sendfile().
> 
> Ok. Other servers with e100 driver doesn't show the problem. This means 
> that they're not "zerocopy-capable"?

They are.  It could be a timing thing.

> > This was all discussed fairly extensively a couple of years back and I
> > thought it ended up being fixed.
> 
> There are any workarounds for this, until the problem is corrected?

This will probably make it go away.

--- linux-2.4.26-rc1/drivers/net/8139too.c	2004-03-27 22:06:18.000000000 -0800
+++ 24/drivers/net/8139too.c	2004-04-05 03:54:50.478692968 -0700
@@ -983,7 +983,7 @@ static int __devinit rtl8139_init_one (s
 	 * through the use of skb_copy_and_csum_dev we enable these
 	 * features
 	 */
-	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
+	dev->features |= NETIF_F_SG | NETIF_F_HIGHDMA;
 
 	dev->irq = pdev->irq;
 

