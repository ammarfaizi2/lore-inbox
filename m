Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTJVKgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTJVKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:36:15 -0400
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:55264 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S263513AbTJVKgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:36:13 -0400
Message-ID: <3F965D57.8080706@ppp0.net>
Date: Wed, 22 Oct 2003 12:35:03 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prasad <prasad@atc.tcs.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: [REPOST] The Linux Progress Patch for 2.6 Kernels
References: <1066815305.2340.27.camel@Prasad>
In-Reply-To: <1066815305.2340.27.camel@Prasad>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad wrote:
> The patch was made against 2.6.0-Test5 but should
> perfectly work for the recent ones too.

I need the following patch w/ test8-mm1 to get it compile. Otherwise it 
works quite well (i810fb). The screen is a bit distorted for the first 
few messages after elpp kicks in and the bottom line, where the messages 
appear, isn't cleared to the end. Also the background right of the eye 
is changing from black to red in the middle of the boot progress for no 
apparent reason (I've no supporting bootscripts).

Thanks,

Jan

--- drivers/video/console/elpp.c.org    2003-10-22 12:13:51.000000000 +0200
+++ drivers/video/console/elpp.c        2003-10-22 12:17:20.000000000 +0200
@@ -303,11 +303,11 @@
      size = pitch * font->height;
      size += buf_align;
      size &= ~buf_align;
-    dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
+    dst = fb_get_buffer_offset(info, &info->pixmap, size);
      image.data = dst;
      src = font->data + (ch & charmask) * font->height * width;

-    move_buf_aligned(info, dst, src, pitch, width, image.height);
+    move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, 
image.height);
      info->fbops->fb_imageblit(info, &image);
  }

