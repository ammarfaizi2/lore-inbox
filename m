Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWFYBSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFYBSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 21:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWFYBSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 21:18:23 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:39826
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751285AbWFYBSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 21:18:23 -0400
Message-ID: <449DE45C.90902@ed-soft.at>
Date: Sun, 25 Jun 2006 03:18:20 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #3]
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix EFI boot on 32 bit machines with pcie port.
Efi machines does not have an e820 memory map.
This bug makes native efi boots on Intel Mac's
impossible.
[try #3] simplified the patch.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--- a/arch/i386/kernel/setup.c	2006-06-25 03:13:24.000000000 +0200
+++ b/arch/i386/kernel/setup.c	2006-06-25 03:13:50.000000000 +0200
@@ -975,6 +975,10 @@
 	u64 start = s;
 	u64 end = e;
 	int i;
+
+	if (efi_enabled)
+		return 1;
+
 	for (i = 0; i < e820.nr_map; i++) {
 		struct e820entry *ei = &e820.map[i];
 		if (type && ei->type != type)


