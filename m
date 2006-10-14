Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWJNMHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWJNMHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWJNMHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60876 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932172AbWJNMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:00 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 17/18] V4L/DVB (4748): Fixed oops for Nova-T USB2
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS71938900017@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Patrick Boettcher <pb@linuxtv.org>

When using the remote control with the Nova-T USB there was an Oops because of
the recent DVB-USB-Adapter change.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/dibusb.h      |    2 ++
 drivers/media/dvb/dvb-usb/nova-t-usb2.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/dibusb.h b/drivers/media/dvb/dvb-usb/dibusb.h
index 5153fb9..b607810 100644
--- a/drivers/media/dvb/dvb-usb/dibusb.h
+++ b/drivers/media/dvb/dvb-usb/dibusb.h
@@ -99,7 +99,9 @@ #define DIBUSB_IOCTL_CMD_DISABLE_STREAM	
 struct dibusb_state {
 	struct dib_fe_xfer_ops ops;
 	int mt2060_present;
+};
 
+struct dibusb_device_state {
 	/* for RC5 remote control */
 	int old_toggle;
 	int last_repeat_count;
diff --git a/drivers/media/dvb/dvb-usb/nova-t-usb2.c b/drivers/media/dvb/dvb-usb/nova-t-usb2.c
index a9219bf..a58874c 100644
--- a/drivers/media/dvb/dvb-usb/nova-t-usb2.c
+++ b/drivers/media/dvb/dvb-usb/nova-t-usb2.c
@@ -75,7 +75,7 @@ static int nova_t_rc_query(struct dvb_us
 	u8 key[5],cmd[2] = { DIBUSB_REQ_POLL_REMOTE, 0x35 }, data,toggle,custom;
 	u16 raw;
 	int i;
-	struct dibusb_state *st = d->priv;
+	struct dibusb_device_state *st = d->priv;
 
 	dvb_usb_generic_rw(d,cmd,2,key,5,0);
 
@@ -184,6 +184,7 @@ static struct dvb_usb_device_properties 
 			.size_of_priv     = sizeof(struct dibusb_state),
 		}
 	},
+	.size_of_priv     = sizeof(struct dibusb_device_state),
 
 	.power_ctrl       = dibusb2_0_power_ctrl,
 	.read_mac_address = nova_t_read_mac_address,

