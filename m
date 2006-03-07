Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752467AbWCGBkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbWCGBkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbWCGBkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:40:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:56012 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752467AbWCGBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:40:36 -0500
Subject: [PATCH]cpu model calculation for family 6 cpu
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 09:39:39 +0800
Message-Id: <1141695579.19013.24.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86_model calculation also applies for family 6. early_cpu_detect
does the right thing, but generic_identify misses.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.16-rc5-root/arch/i386/kernel/cpu/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/cpu/common.c~cpu_model arch/i386/kernel/cpu/common.c
--- linux-2.6.16-rc5/arch/i386/kernel/cpu/common.c~cpu_model	2006-03-02 09:47:21.000000000 +0800
+++ linux-2.6.16-rc5-root/arch/i386/kernel/cpu/common.c	2006-03-02 09:53:01.000000000 +0800
@@ -278,10 +278,10 @@ void __devinit generic_identify(struct c
 			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
-			if (c->x86 == 0xf) {
+			if (c->x86 == 0xf)
 				c->x86 += (tfms >> 20) & 0xff;
+			if (c->x86 >= 0x6)
 				c->x86_model += ((tfms >> 16) & 0xF) << 4;
-			} 
 			c->x86_mask = tfms & 15;
 		} else {
 			/* Have CPUID level 0 only - unheard of */
_


