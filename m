Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVB1BQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVB1BQO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVB1BQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:16:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:38016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbVB1BQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:16:10 -0500
Date: Sun, 27 Feb 2005 17:05:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/oss/opl3as2: fix init section reference
Message-Id: <20050227170507.58223ad7.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sound/oss/opl3sa2:  calls __init function during probe, which may
be after init for PNP devices;

Error: ./sound/oss/opl3sa2.o .text refers to 0000000000000204 R_X86_64_PC32     .init.text+0xfffffffffffffffc                                                   Error: ./sound/oss/opl3sa2.o .text refers to 0000000000000210 R_X86_64_PC32     .init.text+0xfffffffffffffffc                                                   Error: ./sound/oss/opl3sa2.o .text refers to 000000000000021c R_X86_64_PC32     .init.text+0xfffffffffffffffc

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/opl3sa2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/opl3sa2.c~sound_opl_sections ./sound/oss/opl3sa2.c
--- ./sound/oss/opl3sa2.c~sound_opl_sections	2005-02-27 12:54:07.373802456 -0800
+++ ./sound/oss/opl3sa2.c	2005-02-27 17:08:18.164329888 -0800
@@ -711,7 +711,7 @@ static void __init attach_opl3sa2_mixer(
 }
 
 
-static void __init opl3sa2_clear_slots(struct address_info* hw_config)
+static void opl3sa2_clear_slots(struct address_info* hw_config)
 {
 	int i;
 


---
