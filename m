Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWGQTyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWGQTyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWGQTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:54:24 -0400
Received: from kurby.webscope.com ([204.141.84.54]:24760 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751173AbWGQTyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:54:24 -0400
Message-ID: <44BBEAB0.3080105@linuxtv.org>
Date: Mon, 17 Jul 2006 15:53:20 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: bttv-driver.c:3964: error: void value not ignored as it ought
 to be
References: <20060717124505.GD7281@neu.nirvana>
In-Reply-To: <20060717124505.GD7281@neu.nirvana>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Thimm wrote:
> latest hg fails on > 2.6.17 due to video_device_create_file being void
> but still being asked for a return value in bttv-driver.c
> 
> linux/drivers/media/video/bt8xx/bttv-driver.c:
> 
>    3963 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,17)
>    3964         ret = video_device_create_file(btv->video_dev, &class_device_attr_card);
>    3965         if (ret < 0)
> 
> 
> linux/include/media/v4l2-dev.h:
> 
>     379 static inline void
>     380 video_device_create_file(struct video_device *vfd,
>     381                          struct class_device_attribute *attr)
>     382 {
> 
>   CC [M]  /builddir/video4linux-20060717/v4l/flexcop-dma.o
>   CC [M]  /builddir/video4linux-20060717/v4l/bttv-driver.o
> /builddir/video4linux-20060717/v4l/bttv-driver.c: In function 'bttv_register_video':
> /builddir/video4linux-20060717/v4l/bttv-driver.c:3964: error: void value not ignored as it ought to be
> /builddir/video4linux-20060717/v4l/bttv-driver.c: In function 'bttv_probe':
> /builddir/video4linux-20060717/v4l/bttv-driver.c:4074: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'resource_size_t'
> /builddir/video4linux-20060717/v4l/bttv-driver.c:4086: warning: format '%lx' expects type 'long unsigned int', but argument 4 has type 'resource_size_t'
> make[3]: *** [/builddir/video4linux-20060717/v4l/bttv-driver.o] Error 1

Hmmm... This was caused by the "Check all __must_check warnings in
bttv." patch from Randy Dunlap (cc's from original thread added)

I am aware that this was done for various reasons of sanity checking,
however, we cannot check the return value of a void ;-)

-Mike
-- 
Michael Krufky

