Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTINTaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTINTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:30:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:50365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbTINTaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:30:11 -0400
Date: Sun, 14 Sep 2003 12:30:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-Id: <20030914123024.4a261cd3.akpm@osdl.org>
In-Reply-To: <3F644E36.5010402@colorfullife.com>
References: <3F644E36.5010402@colorfullife.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> I noticed that gcc's autodetection (3.2.2) guesses 
>  the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
>  into the direct path and the copy out of line.
> 
>  The attached patch adds likely to the tests

Fair enough.  There are quite a few other access_ok() callers.   How
about just:

--- 25/include/asm-i386/uaccess.h~access_ok-is-likely	2003-09-14 12:29:10.000000000 -0700
+++ 25-akpm/include/asm-i386/uaccess.h	2003-09-14 12:29:24.000000000 -0700
@@ -80,7 +80,7 @@ extern struct movsl_mask {
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
+#define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))
 
 /**
  * verify_area: - Obsolete, use access_ok()

_

