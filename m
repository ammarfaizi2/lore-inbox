Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUILKcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUILKcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268634AbUILKcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:32:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20886 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268633AbUILKcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:32:31 -0400
Date: Sun, 12 Sep 2004 03:32:10 -0700
From: Paul Jackson <pj@sgi.com>
To: rth@twiddle.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4 alpha build broken - ignoring return value of
 `set_fd_set'
Message-Id: <20040912033210.37661ccc.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to include/linux/poll.h marked set_fd_set()
as __must_check.  Three unchecked uses of this inline remain in
arch/alpha/kernel/osf_sys.c, causing the alpha build of 2.6.9-rc1-mm4,
to fail with:

include/linux/poll.h: In function `osf_select':
arch/alpha/kernel/osf_sys.c:1056: warning: ignoring return value of `set_fd_set', declared with attribute warn_unused_result
arch/alpha/kernel/osf_sys.c:1057: warning: ignoring return value of `set_fd_set', declared with attribute warn_unused_result
arch/alpha/kernel/osf_sys.c:1058: warning: ignoring return value of `set_fd_set', declared with attribute warn_unused_result
make[1]: *** [arch/alpha/kernel/osf_sys.o] Error 1


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
