Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSGFEla>; Sat, 6 Jul 2002 00:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSGFEl3>; Sat, 6 Jul 2002 00:41:29 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41735 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317606AbSGFEl2>;
	Sat, 6 Jul 2002 00:41:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.org
Subject: [patch] 2.5.25 correct inconsistent keyboard maps
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 14:43:52 +1000
Message-ID: <28252.1025930632@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefiles that generate keyboard maps and the shipped files which
are used when loadkeys is not installed are inconsistent.  Some
Makefiles remove static, others do not.  Some shipped files have static
removed, others do not.  Make them consistent.

Index: 25.1/drivers/tc/Makefile
--- 25.1/drivers/tc/Makefile Sat, 06 Jul 2002 13:37:55 +1000 kaos (linux-2.5/o/b/47_Makefile 1.4 444)
+++ 25.1(w)/drivers/tc/Makefile Sat, 06 Jul 2002 14:35:08 +1000 kaos (linux-2.5/o/b/47_Makefile 1.4 444)
@@ -25,6 +25,8 @@ $(obj)/lk201-map.o: $(obj)/lk201-map.c
 ifdef GENERATE_KEYMAP
 
 $(obj)/lk201-map.c: $(obj)/%.c: $(src)/%.map
-	loadkeys --mktable $< > $@
+	loadkeys --mktable $< > $@.tmp
+	sed -e 's/^static *//' $@.tmp > $@
+	rm $@.tmp
 
 endif
Index: 25.1/drivers/acorn/char/Makefile
--- 25.1/drivers/acorn/char/Makefile Sat, 06 Jul 2002 13:37:55 +1000 kaos (linux-2.5/s/b/17_Makefile 1.4 444)
+++ 25.1(w)/drivers/acorn/char/Makefile Sat, 06 Jul 2002 14:36:15 +1000 kaos (linux-2.5/s/b/17_Makefile 1.4 444)
@@ -30,6 +30,8 @@ $(obj)/defkeymap-acorn.o: $(obj)/defkeym
 ifdef GENERATE_KEYMAP
 
 $(obj)/defkeymap-acorn.c: $(obj)/%.c: $(src)/%.map
-	loadkeys --mktable $< > $@
+	loadkeys --mktable $< > $@.tmp
+	sed -e 's/^static *//' $@.tmp > $@
+	rm $@.tmp
 
 endif
Index: 25.1/drivers/tc/lk201-map.c_shipped
--- 25.1/drivers/tc/lk201-map.c_shipped Sat, 06 Jul 2002 13:37:55 +1000 kaos (linux-2.5/d/f/24_lk201-map. 1.1 644)
+++ 25.1(w)/drivers/tc/lk201-map.c_shipped Sat, 06 Jul 2002 14:30:43 +1000 kaos (linux-2.5/d/f/24_lk201-map. 1.1 644)
@@ -25,7 +25,7 @@ u_short plain_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short shift_map[NR_KEYS] = {
+u_short shift_map[NR_KEYS] = {
 	0xf200,	0xf100,	0xf101,	0xf102,	0xf103,	0xf104,	0xf105,	0xf106,
 	0xf107,	0xf108,	0xf109,	0xf10a,	0xf10b,	0xf10c,	0xf10d,	0xf203,
 	0xf11c,	0xf110,	0xf111,	0xf112,	0xf113,	0xf07e,	0xf021,	0xf040,
@@ -44,7 +44,7 @@ static u_short shift_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short altgr_map[NR_KEYS] = {
+u_short altgr_map[NR_KEYS] = {
 	0xf200,	0xf100,	0xf101,	0xf102,	0xf103,	0xf104,	0xf105,	0xf106,
 	0xf107,	0xf108,	0xf109,	0xf10a,	0xf10b,	0xf10c,	0xf10d,	0xf202,
 	0xf11c,	0xf110,	0xf111,	0xf112,	0xf113,	0xf200,	0xf200,	0xf040,
@@ -63,7 +63,7 @@ static u_short altgr_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short ctrl_map[NR_KEYS] = {
+u_short ctrl_map[NR_KEYS] = {
 	0xf200,	0xf100,	0xf101,	0xf102,	0xf103,	0xf104,	0xf105,	0xf106,
 	0xf107,	0xf108,	0xf109,	0xf10a,	0xf10b,	0xf10c,	0xf10d,	0xf204,
 	0xf11c,	0xf110,	0xf111,	0xf112,	0xf113,	0xf81b,	0xf200,	0xf000,
@@ -82,7 +82,7 @@ static u_short ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short shift_ctrl_map[NR_KEYS] = {
+u_short shift_ctrl_map[NR_KEYS] = {
 	0xf200,	0xf100,	0xf101,	0xf102,	0xf103,	0xf104,	0xf105,	0xf106,
 	0xf107,	0xf108,	0xf109,	0xf10a,	0xf10b,	0xf10c,	0xf10d,	0xf200,
 	0xf11c,	0xf110,	0xf111,	0xf112,	0xf113,	0xf200,	0xf200,	0xf000,
@@ -101,7 +101,7 @@ static u_short shift_ctrl_map[NR_KEYS] =
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short alt_map[NR_KEYS] = {
+u_short alt_map[NR_KEYS] = {
 	0xf200,	0xf500,	0xf501,	0xf502,	0xf503,	0xf504,	0xf505,	0xf506,
 	0xf507,	0xf508,	0xf509,	0xf50a,	0xf50b,	0xf50c,	0xf50d,	0xf200,
 	0xf11c,	0xf510,	0xf511,	0xf512,	0xf513,	0xf01b,	0xf831,	0xf832,
@@ -120,7 +120,7 @@ static u_short alt_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-static u_short ctrl_alt_map[NR_KEYS] = {
+u_short ctrl_alt_map[NR_KEYS] = {
 	0xf200,	0xf500,	0xf501,	0xf502,	0xf503,	0xf504,	0xf505,	0xf506,
 	0xf507,	0xf508,	0xf509,	0xf50a,	0xf50b,	0xf50c,	0xf50d,	0xf200,
 	0xf11c,	0xf510,	0xf511,	0xf512,	0xf513,	0xf200,	0xf200,	0xf200,

