Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUBBGmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBBGmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:42:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:63428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265639AbUBBGma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:42:30 -0500
Date: Sun, 1 Feb 2004 22:43:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add syscalls.h
Message-Id: <20040201224344.43d1c37d.akpm@osdl.org>
In-Reply-To: <20040201222254.39bc5b39.rddunlap@osdl.org>
References: <20040130163547.2285457b.rddunlap@osdl.org>
	<20040201222254.39bc5b39.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> | Date: Tue, 27 Jan 2004 16:46:15 -0800
>  | From: Andrew Morton <akpm@osdl.org>
>  | Subject: Re: NGROUPS 2.6.2rc2
>  | 
>  | 
>  [snip]
>  | rant.  We have soooo many syscalls declared in .c files.  We had a bug due
>  | to this a while back.  Problem is, we have no anointed header in which to
>  | place them.  include/linux/syscalls.h would suit.  And unistd.h for
>  | arch-specific syscalls.  But that's not appropriate to this patch.
> 
> 
>  I am working on this.  Is anyone else?
> 
>  I have parts 2.6.1-non-arch* ready for testing, I believe,
>  except that it will likely require more changes/additions.
> 
>  I have begun on 2.6.1-arch* but still have a ways to go.
> 
>  Caveats:
>  I have only patched 2.6.1.  I will update patches for 2.6.2-rc-current.
>  I have only tested by building allmodconfig on P4.
>  Have not test-booted yet.
> 
>  Patch files for 2.6.1 are here:

Looks sane to me.

+ * syscalls.h - Linux syscall interfaces (non-arch-specific)
...
+#include <linux/aio_abi.h>
+#include <linux/sched.h>
+#include <linux/socket.h>
+#include <linux/sysctl.h>
+#include <linux/time.h>
+#include <linux/posix-timers.h>
+#include <linux/uio.h>
+
+#include <asm/signal.h>
+#include <asm/stat.h>

I'd be inclined to lose the includes and just add forward decls for
structs.  Of course, you'll need the includes for typedefs.  

+extern asmlinkage long sys_unlink(const char __user *pathname);
+extern asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
+extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);

Maybe lose the `extern' too.  It's just a waste of space.  I normally put
it in for consistency if the surrounding code is done that way, but for a
new header file, why bother?

