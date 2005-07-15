Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVGOUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVGOUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVGOUJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:09:59 -0400
Received: from peabody.ximian.com ([130.57.169.10]:50320 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261164AbVGOUJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:09:55 -0400
Subject: Re: [patch] inotify: add x86-64 syscall numbers
From: Robert Love <rml@novell.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73wtnrbzzr.fsf@bragg.suse.de>
References: <1121457125.830.22.camel@betsy.suse.lists.linux.kernel>
	 <p73wtnrbzzr.fsf@bragg.suse.de>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 16:09:53 -0400
Message-Id: <1121458193.830.27.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 22:01 +0200, Andi Kleen wrote:

> It won't work anyways because you forgot to patch the compat 
> sys32_open.

Well, "won't work" is a bit harsh, its just one hook.  But that was
next.

I usually leave per-arch stuff to the arch folks.

	Robert Love


Add fsnotify_open() hook to sys32_open() on x86-64.

Signed-off-by: Robert Love <rml@novell.com>

 arch/x86_64/ia32/sys_ia32.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urN linux-2.6.13-rc3/arch/x86_64/ia32/sys_ia32.c linux/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6.13-rc3/arch/x86_64/ia32/sys_ia32.c	2005-07-15 16:08:27.000000000 -0400
+++ linux/arch/x86_64/ia32/sys_ia32.c	2005-07-15 16:07:21.000000000 -0400
@@ -61,6 +61,7 @@
 #include <linux/ptrace.h>
 #include <linux/highuid.h>
 #include <linux/vmalloc.h>
+#include <linux/fsnotify.>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -984,8 +985,10 @@
 			if (IS_ERR(f)) {
 				put_unused_fd(fd); 
 				fd = error;
-			} else
+			} else {
+				fsnotify_open(f->f_dentry);
 				fd_install(fd, f);
+			}
 		}
 		putname(tmp);
 	}


