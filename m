Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVALHGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVALHGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVALHGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:06:44 -0500
Received: from news.suse.de ([195.135.220.2]:50614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263016AbVALHFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:05:19 -0500
Date: Wed, 12 Jan 2005 08:05:18 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, vandrove@vc.cvut.cz
Subject: [PATCH] [4/4] Fix numa=off
Message-ID: <20050112070518.GE532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix numa=off at end of command line

Fix a long standing bug: numa=off only worked as last argument on
the command line.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c	2005-01-09 18:20:08.%N +0100
+++ linux/arch/x86_64/mm/numa.c	2005-01-12 06:47:00.%N +0100
@@ -265,7 +265,7 @@
 /* [numa=off] */
 __init int numa_setup(char *opt) 
 { 
-	if (!strcmp(opt,"off"))
+	if (!strncmp(opt,"off",3))
 		numa_off = 1;
 #ifdef CONFIG_NUMA_EMU
 	if(!strncmp(opt, "fake=", 5)) {
