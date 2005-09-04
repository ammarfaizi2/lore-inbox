Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVIDXes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVIDXes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIDXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:04 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:31105 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932113AbVIDXaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:12 -0400
Message-Id: <20050904232322.846755000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:17 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-cx24110-diseqc-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 18/54] frontend: cx24110: DiSEqC fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DiSEqC switching (one bug fix suggested by Peter Hettkamp, and one
experimentally determined msleep(30) suggested by Adam Szalkowski).

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/cx24110.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:27:47.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:28:09.000000000 +0200
@@ -398,7 +398,7 @@ static int cx24110_diseqc_send_burst(str
 		return -EINVAL;
 
 	rv = cx24110_readreg(state, 0x77);
-	cx24110_writereg(state, 0x77, rv|0x04);
+	cx24110_writereg(state, 0x77, rv | 0x04);
 
 	rv = cx24110_readreg(state, 0x76);
 	cx24110_writereg(state, 0x76, ((rv & 0x90) | 0x40 | bit));
@@ -418,7 +418,8 @@ static int cx24110_send_diseqc_msg(struc
 		cx24110_writereg(state, 0x79 + i, cmd->msg[i]);
 
 	rv = cx24110_readreg(state, 0x77);
-	cx24110_writereg(state, 0x77, rv|0x04);
+	cx24110_writereg(state, 0x77, rv & ~0x04);
+	msleep(30); /* reportedly fixes switching problems */
 
 	rv = cx24110_readreg(state, 0x76);
 

--

