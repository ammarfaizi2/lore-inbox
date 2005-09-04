Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVIDXot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVIDXot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVIDXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:48 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:24705 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932104AbVIDX34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:56 -0400
Message-Id: <20050904232317.399920000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:03 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-add-get_caps-set_source-glue.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 04/54] core: glue code for DMX_GET_CAPS and DMX_SET_SOURCE
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Glue code for DMX_GET_CAPS and DMX_SET_SOURCE ioctls.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/demux.h  |    5 +++++
 drivers/media/dvb/dvb-core/dmxdev.c |   16 ++++++++++++++++
 2 files changed, 21 insertions(+)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:52.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/time.h>
+#include <linux/dvb/dmx.h>
 
 /*--------------------------------------------------------------------------*/
 /* Common definitions */
@@ -282,6 +283,10 @@ struct dmx_demux {
 
         int (*get_pes_pids) (struct dmx_demux* demux, u16 *pids);
 
+	int (*get_caps) (struct dmx_demux* demux, struct dmx_caps *caps);
+
+	int (*set_source) (struct dmx_demux* demux, const dmx_source_t *src);
+
         int (*get_stc) (struct dmx_demux* demux, unsigned int num,
 			u64 *stc, unsigned int *base);
 };
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dmxdev.c	2005-09-04 22:27:52.000000000 +0200
@@ -929,6 +929,22 @@ static int dvb_demux_do_ioctl(struct ino
 		dmxdev->demux->get_pes_pids(dmxdev->demux, (u16 *)parg);
 		break;
 
+	case DMX_GET_CAPS:
+		if (!dmxdev->demux->get_caps) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = dmxdev->demux->get_caps(dmxdev->demux, parg);
+		break;
+
+	case DMX_SET_SOURCE:
+		if (!dmxdev->demux->set_source) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = dmxdev->demux->set_source(dmxdev->demux, parg);
+		break;
+
 	case DMX_GET_STC:
 		if (!dmxdev->demux->get_stc) {
 		        ret=-EINVAL;

--

