Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946543AbWKAFof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946543AbWKAFof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946537AbWKAFo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:44:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38620 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946523AbWKAFoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:44:25 -0500
Message-Id: <20061101054407.796797000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:28 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, a.zummo@towertech.it, flarramendi@gmail.com,
       raph@raphnet.net, azummo@towertech.it
Subject: [PATCH 48/61] rtc-max6902: month conversion fix
Content-Disposition: inline; filename=rtc-max6902-month-conversion-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Francisco Larramendi <flarramendi@gmail.com>

Fix October-only BCD-to-binary conversion bug:

	0x08 -> 7
	0x09 -> 8
	0x10 -> 15 (!)
	0x11 -> 19

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=7361

Cc: Raphael Assenat <raph@raphnet.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/rtc/rtc-max6902.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/rtc/rtc-max6902.c
+++ linux-2.6.18.1/drivers/rtc/rtc-max6902.c
@@ -137,7 +137,7 @@ static int max6902_get_datetime(struct d
 	dt->tm_min	= BCD2BIN(chip->buf[2]);
 	dt->tm_hour	= BCD2BIN(chip->buf[3]);
 	dt->tm_mday	= BCD2BIN(chip->buf[4]);
-	dt->tm_mon	= BCD2BIN(chip->buf[5] - 1);
+	dt->tm_mon	= BCD2BIN(chip->buf[5]) - 1;
 	dt->tm_wday	= BCD2BIN(chip->buf[6]);
 	dt->tm_year = BCD2BIN(chip->buf[7]);
 

--
