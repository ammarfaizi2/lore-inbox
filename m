Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWHALHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWHALHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWHALHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16605 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932620AbWHALGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:36 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 27/33] x86_64: Modify discover_ebda to use virtual addresses
Date: Tue,  1 Aug 2006 05:03:42 -0600
Message-Id: <11544302453338-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 66816ba..21840ca 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -505,10 +505,10 @@ static void discover_ebda(void)
 	 * there is a real-mode segmented pointer pointing to the 
 	 * 4K EBDA area at 0x40E
 	 */
-	ebda_addr = *(unsigned short *)EBDA_ADDR_POINTER;
+	ebda_addr = *(unsigned short *)__va(EBDA_ADDR_POINTER);
 	ebda_addr <<= 4;
 
-	ebda_size = *(unsigned short *)(unsigned long)ebda_addr;
+	ebda_size = *(unsigned short *)__va(ebda_addr);
 
 	/* Round EBDA up to pages */
 	if (ebda_size == 0)
-- 
1.4.2.rc2.g5209e

