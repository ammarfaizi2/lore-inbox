Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289787AbSAPAVH>; Tue, 15 Jan 2002 19:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSAPAU5>; Tue, 15 Jan 2002 19:20:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:40970 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289787AbSAPAUt>; Tue, 15 Jan 2002 19:20:49 -0500
Date: Tue, 15 Jan 2002 19:20:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Weber <weber@nyc.rr.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020115192048.G17477@redhat.com>
In-Reply-To: <3C44C3B6.8060900@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C44C3B6.8060900@nyc.rr.com>; from weber@nyc.rr.com on Tue, Jan 15, 2002 at 07:05:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 07:05:10PM -0500, John Weber wrote:
> incompatible pointer type
> read_write.c: In function `sys_pwrite':
> read_write.c:403: warning: passing arg 1 of `inode_dir_notify' from 
> incompatible pointer type

Hmm, this should fix that.

		-ben

:r ~/patches/v2.5.3-pre1-file_fix.diff
diff -urN v2.5.3-pre1/include/linux/file.h v2.5.3-pre1-fix/include/linux/file.h
--- v2.5.3-pre1/include/linux/file.h	Tue Jan 15 19:11:11 2002
+++ v2.5.3-pre1-fix/include/linux/file.h	Tue Jan 15 19:20:06 2002
@@ -5,6 +5,9 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H
 
+#ifndef __ASM__ATOMIC_H
+#include <asm/atomic.h>
+#endif
 #ifndef _LINUX_POSIX_TYPES_H	/* __FD_CLR */
 #include <linux/posix_types.h>
 #endif
