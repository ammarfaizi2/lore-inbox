Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUINCeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUINCeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUINCdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:33:04 -0400
Received: from holomorphy.com ([207.189.100.168]:10896 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269142AbUINCbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:31:17 -0400
Date: Mon, 13 Sep 2004 19:31:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>
Subject: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914023114.GQ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914022827.GP9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:28:27PM -0700, William Lee Irwin III wrote:
> I was informed that the vendor component of the copyright can't be
> clobbered without more care, so this patch retains the older vendor,
> updating it only to reflect the appropriate time period.

/proc/ breaks when PID_MAX_LIMIT is elevated on 32-bit, so this patch
lowers it there. Compiletested on x86-64.


Index: mm5-2.6.9-rc1/include/linux/threads.h
===================================================================
--- mm5-2.6.9-rc1.orig/include/linux/threads.h	2004-08-13 22:36:12.000000000 -0700
+++ mm5-2.6.9-rc1/include/linux/threads.h	2004-09-13 16:28:38.791798576 -0700
@@ -30,6 +30,6 @@
 /*
  * A maximum of 4 million PIDs should be enough for a while:
  */
-#define PID_MAX_LIMIT (4*1024*1024)
+#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)
 
 #endif
