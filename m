Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUIHOIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUIHOIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUIHOHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:07:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:56287 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269003AbUIHNnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:43:33 -0400
Date: Wed, 8 Sep 2004 15:40:28 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_CMDLINE broken on ppc
Message-ID: <20040908134028.GB15209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_CMDLINE can not work on ppc.
machine_init() copies the string to cmd_line, then platform_init() is
called. It truncates the string to length zero.



--- ./arch/ppc/kernel/setup.c.kaputt    2004-09-08 14:23:36.000000000 +0200
+++ ./arch/ppc/kernel/setup.c   2004-09-08 15:30:42.000000000 +0200
@@ -418,7 +418,9 @@ platform_init(unsigned long r3, unsigned
         * are used for initrd_start and initrd_size,
         * otherwise they contain 0xdeadbeef.
         */
+#if 0  
        cmd_line[0] = 0;
+#endif 
        if (r3 >= 0x4000 && r3 < 0x800000 && r4 == 0) {
                strlcpy(cmd_line, (char *)r3 + KERNELBASE,
                        sizeof(cmd_line));


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
