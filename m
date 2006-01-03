Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWACR1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWACR1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWACR1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:27:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49917 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750784AbWACR1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:27:09 -0500
Subject: [PATCH] Update mcast rwlock for RT
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 03 Jan 2006 09:27:08 -0800
Message-Id: <1136309228.5915.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Corrects this mcast lock for RT . Seems like this should
really be an rwlock_init() .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/net/ipv6/mcast.c
===================================================================
--- linux-2.6.15.orig/net/ipv6/mcast.c
+++ linux-2.6.15/net/ipv6/mcast.c
@@ -224,7 +224,7 @@ int ipv6_sock_mc_join(struct sock *sk, i
 
 	mc_lst->ifindex = dev->ifindex;
 	mc_lst->sfmode = MCAST_EXCLUDE;
-	mc_lst->sflock = RW_LOCK_UNLOCKED;
+	mc_lst->sflock = RW_LOCK_UNLOCKED(mc_lst->sflock);
 	mc_lst->sflist = NULL;
 
 	/*


