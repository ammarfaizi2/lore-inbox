Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935868AbWK1LgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935868AbWK1LgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935870AbWK1LgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:36:19 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:38665 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S935868AbWK1LgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:36:18 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2
Date: Tue, 28 Nov 2006 12:35:43 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061128020246.47e481eb.akpm@osdl.org>
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281235.45087.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	When CONFIG_MODULE_UNLOAD is not set then this happens:

  CC      kernel/module.o
kernel/module.c:852: error: `initstate' undeclared here (not in a function)
kernel/module.c:852: error: initializer element is not constant
kernel/module.c:852: error: (near initialization for `modinfo_attrs[2]')
make[1]: *** [kernel/module.o] Error 1
make: *** [kernel] Error 2

Reference to 'initstate' should stay under #ifdef CONFIG_MODULE_UNLOAD
as its definition I guess.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc6-mm2-a/kernel/module.c      2006-11-28 12:17:09.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/kernel/module.c      2006-11-28 12:05:01.000000000 +0100
@@ -849,8 +849,8 @@ static inline void module_unload_init(st
 static struct module_attribute *modinfo_attrs[] = {
        &modinfo_version,
        &modinfo_srcversion,
-       &initstate,
 #ifdef CONFIG_MODULE_UNLOAD
+       &initstate,
        &refcnt,
 #endif
        NULL,

-- 
Regards,

	Mariusz Kozlowski
