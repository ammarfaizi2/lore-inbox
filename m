Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDEO5D (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 09:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTDEO5D (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 09:57:03 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:8625 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S262423AbTDEO5C (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 09:57:02 -0500
Date: Sat, 5 Apr 2003 17:08:33 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Linux 2.4.21-pre7 acpi warning fix
Message-ID: <Pine.LNX.4.51.0304051706460.2872@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Shortly.
To fix this:
evevent.c: In function `acpi_ev_gpe_dispatch':
evevent.c:803: warning: cast to pointer from integer of different size

I recommend this patch.

Regards,
Maciej

diff -Nru linux-2.4.20.orig/drivers/acpi/events/evevent.c linux-2.4.20/drivers/acpi/events/evevent.c
--- linux-2.4.20.orig/drivers/acpi/events/evevent.c	2003-04-05 17:05:20.000000000 +0200
+++ linux-2.4.20/drivers/acpi/events/evevent.c	2003-04-05 16:59:55.000000000 +0200
@@ -800,7 +800,7 @@
 	 */
 	else if (gpe_info.method_handle) {
 		if (ACPI_FAILURE(acpi_os_queue_for_execution (OSD_PRIORITY_GPE,
-			acpi_ev_asynch_execute_gpe_method, (void*) (u64)gpe_number))) {
+			acpi_ev_asynch_execute_gpe_method, (void*) (u32)gpe_number))) {
 			/*
 			 * Shoudn't occur, but if it does report an error. Note that
 			 * the GPE will remain disabled until the ACPI Core Subsystem
