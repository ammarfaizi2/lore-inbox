Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKOFBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKOFBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKOFAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:00:36 -0500
Received: from ozlabs.org ([203.10.76.45]:41396 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261443AbUKOFAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:00:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.14169.933065.101043@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 15:58:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 call ibm,os-term only if its available
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Olaf Hering.

The rtas property 'ibm,os-term' is not available on JS20, a panic will
print:

unable to mount root filesystem on /dev/hda
Kernel panic - not syncing: Attempted to kill init!
 <0>ibm,os-term call failed -1
Rebooting in 42 seconds..

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -purN linux-2.6.10-rc1-bk15.orig/arch/ppc64/kernel/rtas.c linux-2.6.10-rc1-bk15.ibm,os-term/arch/ppc64/kernel/rtas.c
--- linux-2.6.10-rc1-bk15.orig/arch/ppc64/kernel/rtas.c	2004-11-05 14:52:14.747905961 +0100
+++ linux-2.6.10-rc1-bk15.ibm,os-term/arch/ppc64/kernel/rtas.c	2004-11-05 23:00:10.581515367 +0100
@@ -439,6 +439,9 @@ void rtas_os_term(char *str)
 {
 	int status;
 
+	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term"))
+		return;
+
 	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
 
 	do {
