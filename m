Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUDNUzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUDNUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:55:10 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:58244 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261725AbUDNUzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:55:06 -0400
Date: Wed, 14 Apr 2004 04:55:52 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045552.GB12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
--- a/drivers/pnp/pnpbios/rsparser.c	Wed Apr 14 04:42:06 2004
+++ b/drivers/pnp/pnpbios/rsparser.c	Wed Apr 14 04:42:06 2004
@@ -505,6 +505,11 @@

 		switch (tag) {

+		case LARGE_TAG_ANSISTR:
+			strncpy(dev->name, p + 3, len >= PNP_NAME_LEN ? PNP_NAME_LEN - 2 : len);
+			dev->name[len >= PNP_NAME_LEN ? PNP_NAME_LEN - 1 : len] = '\0';
+			break;
+
 		case SMALL_TAG_COMPATDEVID: /* compatible ID */
 			if (len != 4)
 				goto len_err;
