Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbTJLCOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 22:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJLCOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 22:14:41 -0400
Received: from holomorphy.com ([66.224.33.161]:29569 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263392AbTJLCOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 22:14:40 -0400
Date: Sat, 11 Oct 2003 19:17:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: current_is_kswapd is a function
Message-ID: <20031012021750.GA772@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current_is_kswapd() is a function, not an integer; this explains some
anomalies in reported statistics.

===== fs/inode.c 1.107 vs edited =====
--- 1.107/fs/inode.c	Sun Oct  5 01:07:55 2003
+++ edited/fs/inode.c	Sat Oct 11 19:15:48 2003
@@ -453,7 +453,7 @@
 	dispose_list(&freeable);
 	up(&iprune_sem);
 
-	if (current_is_kswapd)
+	if (current_is_kswapd())
 		mod_page_state(kswapd_inodesteal, reap);
 	else
 		mod_page_state(pginodesteal, reap);
