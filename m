Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKIVLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKIVLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKIVLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:11:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261688AbUKIVLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:11:42 -0500
Date: Tue, 9 Nov 2004 22:11:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Markus Trippelsdorf <markus@trippelsdorf.de>,
       Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
Message-ID: <20041109211107.GB5892@stusta.de>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100018489.7011.4.camel@lb.loomes.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 05:41:28PM +0100, Markus Trippelsdorf wrote:
> On Tue, 2004-11-09 at 07:49 -0800, Andrew Morton wrote:
> 
> > - v4l updates, fbdev updates.
> 
> It does not link here on amd64 using an build-in BT848 driver.  
> 
> LD      vmlinux
> drivers/built-in.o(.init.text+0xba4d): In function `p_radio':
> : undefined reference to `bttv_parse'
> make: *** [vmlinux] Error 1

Thanks for this report.

This problem is not specific to amd64.

@Gerd:
This is caused by your bttv updates included in -mm.

As far as I can see, the radio parameter is already handled correctly.
Is the patch below correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full/drivers/media/video/bttv-driver.c.old	2004-11-09 21:57:35.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/media/video/bttv-driver.c	2004-11-09 22:04:36.000000000 +0100
@@ -127,12 +127,6 @@
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
 MODULE_LICENSE("GPL");
 
-/* kernel args */
-#ifndef MODULE
-static int __init p_radio(char *str) { return bttv_parse(str,BTTV_MAX,radio); }
-__setup("bttv.radio=", p_radio);
-#endif
-
 /* ----------------------------------------------------------------------- */
 /* sysfs                                                                   */
 

