Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbTHGWYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTHGWYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:24:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:12754 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271036AbTHGWYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:24:03 -0400
Date: Thu, 7 Aug 2003 15:22:41 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200308072222.h77MMf6D024633@snoqualmie.dp.intel.com>
To: bjorn.helgaas@hp.com, davidm@napali.hpl.hp.com
Subject: [patch] modify data types in efi.h
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, Bjorn,

Here's a small patch against 2.6.0-test2 to change several data types from u64 to unsigned long in efi.h.  These changes enable the use of the same data structures and function prototypes for ia32 EFI kernels. Comments? 

Please apply...

thanks,
matt


diff -urN linux-2.6.0-test2-ia64-vanilla/arch/ia64/kernel/efi.c linux-2.6.0-test2-ia64-efi/arch/ia64/kernel/efi.c
--- linux-2.6.0-test2-ia64-vanilla/arch/ia64/kernel/efi.c	2003-07-27 09:56:32.000000000 -0700
+++ linux-2.6.0-test2-ia64-efi/arch/ia64/kernel/efi.c	2003-08-07 13:04:27.000000000 -0700
@@ -140,7 +140,7 @@
 
 #define STUB_SET_VARIABLE(prefix, adjust_arg)						\
 static efi_status_t									\
-prefix##_set_variable (efi_char16_t *name, efi_guid_t *vendor, u32 attr,		\
+prefix##_set_variable (efi_char16_t *name, efi_guid_t *vendor, unsigned long attr,	\
 		       unsigned long data_size, void *data)				\
 {											\
 	struct ia64_fpreg fr[6];							\
@@ -156,7 +156,7 @@
 
 #define STUB_GET_NEXT_HIGH_MONO_COUNT(prefix, adjust_arg)					\
 static efi_status_t										\
-prefix##_get_next_high_mono_count (u64 *count)							\
+prefix##_get_next_high_mono_count (u32 *count)							\
 {												\
 	struct ia64_fpreg fr[6];								\
 	efi_status_t ret;									\
diff -urN linux-2.6.0-test2-ia64-vanilla/include/linux/efi.h linux-2.6.0-test2-ia64-efi/include/linux/efi.h
--- linux-2.6.0-test2-ia64-vanilla/include/linux/efi.h	2003-07-27 10:09:40.000000000 -0700
+++ linux-2.6.0-test2-ia64-efi/include/linux/efi.h	2003-08-07 13:01:48.000000000 -0700
@@ -21,12 +21,12 @@
 #include <asm/system.h>
 
 #define EFI_SUCCESS		0
-#define EFI_LOAD_ERROR          ( 1 | (1UL << 63))
-#define EFI_INVALID_PARAMETER	( 2 | (1UL << 63))
-#define EFI_UNSUPPORTED		( 3 | (1UL << 63))
-#define EFI_BAD_BUFFER_SIZE     ( 4 | (1UL << 63))
-#define EFI_BUFFER_TOO_SMALL	( 5 | (1UL << 63))
-#define EFI_NOT_FOUND		(14 | (1UL << 63))
+#define EFI_LOAD_ERROR          ( 1 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_UNSUPPORTED		( 3 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_BAD_BUFFER_SIZE     ( 4 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_BUFFER_TOO_SMALL	( 5 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
 
 typedef unsigned long efi_status_t;
 typedef u8 efi_bool_t;
@@ -98,7 +98,7 @@
 	u64 attribute;
 } efi_memory_desc_t;
 
-typedef int efi_freemem_callback_t (u64 start, u64 end, void *arg);
+typedef int efi_freemem_callback_t (unsigned long start, unsigned long end, void *arg);
 
 /*
  * Types and defines for Time Services
@@ -141,17 +141,17 @@
 
 typedef struct {
 	efi_table_hdr_t hdr;
-	u64 get_time;
-	u64 set_time;
-	u64 get_wakeup_time;
-	u64 set_wakeup_time;
-	u64 set_virtual_address_map;
-	u64 convert_pointer;
-	u64 get_variable;
-	u64 get_next_variable;
-	u64 set_variable;
-	u64 get_next_high_mono_count;
-	u64 reset_system;
+	unsigned long get_time;
+	unsigned long set_time;
+	unsigned long get_wakeup_time;
+	unsigned long set_wakeup_time;
+	unsigned long set_virtual_address_map;
+	unsigned long convert_pointer;
+	unsigned long get_variable;
+	unsigned long get_next_variable;
+	unsigned long set_variable;
+	unsigned long get_next_high_mono_count;
+	unsigned long reset_system;
 } efi_runtime_services_t;
 
 typedef efi_status_t efi_get_time_t (efi_time_t *tm, efi_time_cap_t *tc);
@@ -163,9 +163,10 @@
 					 unsigned long *data_size, void *data);
 typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
 					      efi_guid_t *vendor);
-typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, u32 attr,
-					 unsigned long data_size, void *data);
-typedef efi_status_t efi_get_next_high_mono_count_t (u64 *count);
+typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, 
+					 unsigned long attr, unsigned long data_size, 
+					 void *data);
+typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
 typedef void efi_reset_system_t (int reset_type, efi_status_t status,
 				 unsigned long data_size, efi_char16_t *data);
 
@@ -195,7 +196,7 @@
 
 typedef struct {
 	efi_guid_t guid;
-	u64 table;
+	unsigned long table;
 } efi_config_table_t;
 
 #define EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249
@@ -203,18 +204,18 @@
 
 typedef struct {
 	efi_table_hdr_t hdr;
-	u64 fw_vendor;		/* physical addr of CHAR16 vendor string */
+	unsigned long fw_vendor;	/* physical addr of CHAR16 vendor string */
 	u32 fw_revision;
-	u64 con_in_handle;
-	u64 con_in;
-	u64 con_out_handle;
-	u64 con_out;
-	u64 stderr_handle;
-	u64 stderr;
-	u64 runtime;
-	u64 boottime;
-	u64 nr_tables;
-	u64 tables;
+	unsigned long con_in_handle;
+	unsigned long con_in;
+	unsigned long con_out_handle;
+	unsigned long con_out;
+	unsigned long stderr_handle;
+	unsigned long stderr;
+	efi_runtime_services_t *runtime;
+	unsigned long boottime;
+	unsigned long nr_tables;
+	unsigned long tables;
 } efi_system_table_t;
 
 /*

