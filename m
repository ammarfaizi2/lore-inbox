Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWJWDrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWJWDrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJWDrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:47:53 -0400
Received: from mga03.intel.com ([143.182.124.21]:21922 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751324AbWJWDrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:47:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="134527939:sNHT21793527"
Message-ID: <453C3A29.4010606@intel.com>
Date: Mon, 23 Oct 2006 11:42:33 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix minor error about efi memory_present
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
   Function efi_memory_present_wrapper parameter start/end is physical address,
but function memory_present parameter is PFN, this patch converts physical
address to PFN.

  Signed-off-by: bibo, mao <bibo.mao@intel.com>

thanks
bibo,mao

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 519e63c..141041d 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -846,7 +846,7 @@ efi_find_max_pfn(unsigned long start, un
 static int __init
 efi_memory_present_wrapper(unsigned long start, unsigned long end, void *arg)
 {
-	memory_present(0, start, end);
+	memory_present(0, PFN_UP(start), PFN_DOWN(end));
 	return 0;
 }
 
