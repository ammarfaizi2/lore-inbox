Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSEJL7F>; Fri, 10 May 2002 07:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315586AbSEJL7E>; Fri, 10 May 2002 07:59:04 -0400
Received: from kim.it.uu.se ([130.238.12.178]:6016 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S313113AbSEJL7D>;
	Fri, 10 May 2002 07:59:03 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.46584.447522.360378@kim.it.uu.se>
Date: Fri, 10 May 2002 13:58:48 +0200
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
In-Reply-To: <26949.1021006885@kao2.melbourne.sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
 > sound/oss/emu10k1/efxmgr.c: In function `emu10k1_find_control_gpr':
 > sound/oss/emu10k1/efxmgr.c:67: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > sound/oss/emu10k1/efxmgr.c:67: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
 > sound/oss/emu10k1/main.c: In function `fx_init':
 > sound/oss/emu10k1/main.c:473: warning: passing arg 2 of `set_bit' from incompatible pointer type
 > sound/oss/emu10k1/main.c:474: warning: passing arg 2 of `set_bit' from incompatible pointer type
 > sound/oss/emu10k1/main.c:475: warning: passing arg 2 of `set_bit' from incompatible pointer type
 > sound/oss/emu10k1/main.c:  and on and on and on ...

This patch silences the sound/oss/emu10k1 warnings.

/Mikael

--- linux-2.5.15/sound/oss/emu10k1/efxmgr.c.~1~	Wed Feb 20 03:10:55 2002
+++ linux-2.5.15/sound/oss/emu10k1/efxmgr.c	Fri May 10 01:54:43 2002
@@ -38,7 +38,7 @@
         struct dsp_patch *patch;
 	struct dsp_rpatch *rpatch;
 	char s[PATCH_NAME_SIZE + 4];
-	u32 *gpr_used;
+	unsigned long *gpr_used;
 	int i;
 
 	DPD(2, "emu10k1_find_control_gpr(): %s %s\n", patch_name, gpr_name);
--- linux-2.5.15/sound/oss/emu10k1/efxmgr.h.~1~	Wed Feb 20 03:11:02 2002
+++ linux-2.5.15/sound/oss/emu10k1/efxmgr.h	Fri May 10 01:54:43 2002
@@ -50,10 +50,10 @@
         u16 code_start;
         u16 code_size;
 
-        u32 gpr_used[NUM_GPRS / 32];
-        u32 gpr_input[NUM_GPRS / 32];
-        u32 route[NUM_OUTPUTS];
-        u32 route_v[NUM_OUTPUTS];
+        unsigned long gpr_used[NUM_GPRS / 32];
+        unsigned long gpr_input[NUM_GPRS / 32];
+        unsigned long route[NUM_OUTPUTS];
+        unsigned long route_v[NUM_OUTPUTS];
 };
 
 struct dsp_patch {
@@ -64,8 +64,8 @@
         u16 code_start;
         u16 code_size;
 
-        u32 gpr_used[NUM_GPRS / 32];    /* bitmap of used gprs */
-        u32 gpr_input[NUM_GPRS / 32];
+        unsigned long gpr_used[NUM_GPRS / 32];    /* bitmap of used gprs */
+        unsigned long gpr_input[NUM_GPRS / 32];
         u8 traml_istart;  /* starting address of the internal tram lines used */
         u8 traml_isize;   /* number of internal tram lines used */
 
