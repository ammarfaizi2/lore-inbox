Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVKAIRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVKAIRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKAIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:33 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:45914 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964993AbVKAIQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:18 -0500
Message-ID: <43672428.50306@m1k.net>
Date: Tue, 01 Nov 2005 03:15:36 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 28/37] dvb: stv0299: reduce i2c xfer and set register 0x12
 from inittab
Content-Type: multipart/mixed;
 boundary="------------000702000304020005010605"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000702000304020005010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------000702000304020005010605
Content-Type: text/x-patch;
 name="2405.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2405.patch"

From: Oliver Endriss <o.endriss@gmx.de>

stv0299_set_frontend(): reduced number of i2c transfers, set register 0x12 from inittab

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/frontends/stv0299.c  |    2 --
 drivers/media/dvb/ttpci/av7110.c       |    4 ++--
 drivers/media/dvb/ttpci/budget-av.c    |    2 +-
 drivers/media/dvb/ttpci/budget-ci.c    |    2 +-
 drivers/media/dvb/ttpci/budget-patch.c |    2 +-
 drivers/media/dvb/ttpci/budget.c       |    4 ++--
 6 files changed, 7 insertions(+), 9 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/stv0299.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/stv0299.c
@@ -561,8 +561,6 @@
 	stv0299_set_symbolrate (fe, p->u.qpsk.symbol_rate);
 	stv0299_writeregI(state, 0x22, 0x00);
 	stv0299_writeregI(state, 0x23, 0x00);
-	stv0299_readreg (state, 0x23);
-	stv0299_writeregI(state, 0x12, 0xb9);
 
 	state->tuner_frequency = p->frequency;
 	state->fec_inner = p->u.qpsk.fec_inner;
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/av7110.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/av7110.c
@@ -1566,7 +1566,7 @@
 	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,   // AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,   // lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
@@ -1668,7 +1668,7 @@
 	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,   // AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,   // lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-av.c
@@ -499,7 +499,7 @@
 	0x0e, 0x23,		/* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,		// AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,		// Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,		// lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-ci.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-ci.c
@@ -490,7 +490,7 @@
 	0x0e, 0x23,		/* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,		// AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,		// Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,		// lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-patch.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-patch.c
@@ -305,7 +305,7 @@
 	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,   // AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,   // lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget.c
@@ -286,7 +286,7 @@
 	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,   // AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,   // lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,
@@ -383,7 +383,7 @@
 	0x0e, 0x23,  /* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,  // AGC2 0x3d
 	0x11, 0x84,
-	0x12, 0xb5,  // Lock detect: -64 Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,  // lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,


--------------000702000304020005010605--
