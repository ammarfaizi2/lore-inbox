Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032314AbWLGPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032314AbWLGPjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032318AbWLGPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:39:08 -0500
Received: from kurby.webscope.com ([204.141.84.54]:50958 "EHLO
	kirby.webscope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032314AbWLGPjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:39:05 -0500
Message-ID: <457834E1.1090406@linuxtv.org>
Date: Thu, 07 Dec 2006 10:36:01 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] cx88/saa7134: remove unused
 -DHAVE_VIDEO_BUF_DVB
References: <20061207150028.GJ8963@stusta.de>
In-Reply-To: <20061207150028.GJ8963@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch removes the unused HAVE_VIDEO_BUF_DVB define.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile.old	2006-12-07 15:04:11.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile	2006-12-07 15:05:04.000000000 +0100
> @@ -13,7 +13,6 @@
>  EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
>  EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
>  
> -extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
>  extra-cflags-$(CONFIG_VIDEO_CX88_VP3054)+= -DHAVE_VP3054_I2C=1
>  
>  EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)
> --- linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile.old	2006-12-07 15:04:45.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile	2006-12-07 15:04:58.000000000 +0100
> @@ -15,6 +15,3 @@
>  EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
>  EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
>  
> -extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
> -
> -EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

NACK.

HAVE_VIDEO_BUF_DVB is not "unused" ... This symbol is tested for in the
following locations:

cx88.h:34:#ifdef HAVE_VIDEO_BUF_DVB
cx88.h:327:#ifdef HAVE_VIDEO_BUF_DVB
cx88.h:503:#ifdef HAVE_VIDEO_BUF_DVB
cx88-i2c.c:157:#ifdef HAVE_VIDEO_BUF_DVB
saa7134.h:51:#ifdef HAVE_VIDEO_BUF_DVB
saa7134.h:569:#ifdef HAVE_VIDEO_BUF_DVB

...We need this in order to allow compilation of the cx88 / saa7134 modules
without DVB support. (analog only)

If you want to convert the HAVE_VIDEO_BUF_DVB to a kconfig #ifdef test
for CONFIG_VIDEO_BUF_DVB, that would be acceptable.

Regards,

Michael Krufky

