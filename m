Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263303AbVCKNau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbVCKNau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVCKNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:30:50 -0500
Received: from baikonur.stro.at ([213.239.196.228]:204 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S263303AbVCKNai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:30:38 -0500
Date: Fri, 11 Mar 2005 14:30:36 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [patch] cyrix eliminate bad section references
Message-ID: <20050311133036.GA10599@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cyrix section references:
 convert __initdata to __devinitdata.

Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 00000379
R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 00000399
R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003b3
R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003b9
R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003bf
R_386_32          .init.data

not many left on my .config, thanks Randy!


signed-of-by: maximilian attems <janitor@sternwelten.at>



diff -pruN -X dontdiff linux-2.6.11-bk6/arch/i386/kernel/cpu/mtrr/cyrix.c linux-2.6.11-bk6-max/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-2.6.11-bk6/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-03-11 09:28:05.000000000 +0100
+++ linux-2.6.11-bk6-max/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-03-11 14:15:33.000000000 +0100
@@ -218,12 +218,12 @@ typedef struct {
 	mtrr_type type;
 } arr_state_t;
 
-static arr_state_t arr_state[8] __initdata = {
+static arr_state_t arr_state[8] __devinitdata = {
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
 	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
 };
 
-static unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
+static unsigned char ccr_state[7] __devinitdata = { 0, 0, 0, 0, 0, 0, 0 };
 
 static void cyrix_set_all(void)
 {
