Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWCPAyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWCPAyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCPAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:54:55 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:12696 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751333AbWCPAyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:54:54 -0500
Date: Thu, 16 Mar 2006 08:54:54 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix sb_mixer use before validation
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316005454.GA20151@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that OSS is obsoleted by ALSA but here's a patch anyways.

Eugene

--
dev should be validated before it is being used as index to array.

Coverity bug #871

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sb_mixer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sb_mixer.c	2006-03-16 08:28:48.000000000 +0800
@@ -273,14 +273,14 @@
 	int regoffs;
 	unsigned char val;
 
+	if ((dev < 0) || (dev >= devc->iomap_sz))
+		return -EINVAL;
+
 	regoffs = (*devc->iomap)[dev][LEFT_CHN].regno;
 
 	if (regoffs == 0)
 		return -EINVAL;
 
-	if ((dev < 0) || (dev >= devc->iomap_sz))
-	    return -EINVAL;
-
 	val = sb_getmixer(devc, regoffs);
 	change_bits(devc, &val, dev, LEFT_CHN, left);
 
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

