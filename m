Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVG2CRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVG2CRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 22:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVG2CRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 22:17:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbVG2CRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 22:17:40 -0400
Date: Thu, 28 Jul 2005 19:16:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Florian Engelhardt <dot@dot-matrix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3 acpi compile problems
Message-Id: <20050728191634.7ef8dd9e.akpm@osdl.org>
In-Reply-To: <1122563381.42e8f5359af84@www.domainfactory-webmail.de>
References: <1122563381.42e8f5359af84@www.domainfactory-webmail.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt <dot@dot-matrix.de> wrote:
>
> i get this warnings when compiling:
> 
>    CC      drivers/acpi/utilities/utalloc.o
>  drivers/acpi/utilities/utalloc.c: In function `acpi_ut_create_caches':
>  drivers/acpi/utilities/utalloc.c:107: warning: passing arg 3 of
>  `acpi_ut_create_list' from incompatible pointer type

Something like this?


diff -puN drivers/acpi/utilities/utdebug.c~acpi-trace-warning-fixes drivers/acpi/utilities/utdebug.c
--- devel/drivers/acpi/utilities/utdebug.c~acpi-trace-warning-fixes	2005-07-28 19:14:46.000000000 -0700
+++ devel-akpm/drivers/acpi/utilities/utdebug.c	2005-07-28 19:14:46.000000000 -0700
@@ -133,7 +133,7 @@ void  ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print (
 	u32                             requested_debug_level,
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *format,
@@ -208,7 +208,7 @@ void  ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print_raw (
 	u32                             requested_debug_level,
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *format,
@@ -247,7 +247,7 @@ EXPORT_SYMBOL(acpi_ut_debug_print_raw);
 void
 acpi_ut_trace (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id)
 {
@@ -282,7 +282,7 @@ EXPORT_SYMBOL(acpi_ut_trace);
 void
 acpi_ut_trace_ptr (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	void                            *pointer)
@@ -316,7 +316,7 @@ acpi_ut_trace_ptr (
 void
 acpi_ut_trace_str (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *string)
@@ -351,7 +351,7 @@ acpi_ut_trace_str (
 void
 acpi_ut_trace_u32 (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	u32                             integer)
@@ -385,7 +385,7 @@ acpi_ut_trace_u32 (
 void
 acpi_ut_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id)
 {
@@ -419,7 +419,7 @@ EXPORT_SYMBOL(acpi_ut_exit);
 void
 acpi_ut_status_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	acpi_status                     status)
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(acpi_ut_status_exit);
 void
 acpi_ut_value_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	acpi_integer                    value)
@@ -499,7 +499,7 @@ EXPORT_SYMBOL(acpi_ut_value_exit);
 void
 acpi_ut_ptr_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	u8                              *ptr)
diff -puN include/acpi/acmacros.h~acpi-trace-warning-fixes include/acpi/acmacros.h
diff -puN include/acpi/acutils.h~acpi-trace-warning-fixes include/acpi/acutils.h
--- devel/include/acpi/acutils.h~acpi-trace-warning-fixes	2005-07-28 19:14:46.000000000 -0700
+++ devel-akpm/include/acpi/acutils.h	2005-07-28 19:14:46.000000000 -0700
@@ -302,14 +302,14 @@ acpi_ut_track_stack_ptr (
 void
 acpi_ut_trace (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id);
 
 void
 acpi_ut_trace_ptr (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	void                            *pointer);
@@ -317,7 +317,7 @@ acpi_ut_trace_ptr (
 void
 acpi_ut_trace_u32 (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	u32                             integer);
@@ -325,7 +325,7 @@ acpi_ut_trace_u32 (
 void
 acpi_ut_trace_str (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *string);
@@ -333,14 +333,14 @@ acpi_ut_trace_str (
 void
 acpi_ut_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id);
 
 void
 acpi_ut_status_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	acpi_status                     status);
@@ -348,7 +348,7 @@ acpi_ut_status_exit (
 void
 acpi_ut_value_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	acpi_integer                    value);
@@ -356,7 +356,7 @@ acpi_ut_value_exit (
 void
 acpi_ut_ptr_exit (
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	u8                              *ptr);
@@ -390,7 +390,7 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print (
 	u32                             requested_debug_level,
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *format,
@@ -400,7 +400,7 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print_raw (
 	u32                             requested_debug_level,
 	u32                             line_number,
-	char                            *function_name,
+	const char                      *function_name,
 	char                            *module_name,
 	u32                             component_id,
 	char                            *format,
_

