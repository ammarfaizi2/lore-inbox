Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVFGAmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVFGAmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFGAmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:42:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51416 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261771AbVFGAmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:42:16 -0400
Message-ID: <42A4ED65.2020403@us.ibm.com>
Date: Mon, 06 Jun 2005 17:42:13 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Bligh, Martin J." <mbligh@aracnet.com>
Subject: Fix send_IPI_mask_sequence warning
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090209010105070200020005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209010105070200020005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I get the following warning building 2.6.12-rc5-mm2 on my NUMA-Q box:

In file included from arch/i386/kernel/smp.c:235:
include/asm-i386/mach-numaq/mach_ipi.h:4: warning: `send_IPI_mask_sequence'
declared inline after its definition


This patch silences the warning.

-Matt

--------------090209010105070200020005
Content-Type: text/x-patch;
 name="fix-send_IPI_mask_sequence-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-send_IPI_mask_sequence-warning.patch"

--- linux-2.6.12-rc5-mm2/include/asm-i386/mach-numaq/mach_ipi.h	2005-06-01 11:13:31.000000000 -0700
+++ linux-2.6.12-rc5-mm2/include/asm-i386/mach-numaq/mach_ipi.h.fixed	2005-06-06 17:02:30.490310944 -0700
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-inline void send_IPI_mask_sequence(cpumask_t, int vector);
+void send_IPI_mask_sequence(cpumask_t, int vector);
 
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {

--------------090209010105070200020005--
