Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVHDXVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVHDXVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVHDXVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:21:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:46023 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262729AbVHDXVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:21:07 -0400
Subject: [PATCH] fix voyager compile after machine_emergency_restart
	breakage
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 18:20:49 -0500
Message-Id: <1123197649.5026.81.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] i386: Implement machine_emergency_reboot

introduced this new function into arch/i386/reboot.c.  However,
subarchitectures are entitled to implement their own copies of reboot.c
from which this new function is now missing.

It looks like visws will also need a similar fixup

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

diff --git a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c
+++ b/arch/i386/mach-voyager/voyager_basic.c
@@ -279,6 +279,13 @@ machine_restart(char *cmd)
 }
 
 void
+machine_emergency_restart(void)
+{
+	/*for now, just hook this to a warm restart */
+	machine_restart(NULL);
+}
+
+void
 mca_nmi_hook(void)
 {
 	__u8 dumpval __attribute__((unused)) = inb(0xf823);



