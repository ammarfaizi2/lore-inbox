Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVHIEpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVHIEpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVHIEpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:45:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932484AbVHIEpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:45:11 -0400
Date: Tue, 9 Aug 2005 00:44:41 -0400
From: Dave Jones <davej@redhat.com>
To: linux-parport@lists.infradead.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Incorrect permissions on parport sysctls.
Message-ID: <20050809044440.GA7725@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-parport@lists.infradead.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a bunch of 'probe' sysctl's in parport, which are
readable. (world readable even). Make them write-only.
Without this, sysctl -a will try to read these files.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.11/drivers/parport/procfs.c~	2005-04-25 12:17:30.000000000 -0400
+++ linux-2.6.11/drivers/parport/procfs.c	2005-04-25 12:20:35.000000000 -0400
@@ -286,19 +286,19 @@ static const struct parport_sysctl_table
 		PARPORT_DEVICES_ROOT_DIR,
 #ifdef CONFIG_PARPORT_1284
 		{ DEV_PARPORT_AUTOPROBE, "autoprobe",
-		  NULL, 0, 0444, NULL,
+		  NULL, 0, 0200, NULL,
 		  &do_autoprobe },
 		{ DEV_PARPORT_AUTOPROBE + 1, "autoprobe0",
-		 NULL, 0, 0444, NULL,
+		 NULL, 0, 0200, NULL,
 		 &do_autoprobe },
 		{ DEV_PARPORT_AUTOPROBE + 2, "autoprobe1",
-		  NULL, 0, 0444, NULL,
+		  NULL, 0, 0200, NULL,
 		  &do_autoprobe },
 		{ DEV_PARPORT_AUTOPROBE + 3, "autoprobe2",
-		  NULL, 0, 0444, NULL,
+		  NULL, 0, 0200, NULL,
 		  &do_autoprobe },
 		{ DEV_PARPORT_AUTOPROBE + 4, "autoprobe3",
-		  NULL, 0, 0444, NULL,
+		  NULL, 0, 0200, NULL,
 		  &do_autoprobe },
 #endif /* IEEE 1284 support */
 		{0}

