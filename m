Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269600AbUJGB2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269600AbUJGB2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUJGB2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:28:13 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57103 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S269600AbUJGB2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:28:11 -0400
Date: Thu, 7 Oct 2004 02:28:10 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ingo Molnar <mingo@chiara.csoma.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] APIC physical broadcast for i82489DX
Message-ID: <Pine.LNX.4.58L.0410070217360.2397@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

 The physical broadcast ID is determined incorrectly for the i82489DX,
which uses 8-bit physical addressing (32-bit logical).  Please apply the
following patch.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.9-rc2-20040920-apic-broadcast-0
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/apic.c linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/apic.c
--- linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/apic.c	2004-09-20 03:57:43.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/apic.c	2004-10-07 01:10:37.000000000 +0000
@@ -91,7 +91,7 @@ int get_physical_broadcast(void)
 	unsigned int lvr, version;
 	lvr = apic_read(APIC_LVR);
 	version = GET_APIC_VERSION(lvr);
-	if (version >= 0x14)
+	if (!APIC_INTEGRATED(version) || version >= 0x14)
 		return 0xff;
 	else
 		return 0xf;
