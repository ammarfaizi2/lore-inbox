Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTJGUs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJGUs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:48:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:59053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262873AbTJGUsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:48:53 -0400
Date: Tue, 7 Oct 2003 13:40:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>
Subject: [PATCH] fix mm/memory for SWAP=n
Message-Id: <20031007134014.2aad9691.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply to 2.6.0-test6-current.

--
~Randy


patch_name:	memory_noswap.patch
patch_version:	2003-10-07.13:49:54
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix compile warning when CONFIG_SWAP=n
product:	Linux
product_versions: 2.6.0-test6-2003.10.07
diffstat:	=
 include/linux/swap.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Naurp ./include/linux/swap.h~noswap ./include/linux/swap.h
--- ./include/linux/swap.h~noswap	2003-10-07 13:12:15.000000000 -0700
+++ ./include/linux/swap.h	2003-10-07 13:40:52.000000000 -0700
@@ -261,12 +261,16 @@ extern spinlock_t swaplock;
 #define lookup_swap_cache(swp)			NULL
 #define valid_swaphandles(swp, off)		0
 #define can_share_swap_page(p)			0
-#define remove_exclusive_swap_page(p)		0
 #define move_to_swap_cache(p, swp)		1
 #define move_from_swap_cache(p, i, m)		1
 #define __delete_from_swap_cache(p)		/*NOTHING*/
 #define delete_from_swap_cache(p)		/*NOTHING*/
 
+static inline int remove_exclusive_swap_page(struct page *p)
+{
+	return 0;
+}
+
 static inline swp_entry_t get_swap_page(void)
 {
 	swp_entry_t entry;
