Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUI0LtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUI0LtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUI0LtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:49:15 -0400
Received: from zero.aec.at ([193.170.194.10]:19468 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266725AbUI0LtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:49:09 -0400
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Terminate i386 local APIC DMI exception table
From: Andi Kleen <ak@muc.de>
Date: Mon, 27 Sep 2004 13:48:49 +0200
Message-ID: <m36560exum.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[sending directly to Linus because Andrew said he is away] 

The i386 local APIC DMI exception table was not 0 terminated. The dmi
parser would walk into random .data space. Found during code review,
not known to cause problems, but should be still fixed.  I checked all
other DMI tables and they seemed to be ok.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux/arch/i386/kernel/apic.c-o linux/arch/i386/kernel/apic.c
--- linux/arch/i386/kernel/apic.c-o	2004-09-27 12:36:35.000000000 +0200
+++ linux/arch/i386/kernel/apic.c	2004-09-27 13:44:49.000000000 +0200
@@ -1233,7 +1233,8 @@
 static struct dmi_system_id __initdata apic_dmi_table[] = {
 	{ need_local_apic, "Intel C440GX+", {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Intel"),
-	  DMI_MATCH(DMI_BOARD_NAME,"C440GX+") } }
+	  DMI_MATCH(DMI_BOARD_NAME,"C440GX+") } },
+	{},
 };
 
 /*



