Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUILKRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUILKRG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUILKNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:13:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8073 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268592AbUILKM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:12:59 -0400
Date: Sun, 12 Sep 2004 03:12:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
 atomic_sub_and_test
Message-Id: <20040912031235.48c738ae.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The default config for sparc on 2.6.9-rc1-mm4 doesn't build, using the
crosstools from http://developer.osdl.org/dev/plm/cross_compile.

Hans,

  Andrew counts on us to build for various arch's, especially when
  submitting something non-trivial.  The above crosstools work
  pretty good - give them a try.

The final link fails with:

  fs/built-in.o(.text+0x58618): In function `end_io_handler':
  : undefined reference to `atomic_sub_and_test'
  make[1]: *** [arch/sparc/boot/image] Error 1

The macro 'atomic_sub_and_test' is defined for more or less every other
arch, in various include/asm-*/atomic.h files, but not defined for
sparc.

This macro is used in:

	fs/reiser4/flush_queue.c:
               if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))

If I disable the config items:

  CONFIG_REISER4_FS=y
  CONFIG_REISER4_LARGE_KEY=y

then it builds ok (with the bogus #else removed from cachefs.h, as
already reported on lkml).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
