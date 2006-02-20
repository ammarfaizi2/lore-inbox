Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWBTWh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWBTWh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWBTWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:37:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030273AbWBTWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:30 -0500
Date: Mon, 20 Feb 2006 23:36:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/acpi/utilities/utmisc.c: remove 3 unused global functions
Message-ID: <20060220223628.GP4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following four unused global functions from 
drivers/acpi/utilities/utmisc.c:
- acpi_ut_strupr()
- acpi_ut_report_warning()
- acpi_ut_report_info()

Is this patch OK or is future usage planned or are they still used on 
other operating systems?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/utilities/utmisc.c |   44 --------------------------------
 include/acpi/acutils.h          |    6 ----
 2 files changed, 50 deletions(-)

--- linux-2.6.16-rc1-mm5-full/include/acpi/acutils.h.old	2006-02-03 19:28:37.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/include/acpi/acutils.h	2006-02-03 19:29:42.000000000 +0100
@@ -279,10 +279,6 @@
 
 void acpi_ut_report_error(char *module_name, u32 line_number);
 
-void acpi_ut_report_info(char *module_name, u32 line_number);
-
-void acpi_ut_report_warning(char *module_name, u32 line_number);
-
 /* Error and message reporting interfaces */
 
 void ACPI_INTERNAL_VAR_XFACE
@@ -454,8 +450,6 @@
 			  void *target_object,
 			  acpi_pkg_callback walk_callback, void *context);
 
-void acpi_ut_strupr(char *src_string);
-
 void acpi_ut_print_string(char *string, u8 max_length);
 
 u8 acpi_ut_valid_acpi_name(u32 name);
--- linux-2.6.16-rc1-mm5-full/drivers/acpi/utilities/utmisc.c.old	2006-02-03 19:28:53.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/acpi/utilities/utmisc.c	2006-02-03 19:30:04.000000000 +0100
@@ -217,39 +217,6 @@
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_strupr (strupr)
- *
- * PARAMETERS:  src_string      - The source string to convert
- *
- * RETURN:      None
- *
- * DESCRIPTION: Convert string to uppercase
- *
- * NOTE: This is not a POSIX function, so it appears here, not in utclib.c
- *
- ******************************************************************************/
-
-void acpi_ut_strupr(char *src_string)
-{
-	char *string;
-
-	ACPI_FUNCTION_ENTRY();
-
-	if (!src_string) {
-		return;
-	}
-
-	/* Walk entire string, uppercasing the letters */
-
-	for (string = src_string; *string; string++) {
-		*string = (char)ACPI_TOUPPER(*string);
-	}
-
-	return;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ut_print_string
  *
  * PARAMETERS:  String          - Null terminated ASCII string
@@ -922,14 +864,3 @@
 	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
 }
 
-void acpi_ut_report_warning(char *module_name, u32 line_number)
-{
-
-	acpi_os_printf("ACPI Warning (%s-%04d): ", module_name, line_number);
-}
-
-void acpi_ut_report_info(char *module_name, u32 line_number)
-{
-
-	acpi_os_printf("ACPI (%s-%04d): ", module_name, line_number);
-}

