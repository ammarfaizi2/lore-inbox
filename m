Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWE2JgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWE2JgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWE2JgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:36:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:65167 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750814AbWE2JgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:36:04 -0400
Date: Mon, 29 May 2006 11:36:03 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Paul Mackeras <paulus@samba.org>
Subject: [PATCH] enable CONFIG_KALLSYMS_ALL unconditionally for xmon after allnoconfig
Message-ID: <20060529093602.GA17819@suse.de>
References: <20060528211206.GA13458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060528211206.GA13458@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_KALLSYMS_ALL is disabled after these commands:

rm -rf ../foo-$$
mkdir ../foo-$$
make -j ARCH=powerpc O=../foo-$$ allnoconfig  > /dev/null 
grep KALLSYMS ../foo-$$/.config
make -j ARCH=powerpc O=../foo-$$ menuconfig
 # 'Kernel hacking  ---> ' , enable 'Kernel debugging ' + 'Enable debugger hooks' + 'Include xmon kernel debugger'
grep KALLSYMS ../foo-$$/.config

enable CONFIG_KALLSYMS_ALL, because CONFIG_KALLSYMS is not selectable per default
xmon can not lookup all symbols without CONFIG_KALLSYMS_ALL,
'ls log_buf' will not work as example.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 arch/powerpc/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/powerpc/Kconfig.debug
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig.debug
+++ linux-2.6/arch/powerpc/Kconfig.debug
@@ -64,6 +64,7 @@ config KGDB_CONSOLE
 config XMON
 	bool "Include xmon kernel debugger"
 	depends on DEBUGGER && !PPC_ISERIES
+	select KALLSYMS_ALL
 	help
 	  Include in-kernel hooks for the xmon kernel monitor/debugger.
 	  Unless you are intending to debug the kernel, say N here.
