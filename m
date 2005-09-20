Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVITHjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVITHjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVITHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:39:17 -0400
Received: from mail.portrix.net ([212.202.157.208]:2474 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S964901AbVITHjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:39:17 -0400
Message-ID: <432FBC93.4040007@ppp0.net>
Date: Tue, 20 Sep 2005 09:38:59 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com>
In-Reply-To: <432F36B4.8030209@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Jan Dittmer wrote:
> 
>>jurriaan wrote:
>>
>>>After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
>>>my console.
>>
>>Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
>>sorry. No fb options on the kernel command line.
>>
> 
> 
> Can you try reversing this particular diff?
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a
> 
> Tony
> 

--- 30f80c23f934bb0a76719232f492153fc7cca00a
+++ af99ea96012ec72ef57fd36655a6d8aaa22e809e

^^^ Which file??


@@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
 	int i, set = cursor->set;
 	u16 fg, bg;

-	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return -ENXIO;

 	NVShowHideCursor(par, 0);
@@ -1356,8 +1356,6 @@ static int __devinit nvidia_set_fbinfo(s
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;

-	if (!hwcur)
-		info->fbops->fb_cursor = soft_cursor;
 	info->var.accel_flags = (!noaccel);

 	switch (par->Architecture) {


-- 
Jan
