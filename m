Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbUKVBHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUKVBHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKVBHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:07:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14597 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261858AbUKVBFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:05:09 -0500
Date: Mon, 22 Nov 2004 02:05:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, Antonino Daplas <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041122010505.GB3007@stusta.de>
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk> <20041121205613.GA12634@infradead.org> <20041122000413.A27572@flint.arm.linux.org.uk> <20041122001051.GA3007@stusta.de> <20041122002136.A30668@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122002136.A30668@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 12:21:36AM +0000, Russell King wrote:
>...
> That leaves me as the sole provider of the source code, and the
> code has always been in the "experimental but useful" stage.  The
> capture code is something which doesn't meet my standards for
> mainline kernel inclusion.
>...

This sounds reasonable.

Below is only the rest of my patch.


<--  snip  -->


The patch below ncludes the following cleanups for 
drivers/video/cyber2000fb.c:
- make some needlessly global code static


diffstat output:
 drivers/video/cyber2000fb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.c.old	2004-11-21 15:05:10.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.c	2004-11-21 15:10:01.000000000 +0100
@@ -1306,7 +1233,8 @@
  * Parse Cyber2000fb options.  Usage:
  *  video=cyber2000:font:fontname
  */
-int
+#ifndef MODULE
+static int
 cyber2000fb_setup(char *options)
 {
 	char *opt;
@@ -1328,6 +1256,7 @@
 	}
 	return 0;
 }
+#endif
 
 /*
  * The CyberPro chips can be placed on many different bus types.
@@ -1717,7 +1646,7 @@
  *
  * Tony: "module_init" is now required
  */
-int __init cyber2000fb_init(void)
+static int __init cyber2000fb_init(void)
 {
 	int ret = -1, err;
 


