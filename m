Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUH1KcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUH1KcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUH1KaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:30:25 -0400
Received: from [195.199.244.225] ([195.199.244.225]:10435 "HELO
	cinke.fazekas.hu") by vger.kernel.org with SMTP id S267438AbUH1K3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:29:52 -0400
Date: Sat, 28 Aug 2004 12:29:40 +0200 (CEST)
From: Balint Marton <cus@fazekas.hu>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: Re: [PATCH] [3/4] /dev/random: Use separate entropy store for
 /dev/urandom
Message-ID: <Pine.LNX.4.58.0408281204280.31452@cinke.fazekas.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

After using this patch, an already resolved bug returned (Tested with
2.6.9-rc1-bk3). For the old bug, see this thread (get_random_bytes returns
the same on every boot):  
http://marc.theaimsgroup.com/?l=linux-kernel&m=109053711812560&w=2

Now the situation is almost the same, except we read from the urandom pool
this time. The urandom pool is only cleared, and not initialized, and
because there is nothing in the primary pool, the reseeding is not
successful. The solution is also the same, initialize not just the primary
and secondary, but also the urandom pool:

--- linux-2.6.9-rc1-bk3/drivers/char/random.c.or	2004-08-28 10:12:28.000000000 +0200
+++ linux-2.6.9-rc1-bk3/drivers/char/random.c	2004-08-28 11:43:21.134293136 +0200
@@ -1548,6 +1548,7 @@
 	clear_entropy_store(urandom_state);
 	init_std_data(random_state);
 	init_std_data(sec_random_state);
+	init_std_data(urandom_state);
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif

bye, 
	Cus
