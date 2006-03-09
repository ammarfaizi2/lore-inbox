Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWCIRWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWCIRWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWCIRWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:22:16 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:24899 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751014AbWCIRWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:22:15 -0500
Message-ID: <44106557.5010004@openvz.org>
Date: Thu, 09 Mar 2006 20:26:47 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce sched latency in shrink_dcache_sb()
Content-Type: multipart/mixed;
 boundary="------------070805080607020407050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070805080607020407050805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch reduces scheduling latency in shrink_dcache_sb()
noticed during remounting of big partitions with many cached dentries.
The same latency fix was applied to select_parent() long ago.

Signed-Off-By: Denis Lunev <den@sw.ru>
Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Thanks,
Kirill

--------------070805080607020407050805
Content-Type: text/plain;
 name="diff-ms-shrink-dcache-latency2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-shrink-dcache-latency2"

--- ./fs/dcache.c.lat	2006-03-09 16:03:44.000000000 +0300
+++ ./fs/dcache.c	2006-03-09 20:19:41.000000000 +0300
@@ -491,6 +491,7 @@ repeat:
 			continue;
 		}
 		prune_one_dentry(dentry);
+		cond_resched_lock(&dcache_lock);
 		goto repeat;
 	}
 	spin_unlock(&dcache_lock);

--------------070805080607020407050805--

