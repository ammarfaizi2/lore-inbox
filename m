Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290417AbSAPL1q>; Wed, 16 Jan 2002 06:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290418AbSAPL1g>; Wed, 16 Jan 2002 06:27:36 -0500
Received: from ns.suse.de ([213.95.15.193]:13839 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290417AbSAPL1b>;
	Wed, 16 Jan 2002 06:27:31 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, bcrl@redhat.com
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020115192048.G17477@redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Jan 2002 12:27:28 +0100
In-Reply-To: Linus Torvalds's message of "16 Jan 2002 01:33:44 +0100"
Message-ID: <p73pu4aa63j.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > +#ifndef __ASM__ATOMIC_H
> > +#include <asm/atomic.h>
> > +#endif
> 
> Please do not assume knowdledge of what the different header files use to
> define their re-entrancy.
> 
> Just do
> 
> 	#include <asm/atomic.h>
> 
> and be done with it.

The first check is done automatically by the gcc preprocessor 
anyways (it has a special check for the #ifndef BLA_H #define BLA_H #endif
construct for whole files and doesn't even bother to open them again on a 
second include). So it's completely unnecessary. 

Someone added some of these useless checks to 2.5.3pre1. Here is a patch
to remove them. Please consider applying.

--- linux-2.5.3pre1/include/linux/file.h-o	Wed Jan 16 12:24:09 2002
+++ linux-2.5.3pre1/include/linux/file.h	Wed Jan 16 12:25:10 2002
@@ -5,12 +5,8 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H
 
-#ifndef _LINUX_POSIX_TYPES_H	/* __FD_CLR */
 #include <linux/posix_types.h>
-#endif
-#ifndef __LINUX_COMPILER_H	/* unlikely */
 #include <linux/compiler.h>
-#endif
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
--- linux-2.5.3pre1/include/linux/init_task.h-o	Wed Jan 16 12:24:09 2002
+++ linux-2.5.3pre1/include/linux/init_task.h	Wed Jan 16 12:25:27 2002
@@ -1,9 +1,7 @@
 #ifndef _LINUX__INIT_TASK_H
 #define _LINUX__INIT_TASK_H
 
-#ifndef __LINUX_FILE_H
 #include <linux/file.h>
-#endif
 
 #define INIT_FILES \
 { 							\


-Andi
