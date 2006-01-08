Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWAHHWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWAHHWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWAHHWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:22:09 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:30181 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932702AbWAHHWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:22:08 -0500
Message-ID: <43C0BA1C.6080500@gmail.com>
Date: Sun, 08 Jan 2006 11:07:08 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
References: <20060107181258.GM3774@stusta.de>
In-Reply-To: <20060107181258.GM3774@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>This patch contains the following possible cleanups:
>- make needlessly global code static
>- #if 0 the following unused global functions:
>  - b2c2/flexcop-dma.c: flexcop_dma_control_packet_irq()
>  - b2c2/flexcop-dma.c: flexcop_dma_config_packet_count()
>
>Please review which of these changes do make sense and which conflict 
>with pending patches.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>
> u8 dst_check_sum(u8 * buf, u32 len);
> struct dst_state* dst_attach(struct dst_state* state, struct dvb_adapter *dvb_adapter);
> int dst_ca_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter);
>-int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh, int delay);
>-
>-int dst_command(struct dst_state* state, u8 * data, u8 len);
> 
> 
> #endif // DST_COMMON_H
>--- linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst.c.old	2006-01-07 16:42:33.000000000 +0100
>+++ linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst.c	2006-01-07 16:54:56.000000000 +0100
>@@ -63,6 +63,7 @@
> 	}										\
> } while(0)
> 
>+static int dst_command(struct dst_state *state, u8 *data, u8 len);
> 
> static void dst_packsize(struct dst_state *state, int psize)
> {
>@@ -72,7 +73,8 @@
> 	bt878_device_control(state->bt, DST_IG_TS, &bits);
> }
> 
>-int dst_gpio_outb(struct dst_state *state, u32 mask, u32 enbb, u32 outhigh, int delay)
>+static int dst_gpio_outb(struct dst_state *state, u32 mask, u32 enbb,
>+			 u32 outhigh, int delay)
> {
> 	union dst_gpio_packet enb;
> 	union dst_gpio_packet bits;
>@@ -101,9 +103,8 @@
> 
> 	return 0;
> }
>-EXPORT_SYMBOL(dst_gpio_outb);
> 
>-int dst_gpio_inb(struct dst_state *state, u8 *result)
>+static int dst_gpio_inb(struct dst_state *state, u8 *result)
> {
> 	union dst_gpio_packet rd_packet;
> 	int err;
>@@ -117,7 +118,6 @@
> 
> 	return 0;
> }
>-EXPORT_SYMBOL(dst_gpio_inb);
> 
> int rdc_reset_state(struct dst_state *state)
> {
>@@ -137,7 +137,7 @@
> }
> EXPORT_SYMBOL(rdc_reset_state);
> 
>-int rdc_8820_reset(struct dst_state *state)
>+static int rdc_8820_reset(struct dst_state *state)
> {
> 	dprintk(verbose, DST_DEBUG, 1, "Resetting DST");
> 	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, 0, NO_DELAY) < 0) {
>@@ -152,9 +152,8 @@
> 
> 	return 0;
> }
>-EXPORT_SYMBOL(rdc_8820_reset);
> 
>-int dst_pio_enable(struct dst_state *state)
>+static int dst_pio_enable(struct dst_state *state)
> {
> 	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_ENABLE, 0, NO_DELAY) < 0) {
> 		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
>@@ -164,7 +163,6 @@
> 
> 	return 0;
> }
>-EXPORT_SYMBOL(dst_pio_enable);
> 
> int dst_pio_disable(struct dst_state *state)
> {
>@@ -602,7 +600,7 @@
> 
> */
> 
>-struct dst_types dst_tlist[] = {
>+static struct dst_types dst_tlist[] = {
> 	{
> 		.device_id = "200103A",
> 		.offset = 0,
>@@ -958,7 +956,7 @@
> 	return 0;
> }
> 
>-int dst_command(struct dst_state *state, u8 *data, u8 len)
>+static int dst_command(struct dst_state *state, u8 *data, u8 len)
> {
> 	u8 reply;
> 
>@@ -1021,7 +1019,6 @@
> 	return -EIO;
> 
> }
>-EXPORT_SYMBOL(dst_command);
> 
> static int dst_get_signal(struct dst_state *state)
> {
>  
>

dst is currently a bit broken ATM and there are quite a bit changes that 
haven't yet gone into linuxtv.org CVS tree. So i would be of the 
opinion, that if you can hold off on the patches to the dst/dst_ca 
module till it's fixed, that would be quite helpful.


Thanks,
Manu

