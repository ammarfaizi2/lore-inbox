Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCCWxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCCWxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCCWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:50:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262691AbVCCWQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:16:32 -0500
Date: Thu, 3 Mar 2005 17:16:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] cpuid takes unsigned arguments
Message-ID: <Pine.LNX.4.61.0503031713350.984@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because Xen is compiled with -Wall -Werror, has inherited
processor.h from Linux and Fedora is now built with gcc4,
I discovered this bug.

The few callers I verified all call cpuid with unsigned
ints, but the function is defined with signed ints. This
trivial patch fixes that.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.10/include/asm-i386/processor.h.cpuid	2005-03-03 17:11:55.000000000 -0500
+++ linux-2.6.10/include/asm-i386/processor.h	2005-03-03 17:14:09.000000000 -0500
@@ -137,7 +137,7 @@ static inline void detect_ht(struct cpui
  * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
  * resulting in stale register contents being returned.
  */
-static inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
 {
 	__asm__("cpuid"
 		: "=a" (*eax),
