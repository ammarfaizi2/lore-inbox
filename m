Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUKFMvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUKFMvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUKFMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:51:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:30138 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261379AbUKFMuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:50:54 -0500
Date: Sat, 6 Nov 2004 13:50:49 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Ricky Beam <jfbeam@bluetronic.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       arjanv@redhat.com
Subject: Re: breakage: flex mmap patch for x86-64
Message-ID: <20041106125049.GB16434@wotan.suse.de>
References: <200411060026.48571.rjw@sisk.pl> <Pine.GSO.4.33.0411060252370.9358-100000@sweetums.bluetronic.net> <20041106091240.GA4996@wotan.suse.de> <200411061050.27304.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411061050.27304.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 10:50:27AM +0100, Rafael J. Wysocki wrote:
> On Saturday 06 of November 2004 10:12, Andi Kleen wrote:
> > >  static inline int mmap_is_legacy(void)
> > >  {
> > > +       if (test_thread_flag(TIF_IA32))
> > > +               return 1;
> > 
> > That's definitely not the right fix because for 32bit you need flexmmap
> > more than for 64bit because it gives you more address space.
> 
> So let's call it temporary, but I like 32-bit apps having less address space 
> rather than segfaulting.

If you want a temporary fix use the appended one.  But I think Linus pulled it anyways.

-Andi


diff -u linux-2.6.10rc1-mm3/kernel/sysctl.c-o linux-2.6.10rc1-mm3/kernel/sysctl.c
--- linux-2.6.10rc1-mm3/kernel/sysctl.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/kernel/sysctl.c	2004-11-06 13:50:22.000000000 +0100
@@ -147,7 +147,7 @@
 #endif
 
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
-int sysctl_legacy_va_layout;
+int sysctl_legacy_va_layout = 1;
 #endif
 
 /* /proc declarations: */
