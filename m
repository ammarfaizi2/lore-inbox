Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVGBBzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVGBBzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGBBzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:55:32 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:11244 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261681AbVGBBzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:16 -0400
Message-Id: <20050702015618.434567000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:08 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-timeout-fix.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 2/8] usb: dont use HZ for timeouts
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Don't use HZ for usb-transfer-timeouts.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-urb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dvb-usb-urb.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dvb-usb-urb.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dvb-usb-urb.c	2005-07-02 03:22:26.000000000 +0200
@@ -29,7 +29,7 @@ int dvb_usb_generic_rw(struct dvb_usb_de
 
 	ret = usb_bulk_msg(d->udev,usb_sndbulkpipe(d->udev,
 			d->props.generic_bulk_ctrl_endpoint), wbuf,wlen,&actlen,
-			2*HZ);
+			2000);
 
 	if (ret)
 		err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
@@ -43,7 +43,7 @@ int dvb_usb_generic_rw(struct dvb_usb_de
 
 		ret = usb_bulk_msg(d->udev,usb_rcvbulkpipe(d->udev,
 				d->props.generic_bulk_ctrl_endpoint),rbuf,rlen,&actlen,
-				2*HZ);
+				2000);
 
 		if (ret)
 			err("recv bulk message failed: %d",ret);

--

