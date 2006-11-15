Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWKOOrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWKOOrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWKOOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:47:15 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:42389
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030510AbWKOOrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:47:15 -0500
Message-Id: <455B36D2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 14:48:34 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "linux-acpi" <linux-acpi@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] avoid compiler warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should not be casted to u32 as this results in compiler warnings
on 64-bit platforms.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/drivers/acpi/executer/exmutex.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-acpi-warnings/drivers/acpi/executer/exmutex.c	2006-11-06 09:10:16.000000000 +0100
@@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
+			    (unsigned long) walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    (unsigned long) obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
--- linux-2.6.19-rc5/drivers/acpi/utilities/utmutex.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-acpi-warnings/drivers/acpi/utilities/utmutex.c	2006-11-06 09:10:16.000000000 +0100
@@ -258,8 +258,8 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				(u32) this_thread_id, mutex_id));
+				"Thread %lX could not acquire Mutex [%X]",
+				(unsigned long) this_thread_id, mutex_id));
 	}
 
 	return (status);


