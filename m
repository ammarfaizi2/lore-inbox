Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDDVeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDDVeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVDDVcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:32:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57094 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261417AbVDDVPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:15:36 -0400
Date: Mon, 4 Apr 2005 23:15:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] create a kstrdup library function
Message-ID: <20050404211531.GH4087@stusta.de>
References: <42519911.508@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42519911.508@grupopie.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a small bug:

<--  snip  -->

...
WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/net/sunrpc/sunrpc.ko needs 
unknown symbol kstrdup
WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/net/ipv6/ipv6.ko needs 
unknown symbol kstrdup
WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/drivers/parport/parport.ko 
needs unknown symbol kstrdup
WARNING: /lib/modules/2.6.12-rc1-mm4/kernel/drivers/md/dm-mod.ko needs 
unknown symbol kstrdup

<--  snip  -->


Obvious fix:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm4-modular/lib/string.c.old	2005-04-04 23:07:33.000000000 +0200
+++ linux-2.6.12-rc1-mm4-modular/lib/string.c	2005-04-04 23:09:50.000000000 +0200
@@ -619,3 +619,4 @@
 		memcpy(buf, s, len);
 	return buf;
 }
+EXPORT_SYMBOL(kstrdup);
