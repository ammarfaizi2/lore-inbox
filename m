Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTEZWAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTEZWAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:00:17 -0400
Received: from pointblue.com.pl ([62.89.73.6]:3859 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262262AbTEZWAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:00:16 -0400
Subject: Re: xfs don't compil in linux-2.5 BK
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030526193136.GB10276@magma.unil.ch>
References: <20030526193136.GB10276@magma.unil.ch>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053986469.3754.6.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 23:01:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 20:31, Gregoire Favre wrote:
> Hello,
> 
> I don't know if I have fetched the source with BK the right way...
> Anyway the compil ends that way:
> 
>   CC      fs/xfs/xfs_rw.o
>   CC      fs/xfs/pagebuf/page_buf.o
> In file included from fs/xfs/pagebuf/page_buf.c:65:
> fs/xfs/pagebuf/page_buf_internal.h:46:24: operator '<' has no left
> operand
> make[2]: *** [fs/xfs/pagebuf/page_buf.o] Error 1
> make[1]: *** [fs/xfs] Error 2
> make: *** [fs] Error 2
> 141.112u 14.914s 3:19.78 78.0%  0+0k 0+0io 492771pf+0w
> Exit 2

looks like LINUX_VERSION_CODE is not defined
try this (as 2.5.69 > than 2.5.9)

diff -ur 2/fs/xfs/pagebuf/page_buf_internal.h
1/fs/xfs/pagebuf/page_buf_internal.h
--- 2/fs/xfs/pagebuf/page_buf_internal.h        2003-05-05
00:53:14.000000000 +0100
+++ 1/fs/xfs/pagebuf/page_buf_internal.h        2003-05-26
22:59:27.000000000 +0100
@@ -43,11 +43,6 @@
 #define PB_DEFINE_TRACES
 #include "page_buf_trace.h"

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,9)
-#define page_buffers(page)     ((page)->buffers)
-#define page_has_buffers(page) ((page)->buffers)
-#endif
-
 #ifdef PAGEBUF_LOCK_TRACKING
 #define PB_SET_OWNER(pb)       (pb->pb_last_holder = current->pid)
 #define PB_CLEAR_OWNER(pb)     (pb->pb_last_holder = -1)




-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

