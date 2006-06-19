Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWFSTRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWFSTRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWFSTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:17:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15515 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932570AbWFSTRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:17:12 -0400
Date: Mon, 19 Jun 2006 15:16:56 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 64bit resources i386 proc iomem fix
Message-ID: <20060619191656.GE8172@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

With the recent changes to 64bit resources Kconfig options, following 
patch shall have to be applied to make sure things are not broken
on i386. Can you please include this patch.

Thanks
Vivek



o Avoid exporting memory more than 4G through /proc/iomem on i386 if
  CONFIG_RESOURCES_64BIT is not defined. Resources subsystem can not handle
  it.

o This patch is required after the recent re-organization of kconfig option
  for 64bit resources.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc6-1M-vivek/arch/i386/kernel/setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/setup.c~64bit-resources-i386-proc-iomem-fix arch/i386/kernel/setup.c
--- linux-2.6.17-rc6-1M/arch/i386/kernel/setup.c~64bit-resources-i386-proc-iomem-fix	2006-06-19 14:46:05.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/i386/kernel/setup.c	2006-06-19 14:46:37.000000000 -0400
@@ -1338,7 +1338,7 @@ legacy_init_iomem_resources(struct resou
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-#ifdef CONFIG_RESOURCES_32BIT
+#ifndef CONFIG_RESOURCES_64BIT
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
 #endif
_
