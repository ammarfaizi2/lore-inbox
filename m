Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWBNDTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWBNDTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBNDTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:19:34 -0500
Received: from fmr19.intel.com ([134.134.136.18]:13224 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750783AbWBNDTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:19:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Compaq X1050 multiple suspend problems (ACPI, PS2)
Date: Tue, 14 Feb 2006 11:19:23 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AEE1EB2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq X1050 multiple suspend problems (ACPI, PS2)
thread-index: AcYxEtONs0j3AzcVTdWT/uky6cwV7wAAZ/XA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-acpi@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Feb 2006 03:19:24.0091 (UTC) FILETIME=[743DA8B0:01C63115]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>No luck with 2.6.16-rc3. Slightly different messages, but still ACPI 
>complaints about EC, battery status polling fails and the 
>keyboard loses 
>characters after resume. Full dmesg attached.
>
Do you have such issues before resume?
What about ec_intr=0?

I found "ACPI: read EC, IB not empty" in the dmesg.
Could you try this against 2.6.16-rc3

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 79b09d7..c4c9ded 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -51,7 +51,7 @@ ACPI_MODULE_NAME("acpi_ec")
 #define ACPI_EC_FLAG_SCI       0x20    /* EC-SCI occurred */
 #define ACPI_EC_EVENT_OBF      0x01    /* Output buffer full */
 #define ACPI_EC_EVENT_IBE      0x02    /* Input buffer empty */
-#define ACPI_EC_DELAY          50      /* Wait 50ms max. during EC ops
*/
+#define ACPI_EC_DELAY          100     /* Wait 50ms max. during EC ops
*/
 #define ACPI_EC_UDELAY_GLK     1000    /* Wait 1ms max. to get global
lock */
 #define ACPI_EC_UDELAY         100     /* Poll @ 100us increments */
 #define ACPI_EC_UDELAY_COUNT   1000    /* Wait 10ms max. during EC ops
*/
