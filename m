Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWINGpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWINGpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWINGpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:45:15 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:52909 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751372AbWINGpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:45:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Bh7fiX692FmYUdXXCOdmSSd6TsjBfmcKxAvfpOy7+S9we+7V6sHUqNr/1DtibVoogn12NMBf2erU+i6eR1BRWaXFO8VJtsxHvT2P9gqkNBwCNmbWn7C8aKOWtwksYsGcF5a+dqdrKbb1Ml/YgpfPz2FVUDzHmkDpl9mv89+4gR4=  ;
From: David Brownell <david-b@pacbell.net>
To: "Brown, Len" <len.brown@intel.com>
Subject: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)
Date: Wed, 13 Sep 2006 21:00:33 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609132100.33925.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes various ACPI compiler warnings go away (x86_64),
making builds be warning-free again.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/acpi/executer/exmutex.c
===================================================================
--- g26.orig/drivers/acpi/executer/exmutex.c	2006-07-14 10:03:04.000000000 -0700
+++ g26/drivers/acpi/executer/exmutex.c	2006-09-13 13:31:10.000000000 -0700
@@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
+			    walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
Index: g26/drivers/acpi/tables/tbget.c
===================================================================
--- g26.orig/drivers/acpi/tables/tbget.c	2006-07-14 10:03:04.000000000 -0700
+++ g26/drivers/acpi/tables/tbget.c	2006-09-13 13:37:27.000000000 -0700
@@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
+			    "Table length (%X) is smaller than minimum (%zX)",
 			    header->length, sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
Index: g26/drivers/acpi/utilities/utmutex.c
===================================================================
--- g26.orig/drivers/acpi/utilities/utmutex.c	2006-07-14 10:03:04.000000000 -0700
+++ g26/drivers/acpi/utilities/utmutex.c	2006-09-13 13:39:24.000000000 -0700
@@ -258,8 +258,8 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				(u32) this_thread_id, mutex_id));
+				"Thread %p could not acquire Mutex [%X]",
+				this_thread_id, mutex_id));
 	}
 
 	return (status);
Index: g26/drivers/acpi/tables/tbrsdt.c
===================================================================
--- g26.orig/drivers/acpi/tables/tbrsdt.c	2006-07-14 10:03:04.000000000 -0700
+++ g26/drivers/acpi/tables/tbrsdt.c	2006-09-13 13:38:39.000000000 -0700
@@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
 
 	if (table_ptr->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
+			    "RSDT/XSDT length (%X) is smaller than minimum (%zX)",
 			    table_ptr->length,
 			    sizeof(struct acpi_table_header)));
 
