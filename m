Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVBMGMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVBMGMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 01:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVBMGMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 01:12:48 -0500
Received: from [220.248.27.114] ([220.248.27.114]:14528 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261163AbVBMGMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 01:12:44 -0500
Date: Sun, 13 Feb 2005 14:11:36 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Message-ID: <20050213061136.GA3820@hugang.soulinfo.com>
References: <200501310019.39526.rjw@sisk.pl> <200502081929.19503.rjw@sisk.pl> <20050208224202.GD1347@elf.ucw.cz> <200502090022.52629.rjw@sisk.pl> <19031231170827.GA3610@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19031231170827.GA3610@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 01:04:56PM +0706, hugang@soulinfo.com wrote:
> On Wed, Feb 09, 2005 at 12:22:52AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, 8 of February 2005 23:42, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > +static inline void eat_page(void *page) {
> > > 
> > > Please put { on new line.
> > 
> > Oh, I still tend to forget about this.  Corrected in the patch that is
> > available on the web
> > (http://www.sisk.pl/kernel/patches/2.6.11-rc3-mm1/swsusp-use-list-resume-v4.patch).
> > 
> > 
> > > Okay, as you can see, I could find very little wrong with this
> > > patch. That hopefully means it is okay ;-). I should still check error
> > > handling, but I guess I'll do it when it is applied because it is hard
> > > to do on a diff. I guess it should go into -mm just after 2.6.11 is
> > > released...
> > 
> > That would be great!
> > 
> > Greets,
> > Rafael
> 
> Here is powerpc port support for that.  Thanks for greate patch.
> 

Sorry I forgot this one. 

--- 2.6.11-rc3-mm2-use-list-resume-v4/arch/ppc/kernel/asm-offsets.c	2004-12-30 14:55:39.000000000 +0800
+++ 2.6.11-rc3-mm2-use-list-resume-v4-ppc/arch/ppc/kernel/asm-offsets.c	2005-02-13 12:30:59.000000000 +0800
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/suspend.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <asm/io.h>
@@ -136,6 +137,10 @@ main(void)
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 
+	DEFINE(pbe_address, offsetof(struct pbe, address));
+	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
+	DEFINE(pbe_next, offsetof(struct pbe, next));
+
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 	return 0;
 }

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
