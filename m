Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTAVFJv>; Wed, 22 Jan 2003 00:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTAVFJv>; Wed, 22 Jan 2003 00:09:51 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:49668
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267315AbTAVFJt>; Wed, 22 Jan 2003 00:09:49 -0500
Date: Wed, 22 Jan 2003 00:18:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Jones <davej@suse.de>
Subject: [PATCH][2.5][2/18] smp_call_function_on_cpu - drivers/
Message-ID: <Pine.LNX.4.44.0301220016240.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/drivers/char/agp/agp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/drivers/char/agp/agp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 agp.h
--- linux-2.5.59/drivers/char/agp/agp.h	17 Jan 2003 11:15:30 -0000	1.1.1.1
+++ linux-2.5.59/drivers/char/agp/agp.h	22 Jan 2003 02:32:44 -0000
@@ -42,7 +42,7 @@
 
 static void __attribute__((unused)) global_cache_flush(void)
 {
-	if (smp_call_function(ipi_handler, NULL, 1, 1) != 0)
+	if (smp_call_function(ipi_handler, NULL, 1) != 0)
 		panic(PFX "timed out waiting for the other CPUs!\n");
 	flush_agp_cache();
 }
Index: linux-2.5.59/drivers/s390/char/sclp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/drivers/s390/char/sclp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sclp.c
--- linux-2.5.59/drivers/s390/char/sclp.c	17 Jan 2003 11:15:36 -0000	1.1.1.1
+++ linux-2.5.59/drivers/s390/char/sclp.c	22 Jan 2003 02:34:10 -0000
@@ -481,7 +481,7 @@
 do_machine_quiesce(void)
 {
 	cpu_quiesce_map = cpu_online_map;
-	smp_call_function(do_load_quiesce_psw, NULL, 0, 0);
+	smp_call_function(do_load_quiesce_psw, NULL, 0);
 	do_load_quiesce_psw(NULL);
 }
 #else
Index: linux-2.5.59/drivers/s390/net/iucv.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/drivers/s390/net/iucv.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 iucv.c
--- linux-2.5.59/drivers/s390/net/iucv.c	17 Jan 2003 11:15:36 -0000	1.1.1.1
+++ linux-2.5.59/drivers/s390/net/iucv.c	22 Jan 2003 02:34:36 -0000
@@ -620,7 +620,7 @@
 	if (smp_processor_id() == 0)
 		iucv_declare_buffer_cpu0(&b2f0_result);
 	else
-		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
+		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 1);
 	iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
 	if (b2f0_result == 0x0deadbeef)
 	    b2f0_result = 0xaa;
@@ -642,7 +642,7 @@
 		if (smp_processor_id() == 0)
 			iucv_retrieve_buffer_cpu0(0);
 		else
-			smp_call_function(iucv_retrieve_buffer_cpu0, 0, 0, 1);
+			smp_call_function(iucv_retrieve_buffer_cpu0, NULL, 1);
 		declare_flag = 0;
 	}
 	iucv_debug(1, "exiting");

-- 
function.linuxpower.ca


