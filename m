Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSHLV0G>; Mon, 12 Aug 2002 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSHLV0G>; Mon, 12 Aug 2002 17:26:06 -0400
Received: from verein.lst.de ([212.34.181.86]:46605 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318825AbSHLV0F>;
	Mon, 12 Aug 2002 17:26:05 -0400
Date: Mon, 12 Aug 2002 23:29:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix current BK tree compilation with devfs enabled
Message-ID: <20020812232951.A28268@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not that I care for devfs, but there was at least one report on lkml.

I tried to also put the devfs_handle_t under CONFIG_DEVFS_FS, but the
devfs wrappers require it.  And yes, I'm seriously pissed that devfs
puts wordsize objects everywhere even if not enabled.


--- linux-2.4.20-bk-20020810/include/linux/genhd.h	Sat Aug 10 14:37:16 2002
+++ linux/include/linux/genhd.h	Mon Aug 12 23:40:37 2002
@@ -62,7 +62,9 @@ struct hd_struct {
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-
+#ifdef CONFIG_DEVFS_FS
+	int number;
+#endif /* CONFIG_DEVFS_FS */
 #ifdef CONFIG_BLK_STATS
 	/* Performance stats: */
 	unsigned int ios_in_flight;
