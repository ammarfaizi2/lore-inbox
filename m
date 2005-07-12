Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVGLWft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVGLWft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVGLWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:34:07 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:5760 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262420AbVGLWde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:33:34 -0400
Date: Wed, 13 Jul 2005 00:36:00 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Message-ID: <20050712223600.GA30240@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Michael Krufky <mkrufky@m1k.net>, Andrew Morton <akpm@osdl.org>,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	linux-kernel@vger.kernel.org,
	Linux and Kernel Video <video4linux-list@redhat.com>
References: <42D3DC5A.3010807@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D3DC5A.3010807@m1k.net>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.244.201
Subject: Re: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:
> diff -upr linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
> --- linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c	2005-07-12 08:56:58.000000000 +0000
> +++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-12 09:01:13.000000000 +0000
> @@ -30,6 +30,11 @@
>  #include <linux/file.h>
>  #include <linux/suspend.h>
>  
> +#define CONFIG_DVB_MT352 1
> +#define CONFIG_DVB_CX22702 1
> +#define CONFIG_DVB_OR51132 1
> +#define CONFIG_DVB_LGDT3302 1
> +
>  #include "cx88.h"
>  #include "dvb-pll.h"
>  
> diff -upr linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
> --- linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-12 08:56:59.000000000 +0000
> +++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-12 09:01:55.000000000 +0000
> @@ -30,6 +30,9 @@
>  #include <linux/kthread.h>
>  #include <linux/suspend.h>
>  
> +#define CONFIG_DVB_MT352 1
> +#define CONFIG_DVB_TDA1004X 1
> +
>  #include "saa7134-reg.h"
>  #include "saa7134.h"
>  


A better fix would be to remove the #ifdefs which use this defines.
They are now pointless as Kconfig selects those DVB frontends. As
Gerd Knorr pointed out they were originally introduced as a
workaround because the DVB maintainer was too slow merging
sending patches which the saa7134-dvb.c and cx88-dvb.c
drivers depended on.

Johannes
