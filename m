Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEGKoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEGKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUEGKoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 06:44:16 -0400
Received: from verein.lst.de ([212.34.189.10]:47310 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263107AbUEGKoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 06:44:14 -0400
Date: Fri, 7 May 2004 12:44:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill useless MOD_{INC,DEC}_USE_COUNT in sound/oss/msnd.c
Message-ID: <20040507104406.GB10873@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

callers are exported register/unregister handlers so the module is
locked in core by users of said exports.


--- 1.7/sound/oss/msnd.c	Thu Feb 19 04:42:59 2004
+++ edited/sound/oss/msnd.c	Mon May  3 13:30:22 2004
@@ -59,9 +59,6 @@
 
 	devs[i] = dev;
 	++num_devs;
-
-	MOD_INC_USE_COUNT;
-
 	return 0;
 }
 
@@ -80,8 +77,6 @@
 
 	devs[i] = NULL;
 	--num_devs;
-
-	MOD_DEC_USE_COUNT;
 }
 
 int msnd_get_num_devs(void)
