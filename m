Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWGJWNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWGJWNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWGJWNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:13:35 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:30103 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965266AbWGJWNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:13:11 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH] Fix a memory leak in the i386 setup code
Date: Mon, 10 Jul 2006 23:13:08 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710221308.5351.78741.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@gmail.com>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 arch/i386/kernel/setup.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 08c00d2..d32d264 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1327,7 +1327,10 @@ #endif
 		res->start = e820.map[i].addr;
 		res->end = res->start + e820.map[i].size - 1;
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
+		if (request_resource(&iomem_resource, res)) {
+			kfree(res);
+			continue;
+		}
 		if (e820.map[i].type == E820_RAM) {
 			/*
 			 *  We don't know which RAM region contains kernel data,
