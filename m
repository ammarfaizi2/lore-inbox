Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751994AbWCPBrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbWCPBrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWCPBrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:47:48 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:57594 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751994AbWCPBrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:47:47 -0500
Date: Thu, 16 Mar 2006 09:46:06 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix seq_clientmgr dereferences before NULL check
To: linux-kernel@vger.kernel.org
Cc: Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316014606.GA20609@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cptr->pool dereferences before NULL check.

Coverity bug #860

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/core/seq/seq_clientmgr.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/core/seq/seq_clientmgr.c	2006-03-16 09:41:05.000000000 +0800
@@ -1862,12 +1862,13 @@
 	cptr = snd_seq_client_use_ptr(info.client);
 	if (cptr == NULL)
 		return -ENOENT;
+	if (cptr->pool == NULL)
+		return -ENOENT;
 	memset(&info, 0, sizeof(info));
 	info.output_pool = cptr->pool->size;
 	info.output_room = cptr->pool->room;
 	info.output_free = info.output_pool;
-	if (cptr->pool)
-		info.output_free = snd_seq_unused_cells(cptr->pool);
+	info.output_free = snd_seq_unused_cells(cptr->pool);
 	if (cptr->type == USER_CLIENT) {
 		info.input_pool = cptr->data.user.fifo_pool_size;
 		info.input_free = info.input_pool;

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

