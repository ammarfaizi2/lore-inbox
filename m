Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265124AbSJWS3Y>; Wed, 23 Oct 2002 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbSJWS3Y>; Wed, 23 Oct 2002 14:29:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265124AbSJWS3X>;
	Wed, 23 Oct 2002 14:29:23 -0400
Subject: Re: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
From: Stephen Hemminger <shemminger@osdl.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0210230244560.27315-100000@nakedeye.aparity.com>
References: <Pine.LNX.4.44.0210230244560.27315-100000@nakedeye.aparity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 11:35:27 -0700
Message-Id: <1035398127.9615.21.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dump_page_buf is declared with different scope in
dump_base.c and dump_block_dev.c. This causes a link error, but maybe if
LKCD is built as a module, then the symbol export masks the problem.

diff -Nru a/drivers/dump/dump_base.c b/drivers/dump/dump_base.c
--- a/drivers/dump/dump_base.c	Wed Oct 23 11:34:14 2002
+++ b/drivers/dump/dump_base.c	Wed Oct 23 11:34:14 2002
@@ -200,7 +200,7 @@
 static long dump_nondisruptive_enabled = 1;/* Default:non-disruptive enabled*/
 
 /* Other global fields */
-static void *dump_page_buf;        /* dump page buffer for memcpy()!       */
+void *dump_page_buf;        	   /* dump page buffer for memcpy()!       */
 static void *dump_page_buf_0;      /* dump page buffer returned by kmalloc */
 struct __dump_header dump_header;  /* the primary dump header              */
 struct __dump_header_asm dump_header_asm; /* the arch-specific dump header */


