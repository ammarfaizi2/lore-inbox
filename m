Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVCBFCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVCBFCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVCBFCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:02:17 -0500
Received: from verein.lst.de ([213.95.11.210]:27833 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262175AbVCBFCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:02:14 -0500
Date: Wed, 2 Mar 2005 06:02:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] put newly registered shrinkers at the tail of the list
Message-ID: <20050302050206.GB21709@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This way we actually share dentries before inodes and thus mark more
inodes reclaimable once we shake them.


--- 1.240/mm/vmscan.c	2005-02-04 01:53:32 +01:00
+++ edited/mm/vmscan.c	2005-03-02 07:09:00 +01:00
@@ -137,7 +137,7 @@ struct shrinker *set_shrinker(int seeks,
 	        shrinker->seeks = seeks;
 	        shrinker->nr = 0;
 	        down_write(&shrinker_rwsem);
-	        list_add(&shrinker->list, &shrinker_list);
+	        list_add_tail(&shrinker->list, &shrinker_list);
 	        up_write(&shrinker_rwsem);
 	}
 	return shrinker;
