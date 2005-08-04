Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVHDVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVHDVGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVHDVEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:04:35 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:4579 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262699AbVHDVEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:04:25 -0400
Subject: [PATCH 2/2] Re: Major breakage in linux-git on x86_64, oom killer
	goes on rampage
From: Pavel Roskin <proski@gnu.org>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1123189296.2332.7.camel@dv.roinet.com>
References: <1123185522.2462.14.camel@dv.roinet.com>
	 <1123189296.2332.7.camel@dv.roinet.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 17:04:22 -0400
Message-Id: <1123189462.2332.11.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the x86_64 specific part.

The return value of handle_mm_fault() should be compared with symbolic
constants, not numbers.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/arch/x86_64/mm/fault.c b/arch/x86_64/mm/fault.c
--- a/arch/x86_64/mm/fault.c
+++ b/arch/x86_64/mm/fault.c
@@ -439,15 +439,15 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 

-- 
Regards,
Pavel Roskin

