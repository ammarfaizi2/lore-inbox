Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274495AbRIYFLQ>; Tue, 25 Sep 2001 01:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274496AbRIYFLG>; Tue, 25 Sep 2001 01:11:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17804 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274495AbRIYFKz>;
	Tue, 25 Sep 2001 01:10:55 -0400
Date: Mon, 24 Sep 2001 22:11:19 -0700 (PDT)
Message-Id: <20010924.221119.90368086.davem@redhat.com>
To: taral@taral.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in ipip.c SIOCDELTUNNEL
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010922024241.A620@taral.net>
In-Reply-To: <20010922024241.A620@taral.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Taral <taral@taral.net>
   Date: Sat, 22 Sep 2001 02:42:41 -0500

   Patch is attached. Basically we were always removing "tunl0" even if a
   different tunnel was specified.
   
A bug in one tunnel driver is likely to be in all the
others :-)  I've taken care of that and the patch I am
using is below:

--- net/ipv4/ipip.c.~1~	Mon Sep 17 17:36:07 2001
+++ net/ipv4/ipip.c	Mon Sep 24 22:09:53 2001
@@ -1,7 +1,7 @@
 /*
  *	Linux NET3:	IP/IP protocol decoder. 
  *
- *	Version: $Id: ipip.c,v 1.47 2001/09/18 00:36:07 davem Exp $
+ *	Version: $Id: ipip.c,v 1.48 2001/09/25 05:09:53 davem Exp $
  *
  *	Authors:
  *		Sam Lantinga (slouken@cs.ucdavis.edu)  02/01/95
@@ -758,6 +758,7 @@
 			err = -EPERM;
 			if (t == &ipip_fb_tunnel)
 				goto done;
+			dev = t->dev;
 		}
 		err = unregister_netdevice(dev);
 		break;
--- net/ipv4/ip_gre.c.~1~	Wed May 16 22:27:58 2001
+++ net/ipv4/ip_gre.c	Mon Sep 24 22:08:43 2001
@@ -1011,6 +1011,7 @@
 			err = -EPERM;
 			if (t == &ipgre_fb_tunnel)
 				goto done;
+			dev = t->dev;
 		}
 		err = unregister_netdevice(dev);
 		break;
--- net/ipv6/sit.c.~1~	Fri Aug 31 17:31:50 2001
+++ net/ipv6/sit.c	Mon Sep 24 22:09:53 2001
@@ -6,7 +6,7 @@
  *	Pedro Roque		<roque@di.fc.ul.pt>	
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  *
- *	$Id: sit.c,v 1.52 2001/09/01 00:31:50 davem Exp $
+ *	$Id: sit.c,v 1.53 2001/09/25 05:09:53 davem Exp $
  *
  *	This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -712,6 +712,7 @@
 			err = -EPERM;
 			if (t == &ipip6_fb_tunnel)
 				goto done;
+			dev = t->dev;
 		}
 		err = unregister_netdevice(dev);
 		break;
