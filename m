Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUFNUas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUFNUas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUFNUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:30:48 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:56472 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S263879AbUFNUaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:30:46 -0400
X-Ironport-AV: i="3.81R,115,1083560400"; 
   d="scan'208"; a="46522173:sNHT21604402"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH] proper bios handoff in ehci-hcd
Date: Mon, 14 Jun 2004 15:30:44 -0500
Message-ID: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] proper bios handoff in ehci-hcd
Thread-Index: AcRSTneKNA+TPV1KSjmNobra8uQYGw==
From: <Gary_Lerhaupt@Dell.com>
To: <linux-usb-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>, <Stuart_Hayes@Dell.com>
X-OriginalArrivalTime: 14 Jun 2004 20:30:46.0121 (UTC) FILETIME=[78D29590:01C4524E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Hayes here at Dell has identified this or/and mix-up in the ehci-hcd driver.  Because of this, ehci-hcd is not properly released by BIOSes supporting full 2.0 and port behavior can then become erratic.

This is broken in latest 2.4 and 2.6.

Gary Lerhaupt
Dell Linux Development
http://linux.dell.com

--- linux/drivers/usb/host/ehci-hcd.c.orig	2004-06-05 03:12:18.000000000 -0500
+++ linux/drivers/usb/host/ehci-hcd.c	2004-06-05 01:18:51.000000000 -0500
@@ -290,7 +290,7 @@ static int bios_handoff (struct ehci_hcd
 		int msec = 500;
 
 		/* request handoff to OS */
-		cap &= 1 << 24;
+		cap |= 1 << 24;
 		pci_write_config_dword (ehci->hcd.pdev, where, cap);
 
 		/* and wait a while for it to happen */
