Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268862AbTCARAr>; Sat, 1 Mar 2003 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbTCARAr>; Sat, 1 Mar 2003 12:00:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17802 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268862AbTCARAq>; Sat, 1 Mar 2003 12:00:46 -0500
Date: Sat, 01 Mar 2003 09:11:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <garzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix warning in drivers/net/sis900.c
Message-ID: <51890000.1046538667@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/sis900.c: In function `set_rx_mode':
drivers/net/sis900.c:2100: warning: passing arg 2 of `set_bit' from incompatible pointer type

I just cast this. Seems to work fine at the moment, so presumably it's
correct.

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/net/sis900.c sisfix/drivers/net/sis900.c
--- virgin/drivers/net/sis900.c	Tue Feb 25 23:03:47 2003
+++ sisfix/drivers/net/sis900.c	Sat Mar  1 08:39:16 2003
@@ -2097,7 +2097,7 @@ static void set_rx_mode(struct net_devic
 		for (i = 0, mclist = net_dev->mc_list; mclist && i < net_dev->mc_count;
 		     i++, mclist = mclist->next)
 			set_bit(sis900_compute_hashtable_index(mclist->dmi_addr, revision),
-				mc_filter);
+				(unsigned long *) mc_filter);
 	}
 
 	/* update Multicast Hash Table in Receive Filter */

