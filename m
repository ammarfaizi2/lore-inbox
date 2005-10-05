Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVJEUdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVJEUdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVJEUdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:33:54 -0400
Received: from farad.aurel32.net ([82.232.2.251]:25301 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1030380AbVJEUdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:33:53 -0400
Date: Wed, 5 Oct 2005 22:33:50 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc3] sis190.c: fix multicast MAC filter
Message-ID: <20051005203350.GA3096@farad.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.9i (2005-03-13)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch that changes the way the MAC filter is computed for the
multicast addresses. The computation is taken from the SiS GPL driver. 

This patch is necessary to get IPv6 working.

Thanks,
Aurelien


Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- linux-2.6.14-rc3-git4.orig/drivers/net/sis190.c	2005-10-05 22:06:51.000000000 +0200
+++ linux-2.6.14-rc3-git4/drivers/net/sis190.c	2005-10-05 22:12:05.000000000 +0200
@@ -842,7 +842,7 @@
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 		     i++, mclist = mclist->next) {
 			int bit_nr =
-				ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26;
+				ether_crc(ETH_ALEN, mclist->dmi_addr) & 0x3f;
 			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
 			rx_mode |= AcceptMulticast;
 		}


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
