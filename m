Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbUBBUIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUBBUHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:07:21 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:1673 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266058AbUBBUFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:05:24 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:05:22 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 41/42]
Message-ID: <20040202200522.GO6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tms380tr.c:1449: warning: long unsigned int format, different type arg (arg 3)

Bad cast, fixed.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/tokenring/tms380tr.c linux-2.4/drivers/net/tokenring/tms380tr.c
--- linux-2.4-vanilla/drivers/net/tokenring/tms380tr.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4/drivers/net/tokenring/tms380tr.c	Sat Jan 31 19:17:40 2004
@@ -1446,7 +1446,7 @@
 	if(tms380tr_debug > 3)
 	{
 		printk(KERN_INFO "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (unsigned long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
 		printk(KERN_INFO "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
 		printk(KERN_INFO "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
This message will self distruct in 5 seconds.
