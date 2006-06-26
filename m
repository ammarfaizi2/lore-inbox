Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933054AbWFZVT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbWFZVT3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933053AbWFZVT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:19:29 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:38351
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S933054AbWFZVT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:19:28 -0400
Message-ID: <44A04F5F.8030405@ed-soft.at>
Date: Mon, 26 Jun 2006 23:19:27 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix EFI boot on 32 bit machines with PCI Express slots.
Efi machines does not have an e820 memory map.
Without this patch a native EFI boot, on
Intel Macs, is impossible.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--- a/arch/i386/kernel/setup.c  2006-06-25 03:13:24.000000000 +0200
+++ b/arch/i386/kernel/setup.c  2006-06-25 03:13:50.000000000 +0200
@@ -975,6 +975,10 @@
        u64 start = s;
        u64 end = e;
        int i;
+
+       if (efi_enabled)
+               return 1;
+
        for (i = 0; i < e820.nr_map; i++) {
                struct e820entry *ei = &e820.map[i];
                if (type && ei->type != type)


