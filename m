Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTEVPi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTEVPi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:38:26 -0400
Received: from holomorphy.com ([66.224.33.161]:25740 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262018AbTEVPiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:38:24 -0400
Date: Thu, 22 May 2003 08:51:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: ACPI constant overflow fixes
Message-ID: <20030522155102.GQ2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -prauN mm8-2.5.69-1/include/acpi/actypes.h mm8-2.5.69-2/include/acpi/actypes.h
--- mm8-2.5.69-1/include/acpi/actypes.h	2003-05-04 16:53:32.000000000 -0700
+++ mm8-2.5.69-2/include/acpi/actypes.h	2003-05-22 08:14:24.000000000 -0700
@@ -51,10 +51,10 @@
 /*
  * Data type ranges
  */
-#define ACPI_UINT8_MAX                  (UINT8)  0xFF
-#define ACPI_UINT16_MAX                 (UINT16) 0xFFFF
-#define ACPI_UINT32_MAX                 (UINT32) 0xFFFFFFFF
-#define ACPI_UINT64_MAX                 (UINT64) 0xFFFFFFFFFFFFFFFF
+#define ACPI_UINT8_MAX                  (~((UINT8)  0))
+#define ACPI_UINT16_MAX                 (~((UINT16) 0))
+#define ACPI_UINT32_MAX                 (~((UINT32) 0))
+#define ACPI_UINT64_MAX                 (~((UINT64) 0))
 #define ACPI_ASCII_MAX                  0x7F
 
 
@@ -313,7 +313,11 @@ typedef u32                             
 typedef u64                                     acpi_integer;
 #define ACPI_INTEGER_MAX                ACPI_UINT64_MAX
 #define ACPI_INTEGER_BIT_SIZE           64
-#define ACPI_MAX_BCD_VALUE              9999999999999999
+#if ACPI_MACHINE_WIDTH == 64
+#define ACPI_MAX_BCD_VALUE              9999999999999999UL
+#else
+#define ACPI_MAX_BCD_VALUE              9999999999999999ULL
+#endif
 #define ACPI_MAX_BCD_DIGITS             16
 #define ACPI_MAX_DECIMAL_DIGITS         19
 
