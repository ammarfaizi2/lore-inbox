Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269143AbUINCnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269143AbUINCnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUINClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:41:37 -0400
Received: from holomorphy.com ([207.189.100.168]:13456 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269143AbUINCih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:38:37 -0400
Date: Mon, 13 Sep 2004 19:38:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>
Subject: Re: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines
Message-ID: <20040914023830.GS9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com> <20040914022827.GP9106@holomorphy.com> <20040914023114.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914023114.GQ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:31:14PM -0700, William Lee Irwin III wrote:
> /proc/ breaks when PID_MAX_LIMIT is elevated on 32-bit, so this patch
> lowers it there. Compiletested on x86-64.
[...]
> -#define PID_MAX_LIMIT (4*1024*1024)
> +#define PID_MAX_LIMIT (sizeof(long) > 32 ? 4*1024*1024 : PID_MAX_DEFAULT)

Index: mm5-2.6.9-rc1/include/linux/threads.h
===================================================================
--- mm5-2.6.9-rc1.orig/include/linux/threads.h	2004-08-13 22:36:12.000000000 -0700
+++ mm5-2.6.9-rc1/include/linux/threads.h	2004-09-13 19:30:47.552374432 -0700
@@ -30,6 +30,6 @@
 /*
  * A maximum of 4 million PIDs should be enough for a while:
  */
-#define PID_MAX_LIMIT (4*1024*1024)
+#define PID_MAX_LIMIT (sizeof(long) > 4 ? 4*1024*1024 : PID_MAX_DEFAULT)
 
 #endif
