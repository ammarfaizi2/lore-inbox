Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbTJBOko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTJBOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:40:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34618 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263363AbTJBOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:40:40 -0400
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Oct 2003 08:39:50 -0600
In-Reply-To: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
Message-ID: <m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:

> Hi Linus,
> 
> Something we have talked about for a long time is
> separating out from the kernel headers the parts
> fit for inclusion in user space.
> 
> This is a very large project, and it will take a long
> time, especially if we want the user space headers to
> be a pleasure to look at, instead of just a cut-n-paste
> copy of whatever we find in the current headers.
> 
> Some start is required, and the very first step is
> making sure that you agree with the project.
> Immediately following is the choice of directory names.

This is a 2.7 project.  Doing this right requires a lot more
than what you are doing here.

One example is that we need to be very careful with is that the
glibc abi is not the same as the linux kernel abi.  Even though most
of the functions are pass through some are not.  And which are which
is a fairly arbitrary decision.  So all of the definitions exported
through linuxabi need to be in a linux centric namespace.  This is
especially true because otherwise I could not include
linuxabi/mountflags.h and sys/mount.h and not get compilation 
conflicts.

I believe linuxabi/mountflags.h should look more like:
--- a/include/linuxabi/mountflags.h	Thu Jan  1 01:00:00 1970
+++ b/include/linuxabi/mountflags.h	Wed Oct  1 00:40:50 2003
@@ -0,0 +1,32 @@
+#ifndef _LINUXABI_MOUNTFLAGS_H
+#define _LINUXABI_MOUNTFLAGS_H
+
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ */
+#define LINUX_MS_RDONLY	 1	/* Mount read-only */
+#define LINUX_MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define LINUX_MS_NODEV	 4	/* Disallow access to device special files */
+#define LINUX_MS_NOEXEC	 8	/* Disallow program execution */
+#define LINUX_MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define LINUX_MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define LINUX_MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define LINUX_MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define LINUX_MS_NOATIME	1024	/* Do not update access times. */
+#define LINUX_MS_NODIRATIME	2048	/* Do not update directory access times */
+#define LINUX_MS_BIND		4096
+#define LINUX_MS_MOVE		8192
+#define LINUX_MS_REC		16384
+#define LINUX_MS_VERBOSE	32768
+#define LINUX_MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define LINUX_MS_ONE_SECOND	(1<<17)	/* fs has 1 sec a/m/ctime resolution */
+#define LINUX_MS_ACTIVE	(1<<30)
+#define LINUX_MS_NOUSER	(1<<31)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define LINUX_MS_MGC_VAL 0xC0ED0000
+#define LINUX_MS_MGC_MSK 0xffff0000
+
+#endif /* _LINUXABI_MOUNTFLAGS_H */


Eric
