Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVEXNP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVEXNP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVEXNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:13:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:3515 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262064AbVEXNMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:12:06 -0400
Date: Tue, 24 May 2005 15:12:04 +0200
From: Jiri Benc <jbenc@suse.cz>
To: NetDev <netdev@oss.sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, pavel@suse.cz
Subject: [3/5] netdev: HH_DATA_OFF bugfix
Message-ID: <20050524151204.554f73cb@griffin.suse.cz>
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
References: <20050524150711.01632672@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the hardware header size is a multiple of HH_DATA_MOD, HH_DATA_OFF()
incorrectly returns HH_DATA_MOD (instead of 0).

Signed-off-by: Jiri Benc <jbenc@suse.cz>

--- linux/include/linux/netdevice.h
+++ work/include/linux/netdevice.h
@@ -204,7 +209,7 @@
 	/* cached hardware header; allow for machine alignment needs.        */
 #define HH_DATA_MOD	16
 #define HH_DATA_OFF(__len) \
-	(HH_DATA_MOD - ((__len) & (HH_DATA_MOD - 1)))
+	(HH_DATA_MOD - (((__len - 1) & (HH_DATA_MOD - 1)) + 1))
 #define HH_DATA_ALIGN(__len) \
 	(((__len)+(HH_DATA_MOD-1))&~(HH_DATA_MOD - 1))
 	unsigned long	hh_data[HH_DATA_ALIGN(LL_MAX_HEADER) / sizeof(long)];


--
Jiri Benc
SUSE Labs
