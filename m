Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935088AbWKXVqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935088AbWKXVqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935089AbWKXVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:46:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935088AbWKXVqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:46:34 -0500
Date: Fri, 24 Nov 2006 13:46:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
Subject: Re: + uml-make-execvp-safe-for-our-usage.patch added to -mm tree
Message-Id: <20061124134621.be9835e7.akpm@osdl.org>
In-Reply-To: <20061124195011.GB4745@ccure.user-mode-linux.org>
References: <200610180014.k9I0EZ1J012332@shell0.pdx.osdl.net>
	<20061124195011.GB4745@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 14:50:11 -0500
Jeff Dike <jdike@addtoit.com> wrote:

> On Tue, Oct 17, 2006 at 05:14:35PM -0700, akpm@osdl.org wrote:
> > The patch titled
> > 
> >      uml: make execvp safe for our usage
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      uml-make-execvp-safe-for-our-usage.patch
> > 
> 
> I had previously objected to this patch on grounds of taste.  Since
> this fixes a number of problems, and I don't have any solutions which
> are huge improvements, I withdraw those objections.
> 
> Feel free to send to Linus.

OK.  Is it needed for 2.6.19?

Also, I'm still sitting on the below.  I have a note that you nacked it,
but I forget why.


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix prototypes in user.h - was needed when including user.h in kernelspace, as
we did in previous patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/um/include/user.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/um/include/user.h~uml-fix-prototypes arch/um/include/user.h
--- a/arch/um/include/user.h~uml-fix-prototypes
+++ a/arch/um/include/user.h
@@ -6,6 +6,10 @@
 #ifndef __USER_H__
 #define __USER_H__
 
+/* Both on kernelspace and userspace this will provide the size_t definition. It should, at
+ * least. But on userspace it won't hurt surely. */
+#include <linux/types.h>
+
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern int printk(const char *fmt, ...)
@@ -13,9 +17,8 @@ extern int printk(const char *fmt, ...)
 extern void schedule(void);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-/* These use size_t, however unsigned long is correct on both i386 and x86_64. */
-extern unsigned long strlcpy(char *, const char *, unsigned long);
-extern unsigned long strlcat(char *, const char *, unsigned long);
+extern size_t strlcpy(char *, const char *, size_t);
+extern size_t strlcat(char *, const char *, size_t);
 
 #endif
 
_

