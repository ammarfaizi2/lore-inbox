Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVEHThy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVEHThy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVEHTOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:14:40 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:58006 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262838AbVEHTJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:39 -0400
Message-Id: <20050508184346.392468000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:39 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-vidstd.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 10/37] av7110: fix NTSC/PAL switching
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix NTSC -> PAL switching (std->id is a bitmap!) (Oliver Endriss)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110_v4l.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 16:14:09.000000000 +0200
@@ -726,11 +726,11 @@ static int std_callback(struct saa7146_d
 {
 	struct av7110 *av7110 = (struct av7110*) dev->ext_priv;
 
-	if (std->id == V4L2_STD_PAL) {
+	if (std->id & V4L2_STD_PAL) {
 		av7110->vidmode = VIDEO_MODE_PAL;
 		av7110_set_vidmode(av7110, av7110->vidmode);
 	}
-	else if (std->id == V4L2_STD_NTSC) {
+	else if (std->id & V4L2_STD_NTSC) {
 		av7110->vidmode = VIDEO_MODE_NTSC;
 		av7110_set_vidmode(av7110, av7110->vidmode);
 	}

--

