Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVCPU2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVCPU2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVCPU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:28:23 -0500
Received: from everest.2mbit.com ([24.123.221.2]:36290 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261409AbVCPU2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:28:20 -0500
Date: Wed, 16 Mar 2005 15:28:00 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: pavel@suse.cz
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] SUSPEND_PD_PAGES-fix
Message-ID: <20050316202800.GA22750@everest.sosdg.org>
Reply-To: coywolf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.


	Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
diff -pruN 2.6.11-mm4/include/linux/suspend.h 2.6.11-mm4-cy/include/linux/suspend.h
--- 2.6.11-mm4/include/linux/suspend.h	2005-03-17 01:22:16.000000000 +0800
+++ 2.6.11-mm4-cy/include/linux/suspend.h	2005-03-17 04:14:16.000000000 +0800
@@ -34,7 +34,7 @@ typedef struct pbe {
 #define SWAP_FILENAME_MAXLENGTH	32
 
 
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe)+PAGE_SIZE-1)/PAGE_SIZE)
 
 extern dev_t swsusp_resume_device;
    
