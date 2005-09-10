Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVIJUTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVIJUTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVIJUTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:19:32 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:58776 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S932278AbVIJUTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:19:31 -0400
Date: Sat, 10 Sep 2005 23:19:13 +0300
From: mikukkon@iki.fi
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix allnoconfig build with gcc4
Message-ID: <20050910201913.GA6179@miku.homelinux.net>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that git commit 20380731bc2897f2952ae055420972ded4cd786e breaks
allnoconfig build with gcc4:

  CC      init/main.o
In file included from include/linux/netdevice.h:29,
		   from include/net/sock.h:48,
		   from init/main.c:50:
include/linux/if_ether.h:114: error: array type has incomplete element type

The "normal" fix of replacing foo[] with *foo would is not trivial, but
simply removing the offending line is.

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

Index: linux-2.6/include/linux/if_ether.h
===================================================================
--- linux-2.6.orig/include/linux/if_ether.h
+++ linux-2.6/include/linux/if_ether.h
@@ -111,7 +111,6 @@ static inline struct ethhdr *eth_hdr(con
 	return (struct ethhdr *)skb->mac.raw;
 }
 
-extern struct ctl_table ether_table[];
 #endif
 
 #endif	/* _LINUX_IF_ETHER_H */
