Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFQOkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTFQOkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:40:03 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:50449 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264619AbTFQOkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:40:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10558616342231@movementarian.org>
Subject: [PATCH 1/3] OProfile: small NMI shutdown fix
In-Reply-To: 
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 17 Jun 2003 15:53:54 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SHqN-000BnM-9Y*RWWqWk75Z8A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce the possibility of dazed-and-confuseds.

diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_int.c linux-fixes/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-06-15 15:32:09.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/nmi_int.c	2003-06-15 02:10:08.000000000 +0100
@@ -182,8 +182,8 @@
 static void nmi_shutdown(void)
 {
 	nmi_enabled = 0;
-	unset_nmi_callback();
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
+	unset_nmi_callback();
 	enable_lapic_nmi_watchdog();
 }
 

