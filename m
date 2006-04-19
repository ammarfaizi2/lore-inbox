Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDSTRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDSTRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWDSTRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:17:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10943 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751186AbWDSTRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:17:36 -0400
Subject: [PATCH] tpm: fix memory leak
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 14:13:40 -0500
Message-Id: <1145474020.4894.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The eventname was kmalloc'd and not freed in the *_show functions.

This bug was found by Coverity.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_bios.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm_bios.c	2006-04-18 15:14:45.626390250 -0500
+++ linux-2.6.17-rc1-tpm/drivers/char/tpm/tpm_bios.c	2006-04-19 13:53:55.746954250 -0500
@@ -320,6 +321,7 @@ static int tpm_binary_bios_measurements_
 	/* 5th: delimiter */
 	seq_putc(m, '\0');
 
+	kfree(eventname);
 	return 0;
 }
 
@@ -367,6 +369,7 @@ static int tpm_ascii_bios_measurements_s
 	/* 4th: eventname <= max + \'0' delimiter */
 	seq_printf(m, " %s\n", eventname);
 
+	kfree(eventname);
 	return 0;
 }
 


