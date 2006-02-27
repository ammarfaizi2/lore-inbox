Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWB0Amr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWB0Amr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWB0Amr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:42:47 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:37412 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751433AbWB0Amr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:42:47 -0500
X-IronPort-AV: i="4.02,148,1139212800"; 
   d="scan'208"; a="410094071:sNHT32010740"
To: ak@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [PATCH] Fix x86_64 build with CONFIG_HOTPLUG_CPU=n
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 26 Feb 2006 16:42:42 -0800
Message-ID: <adar75pskcd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Feb 2006 00:42:43.0984 (UTC) FILETIME=[B8B5E900:01C63B36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86_64, kernel/setup.c calls setup_additional_cpus() if
CONFIG_SMP is defined.  However, kernel/smpboot.c only defines it if
CONFIG_HOTPLUG_CPU is defined, so a build with SMP but not HOTPLUG_CPU
will fail.  Fix this by testing HOTPLUG_CPU in kernel/setup.c as well.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -424,7 +424,7 @@ static __init void parse_cmdline_early (
 			elfcorehdr_addr = memparse(from+11, &from);
 #endif
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 		else if (!memcmp(from, "additional_cpus=", 16))
 			setup_additional_cpus(from+16);
 #endif
