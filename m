Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUKSRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUKSRzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKSRzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:55:03 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:22783 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261512AbUKSRxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:53:20 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Hariprasad Nellitheertha <hari@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
Date: Sat, 20 Nov 2004 02:56:36 +0900
User-Agent: KMail/1.5.4
Cc: pbadari@us.ibm.com, Vara Prasad <varap@us.ibm.com>
References: <419CACE2.7060408@in.ibm.com>
In-Reply-To: <419CACE2.7060408@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411200256.36218.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 November 2004 23:08, Hariprasad Nellitheertha wrote:

> There was a buggy (and unnecessary) reserve_bootmem call in the kdump
> call which was causing hangs during early on some SMP machines. The
> attached patch removes that.

Thanks! I also had the same problem.

BTW, If the first kernel enabled CONFIG_DISCONTIGMEM, the second kernel could
not boot. since crash_reserve_bootmem() never called anywhere. 


--- 2.6-mm/arch/i386/mm/discontig.c.orig	2004-11-20 00:14:42.000000000 +0900
+++ 2.6-mm/arch/i386/mm/discontig.c	2004-11-20 00:39:38.000000000 +0900
@@ -32,6 +32,7 @@
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
+#include <asm/crash_dump.h>
 #include <bios_ebda.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
@@ -363,6 +364,9 @@ unsigned long __init setup_memory(void)
 		}
 	}
 #endif
+
+	crash_reserve_bootmem();
+
 	return system_max_low_pfn;
 }
 



