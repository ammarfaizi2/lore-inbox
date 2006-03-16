Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWCPBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWCPBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWCPBTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:19:16 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:18882 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751969AbWCPBTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:19:15 -0500
Date: Thu, 16 Mar 2006 09:19:11 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix sequencer missing negative bound check
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316011911.GA20384@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev is missing a negative bound check.

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sequencer.c	2006-03-16 09:06:59.000000000 +0800
@@ -713,7 +713,7 @@
 	int i, l = 0;
 	unsigned char  *buf = &event_rec[2];
 
-	if ((int) dev > max_synthdev)
+	if (dev < 0 || dev >= max_synthdev)
 		return;
 	if (!(synth_open_mask & (1 << dev)))
 		return;

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

