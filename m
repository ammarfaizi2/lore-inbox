Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUIJJbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUIJJbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIJJbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:31:04 -0400
Received: from checkpoint-out.gate.uni-erlangen.de ([131.188.28.69]:40902 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267324AbUIJJa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:30:59 -0400
Date: Fri, 10 Sep 2004 10:57:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: another simplifycation
Message-ID: <20040910085739.GD12751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

verify is not really descriptive name of function. Fortunately its
insides are self-documenting which makes it easy to fix. Please apply,


								Pavel

--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -1130,17 +1108,6 @@
 	return error;
 }
 
-
-int __init verify(void)
-{
-	int error;
-
-	if (!(error = check_sig()))
-		error = check_header();
-	return error;
-}
-
-
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
@@ -1202,13 +1171,14 @@
 {
 	int error = 0;
 
-	if ((error = verify()))
+	if ((error = check_sig()))
+		return error;
+	if ((error = check_header()))
 		return error;
 	if ((error = read_pagedir()))
 		return error;
-	if ((error = data_read())) {
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
-	}
+	if ((error = data_read()))
+		free_pages((unsigned long)pagedir_nosave, pagedir_order);
 	return error;
 }
 
