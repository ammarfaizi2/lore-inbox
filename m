Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUKROKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUKROKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKROKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:10:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37320 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261789AbUKROIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:08:36 -0500
Message-ID: <419CACE2.7060408@in.ibm.com>
Date: Thu, 18 Nov 2004 19:38:34 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
CC: pbadari@us.ibm.com, Vara Prasad <varap@us.ibm.com>
Subject: [PATCH] kdump: Fix for boot problems on SMP
Content-Type: multipart/mixed;
 boundary="------------030404010904060006030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030404010904060006030203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

There was a buggy (and unnecessary) reserve_bootmem call in the kdump 
call which was causing hangs during early on some SMP machines. The 
attached patch removes that.

Kindly include this patch into the -mm tree.

Thanks and Regards, Hari


--------------030404010904060006030203
Content-Type: text/plain;
 name="kdump-reserve-bootmem-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-reserve-bootmem-fix.patch"



Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.10-rc2-hari/include/asm-i386/crash_dump.h |    1 -
 1 files changed, 1 deletion(-)

diff -puN include/asm-i386/crash_dump.h~kdump-reserve-bootmem-fix include/asm-i386/crash_dump.h
--- linux-2.6.10-rc2/include/asm-i386/crash_dump.h~kdump-reserve-bootmem-fix	2004-11-18 19:20:47.000000000 +0530
+++ linux-2.6.10-rc2-hari/include/asm-i386/crash_dump.h	2004-11-18 19:21:03.000000000 +0530
@@ -37,7 +37,6 @@ static inline void set_saved_max_pfn(voi
 static inline void crash_reserve_bootmem(void)
 {
 	if (!dump_enabled) {
-		reserve_bootmem(0, CRASH_RELOCATE_SIZE);
 		reserve_bootmem(CRASH_BACKUP_BASE,
 			CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE + PAGE_SIZE);
 	}
_

--------------030404010904060006030203--
