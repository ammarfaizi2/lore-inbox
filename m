Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVKTCHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVKTCHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 21:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVKTCHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 21:07:30 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:63360 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751150AbVKTCH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 21:07:29 -0500
Date: Sun, 20 Nov 2005 03:06:49 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Message-ID: <20051120020649.GB8157@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20051119075226.GA16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119075226.GA16060@stusta.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.225.148
Subject: Re: [linux-dvb-maintainer] [2.6 patch] drivers/media/dvb/: small cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make needlessly global functions static
> - every file should #include the headers containing the prototypes for
>   it's global functions
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I added your patch to linuxtv.org CVS.

Thanks,
Johannes


>  drivers/media/dvb/b2c2/flexcop-hw-filter.c |    2 +-
>  drivers/media/dvb/dvb-usb/a800.c           |    2 +-
>  drivers/media/dvb/dvb-usb/digitv.c         |    2 +-
>  drivers/media/dvb/dvb-usb/dvb-usb-init.c   |    2 +-
>  drivers/media/dvb/ttpci/av7110_ca.c        |    1 +
>  drivers/media/dvb/ttpci/ttpci-eeprom.c     |    1 +
>  6 files changed, 6 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/b2c2/flexcop-hw-filter.c.old	2005-11-19 03:55:04.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-11-19 03:55:16.000000000 +0100
> @@ -19,7 +19,7 @@
>  	flexcop_set_ibi_value(ctrl_208,SMC_Enable_sig,onoff);
>  }
>  
> -void flexcop_null_filter_ctrl(struct flexcop_device *fc, int onoff)
> +static void flexcop_null_filter_ctrl(struct flexcop_device *fc, int onoff)
>  {
>  	flexcop_set_ibi_value(ctrl_208,Null_filter_sig,onoff);
>  }
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/a800.c.old	2005-11-19 03:55:57.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/a800.c	2005-11-19 03:56:05.000000000 +0100
> @@ -65,7 +65,7 @@
>  
>  };
>  
> -int a800_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
> +static int a800_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
>  {
>  	u8 key[5];
>  	if (usb_control_msg(d->udev,usb_rcvctrlpipe(d->udev,0),
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/digitv.c.old	2005-11-19 03:56:30.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/digitv.c	2005-11-19 03:56:39.000000000 +0100
> @@ -148,7 +148,7 @@
>  };
>  
>  /* TODO is it really the NEC protocol ? */
> -int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
> +static int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
>  {
>  	u8 key[5];
>  
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-init.c.old	2005-11-19 03:56:58.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-11-19 03:57:07.000000000 +0100
> @@ -23,7 +23,7 @@
>  MODULE_PARM_DESC(disable_rc_polling, "disable remote control polling (default: 0).");
>  
>  /* general initialization functions */
> -int dvb_usb_exit(struct dvb_usb_device *d)
> +static int dvb_usb_exit(struct dvb_usb_device *d)
>  {
>  	deb_info("state before exiting everything: %x\n",d->state);
>  	dvb_usb_remote_exit(d);
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/ttpci/ttpci-eeprom.c.old	2005-11-19 03:57:29.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/ttpci/ttpci-eeprom.c	2005-11-19 03:57:43.000000000 +0100
> @@ -37,6 +37,7 @@
>  #include <linux/string.h>
>  #include <linux/i2c.h>
>  
> +#include "ttpci-eeprom.h"
>  
>  #if 1
>  #define dprintk(x...) do { printk(x); } while (0)
> --- linux-2.6.15-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_ca.c.old	2005-11-19 03:58:05.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_ca.c	2005-11-19 03:58:17.000000000 +0100
> @@ -40,6 +40,7 @@
>  
>  #include "av7110.h"
>  #include "av7110_hw.h"
> +#include "av7110_ca.h"
>  
>  
>  void CI_handle(struct av7110 *av7110, u8 *data, u16 len)
> 
> 
> _______________________________________________
> linux-dvb-maintainer mailing list
> linux-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/linux-dvb-maintainer
> 
