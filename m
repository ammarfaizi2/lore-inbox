Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWE1VMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWE1VMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWE1VMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:12:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:63887 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750949AbWE1VMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:12:08 -0400
Date: Sun, 28 May 2006 23:12:06 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] enable CONFIG_KALLSYMS_ALL unconditionally after allnoconfig
Message-ID: <20060528211206.GA13458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
 # 'Kernel hacking  ---> ' , enable 'Kernel debugging '
grep KALLSYMS ../foo-$$/.config

enabled it along with CONFIG_KALLSYMS, because CONFIG_KALLSYMS is not selectable per default
xmon can not lookup all symbols without CONFIG_KALLSYMS_ALL,
'ls log_buf' will not work as example.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -276,6 +276,7 @@ config KALLSYMS
 config KALLSYMS_ALL
 	bool "Include all symbols in kallsyms"
 	depends on DEBUG_KERNEL && KALLSYMS
+	default y
 	help
 	   Normally kallsyms only contains the symbols of functions, for nicer
 	   OOPS messages.  Some debuggers can use kallsyms for other
