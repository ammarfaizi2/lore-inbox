Return-Path: <linux-kernel-owner+w=401wt.eu-S932190AbXAEBst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbXAEBst (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 20:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAEBst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 20:48:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35880 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbXAEBss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 20:48:48 -0500
Date: Thu, 4 Jan 2007 17:48:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <200701050148.l051mHGM005275@terminus.zytor.com>
To: akpm@osdl.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] All Transmeta CPUs have constant TSCs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[i386] All Transmeta CPUs have constant TSCs

All Transmeta CPUs ever produced have constant-rate TSCs.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 07e54489ef8a3341b20ae42b53b1254a68061204
tree 204fa19fe2b2dd3ddb1add83ec66ccda7360f4e6
parent 7523c4dd9923cab748dad9b79d0165e118e3d03b
author H. Peter Anvin <hpa@zytor.com> Thu, 04 Jan 2007 17:44:34 -0800
committer H. Peter Anvin <hpa@zytor.com> Thu, 04 Jan 2007 17:44:34 -0800

 arch/i386/kernel/cpu/transmeta.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 4056fb7..b536e81 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -72,6 +72,9 @@ static void __cpuinit init_transmeta(struct cpuinfo_x86 *c)
 	wrmsr(0x80860004, ~0, uk);
 	c->x86_capability[0] = cpuid_edx(0x00000001);
 	wrmsr(0x80860004, cap_mask, uk);
+
+	/* All Transmeta CPUs have a constant TSC */
+	set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
 	
 	/* If we can run i686 user-space code, call us an i686 */
 #define USER686 (X86_FEATURE_TSC|X86_FEATURE_CX8|X86_FEATURE_CMOV)
