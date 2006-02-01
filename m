Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWBATO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWBATO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWBATO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:14:59 -0500
Received: from mail.enyo.de ([212.9.189.167]:4016 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1422880AbWBATO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:14:58 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AMD64: fix mce_cpu_quirks typos
Date: Wed, 01 Feb 2006 20:14:56 +0100
Message-ID: <87fyn2yjpr.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spurious MCE is TLB-related.  I *think* the bit for the correct
status code is stored at position 10 HEX, not 10 DEC.  At least I
still get those MCEs on a two-way Opteron box, even though they are
supposed to be filtered out.

Signed-off-by: Florian Weimer <fw@deneb.enyo.de>

---

 arch/x86_64/kernel/mce.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

102dfead12550ecaf7363a8ca7269ac0f1241bac
diff --git a/arch/x86_64/kernel/mce.c b/arch/x86_64/kernel/mce.c
index 13a2ead..975d128 100644
--- a/arch/x86_64/kernel/mce.c
+++ b/arch/x86_64/kernel/mce.c
@@ -350,9 +350,9 @@ static void __cpuinit mce_cpu_quirks(str
 { 
 	/* This should be disabled by the BIOS, but isn't always */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 15) {
-		/* disable GART TBL walk error reporting, which trips off 
+		/* disable GART TLB walk error reporting, which trips off
 		   incorrectly with the IOMMU & 3ware & Cerberus. */
-		clear_bit(10, &bank[4]);
+		clear_bit(0x10, &bank[4]);
 		/* Lots of broken BIOS around that don't clear them
 		   by default and leave crap in there. Don't log. */
 		mce_bootlog = 0;
-- 
1.1.5
