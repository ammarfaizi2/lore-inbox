Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVAFLWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVAFLWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVAFLWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:22:15 -0500
Received: from smtp07.web.de ([217.72.192.225]:3802 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S262578AbVAFLWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:22:09 -0500
Date: Thu, 6 Jan 2005 12:24:09 +0100
From: Arne Ahrend <aahrend@web.de>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] PATCH: DVB bt8xx in 2.6.10
Message-Id: <20050106122409.195100bb.aahrend@web.de>
In-Reply-To: <20050104181153.GA1416@linuxtv.org>
References: <20050104175043.6a8fd195.aahrend@web.de>
	<20050104181153.GA1416@linuxtv.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 19:11:53 +0100
Johannes Stezenbach <js@linuxtv.org> wrote:

> This approach has been discussed on the linux-dvb list and was rejected
> because of the huge #ifdef mess it creates (you just touched bt8xx, it's
> even worse for saa7146 based cards). The frontend drivers are
> tiny so I think you can afford to load some that aren't actually
> used by your hardware.


Ok, point acknowledged. The following tiny bit of cosmetic might
be of interest anyway.

Arne



diff -upr -X dontdiff linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-04 15:36:33.000000000 +0100
+++ linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-05 00:57:19.000000000 +0100
@@ -220,7 +220,7 @@ static int microtune_mt7202dtf_request_f
 	return request_firmware(fw, name, &bt->bt->dev->dev);
 }
 
-struct sp887x_config microtune_mt7202dtf_config = {
+static struct sp887x_config microtune_mt7202dtf_config = {
 
 	.demod_address = 0x70,
 	.pll_set = microtune_mt7202dtf_pll_set,
diff -upr -X dontdiff linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-04 15:36:33.000000000 +0100
+++ linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-05 00:58:39.000000000 +0100
@@ -22,6 +22,9 @@
  *
  */
 
+#ifndef DVB_BT8XX_H
+#define DVB_BT8XX_H
+
 #include <linux/i2c.h>
 #include "dvbdev.h"
 #include "dvb_net.h"
@@ -50,3 +53,5 @@ struct dvb_bt8xx_card {
 				
 	struct dvb_frontend* fe;
 };
+
+#endif /* DVB_BT8XX_H */
