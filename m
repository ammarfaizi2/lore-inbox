Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135905AbRD3VCH>; Mon, 30 Apr 2001 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbRD3VB4>; Mon, 30 Apr 2001 17:01:56 -0400
Received: from nemesis.ncsl.nist.gov ([129.6.57.210]:6528 "EHLO
	nemesis.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S135902AbRD3VBs>; Mon, 30 Apr 2001 17:01:48 -0400
Date: Mon, 30 Apr 2001 17:01:39 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-acenic@SunSITE.auc.dk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: [patch] Acenic tigon 1 support fix
Message-ID: <20010430170138.A1085@nemesis.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-acenic@SunSITE.auc.dk, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A typo prevents the tigon 1 firmware to be included when tigon 1
support is active.  Null pointer dereference in
ace_load_firmware->ace_copy as a result.

Patch trivial and even tested (aka, the module loads without oopsing
with a tigon 1 inside).

  OG.

--- linux/drivers/net/acenic_firmware.h	Tue Mar  6 22:28:33 2001
+++ linux-2.4.4/drivers/net/acenic_firmware.h	Mon Apr 30 16:51:25 2001
@@ -17,7 +17,7 @@
 #define tigonFwSbssLen 0x38
 #define tigonFwBssAddr 0x00015dd0
 #define tigonFwBssLen 0x2080
-#ifndef CONFIG_ACENIC_OMIT_TIGON_I
+#ifdef CONFIG_ACENIC_OMIT_TIGON_I
 #define tigonFwText 0
 #define tigonFwData 0
 #define tigonFwRodata 0
