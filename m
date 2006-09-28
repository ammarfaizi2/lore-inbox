Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWI1QDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWI1QDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWI1QCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:41 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4022 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751925AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 21 of 28] IB/ipath - change HT CRC message to indicate how to
	resolve problem
X-Mercurial-Node: a78c7b475df6e62937fa2e5db6ae7c33fdf334df
Message-Id: <a78c7b475df6e62937fa.1159459217@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:17 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system must be powercycled to clear a HT CRC error; reloading the
driver is not enough.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r e3158e62d6bf -r a78c7b475df6 drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:13 2006 -0700
@@ -338,7 +338,7 @@ static void hwerr_crcbits(struct ipath_d
 	if (crcbits) {
 		u16 ctrl0, ctrl1;
 		snprintf(bitsmsg, sizeof bitsmsg,
-			 "[HT%s lane %s CRC (%llx); ignore till reload]",
+			 "[HT%s lane %s CRC (%llx); powercycle to completely clear]",
 			 !(crcbits & _IPATH_HTLINK1_CRCBITS) ?
 			 "0 (A)" : (!(crcbits & _IPATH_HTLINK0_CRCBITS)
 				    ? "1 (B)" : "0+1 (A+B)"),
