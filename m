Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTEFU5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTEFU5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:57:23 -0400
Received: from zero.aec.at ([193.170.194.10]:36364 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261956AbTEFU5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:57:16 -0400
Date: Tue, 6 May 2003 23:08:31 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030506210831.GA18315@averell>
References: <20030506063055.GA15424@averell> <20030506164441.GO9794@fs.tum.de> <20030506195614.GA23831@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506195614.GA23831@averell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 09:56:14PM +0200, Andi Kleen wrote:
> The driver is buggy. The #ifdef MODULE needs to be removed and proc_cpia_destroy 
> be marked __exit instead, then things will be ok.

FWIW I compiled a "maxi kernel" now (with everything that compiles compiled in) 
and only cpia seems to have this bug. So with this patch things should be ok
again.

-Andi

Index: linux/drivers/media/video/cpia.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/media/video/cpia.c,v
retrieving revision 1.25
diff -u -u -r1.25 cpia.c
--- linux/drivers/media/video/cpia.c	25 Apr 2003 05:41:01 -0000	1.25
+++ linux/drivers/media/video/cpia.c	6 May 2003 20:08:34 -0000
@@ -1409,12 +1409,10 @@
 		LOG("Unable to initialise /proc/cpia\n");
 }
 
-#ifdef MODULE
-static void proc_cpia_destroy(void)
+static void __exit proc_cpia_destroy(void)
 {
 	remove_proc_entry("cpia", 0);
 }
-#endif /*MODULE*/
 #endif /* CONFIG_PROC_FS */
 
 /* ----------------------- debug functions ---------------------- */
