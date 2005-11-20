Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVKTQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVKTQNd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVKTQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 11:13:33 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:51819 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751266AbVKTQNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 11:13:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Geithe <warpy@gmx.de>
Subject: Re: Linux 2.6.15-rc2
Date: Sun, 20 Nov 2005 11:13:29 -0500
User-Agent: KMail/1.8.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511201420.55062.warpy@gmx.de>
In-Reply-To: <200511201420.55062.warpy@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201113.29911.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 08:20, Michael Geithe wrote:
> Hi,
> i get this after plugged in dvb-t/Cinergy T2 with Kernel 2.6.15-git*/rc*.
>

Hm, is there one driver in drivers/media that I left working? Please
try the patch below.

-- 
Dmitry

Subjtect: Fix an OOPS is CinergyT2

Fix an OOPS is CinergyT2 driver when registering IR remote

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- work.orig/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ work/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -772,7 +772,7 @@ static int cinergyt2_register_rc(struct 
 	input_dev->name = DRIVER_NAME " remote control";
 	input_dev->phys = cinergyt2->phys;
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-	for (i = 0; ARRAY_SIZE(rc_keys); i += 3)
+	for (i = 0; i < ARRAY_SIZE(rc_keys); i += 3)
 		set_bit(rc_keys[i + 2], input_dev->keybit);
 	input_dev->keycodesize = 0;
 	input_dev->keycodemax = 0;
