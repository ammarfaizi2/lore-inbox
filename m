Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVCWIof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVCWIof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVCWIof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:44:35 -0500
Received: from koto.vergenet.net ([210.128.90.7]:50891 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262878AbVCWIod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:44:33 -0500
Date: Wed, 23 Mar 2005 16:49:35 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Fix sign checks in copy_from_read_buf() in 2.4
Message-ID: <20050323074931.GA3092@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applologies if this is already pending, but the signdness fix for
copy_from_read_buf() in  2.6 seems to be needed for 2.4 as well.

This relates to the bugs reported in this document
http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html

-- 
Horms

Backport of copy_from_read_buf() signedness fix from 2.6

Signed-off-by: Simon Horman <horms@verge.net.au>

===== drivers/char/n_tty.c 1.7 vs edited =====
--- 1.7/drivers/char/n_tty.c	2004-12-16 22:57:23 +09:00
+++ edited/drivers/char/n_tty.c	2005-03-23 13:08:37 +09:00
@@ -1095,7 +1095,7 @@
 
 {
 	int retval;
-	ssize_t n;
+	size_t n;
 	unsigned long flags;
 
 	retval = 0;
