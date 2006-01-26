Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWAZSq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWAZSq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWAZSqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:46:43 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:20135 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751366AbWAZSqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:46:31 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060126184525.8550.50440.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 7/9] Add documentation for extra boot parameters
Date: Thu, 26 Jan 2006 18:45:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once all patches are applied, two new command-line parameters exist -
kernelcore and noeasyrclm. This patch adds the necessary documentation.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.16-rc1-mm3-107_hugetlb_use_easyrclm/Documentation/kernel-parameters.txt linux-2.6.16-rc1-mm3-108_docs/Documentation/kernel-parameters.txt
--- linux-2.6.16-rc1-mm3-107_hugetlb_use_easyrclm/Documentation/kernel-parameters.txt	2006-01-25 13:42:42.000000000 +0000
+++ linux-2.6.16-rc1-mm3-108_docs/Documentation/kernel-parameters.txt	2006-01-26 18:14:24.000000000 +0000
@@ -702,6 +702,16 @@ running once the system is up.
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joystick.txt.
 
+	kernelcore=nn[KMG]	[KNL,IA-32,PPC] On the x86 and ppc64, this
+			parameter specifies the amount of memory usable
+			by the kernel and places the rest in an EasyRclm
+			zone. The EasyRclm zone is used for the allocation
+			of pages on behalf of a process and for HugeTLB
+			pages. On ppc64, it is likely that memory sections
+			on this zone can be offlined. Note that allocations
+			like PTEs-from-HighMem still use the HighMem zone
+			if it exists, and the Normal zone if it does not.
+
 	keepinitrd	[HW,ARM]
 
 	kstack=N	[IA-32,X86-64] Print N words from the kernel stack
@@ -1004,6 +1014,16 @@ running once the system is up.
 
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
 
+	noeasyrclm	[IA-32,PPC] If kernelcore= is specified, the default
+			zone to add memory to for IA-32 and PPC is EasyRclm. If
+			this is undesirable, noeasyrclm can be specified to
+			force the adding of memory on IA-32 to ZONE_HIGHMEM
+			and to ZONE_DMA on PPC. This is desirable when the
+			EasyRclm zone is setup as a "soft" area for HugeTLB
+			pages to be allocated from to give the chance for
+			administrators to grow the reserved number of Huge
+			pages when the system has been running for some time.
+
 	noexec		[IA-64]
 
 	noexec		[IA-32,X86-64]
