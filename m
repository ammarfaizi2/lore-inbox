Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWCPBix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWCPBix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCPBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:38:53 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:58343 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S932549AbWCPBiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:38:52 -0500
Date: Thu, 16 Mar 2006 09:36:02 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix ali5451 dereferenced before NULL check
To: linux-kernel@vger.kernel.org
Cc: Matt Wu <Matt_Wu@acersoftech.com.cn>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316013602.GA20455@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pvoice is missing a NULL check. channel needs a bound check too.

Coverity bug #862

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/pci/ali5451/ali5451.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/pci/ali5451/ali5451.c	2006-03-16 09:27:53.000000000 +0800
@@ -990,7 +990,13 @@
 	if (!(old & mask))
 		return;
 
+	if (channel < 0 || channel >= ALI_CHANNELS)
+		return;
+	
 	pvoice = &codec->synth.voices[channel];
+	if (pvoice == NULL)
+		return;
+
 	runtime = pvoice->substream->runtime;
 
 	udelay(100);

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

