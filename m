Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTJJAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJJAm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:42:26 -0400
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200]:30931 "EHLO
	fep01-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S262686AbTJJAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:42:25 -0400
Date: Fri, 10 Oct 2003 01:42:24 +0100
From: Nuno Monteiro <nmonteiro@uk2.net>
To: linux-kernel@vger.kernel.org
Cc: davej@redhat.com, torvalds@osdl.org
Subject: [PATCH] Re: linking problem with 2.6.0-test6-bk10
Message-ID: <20031010004224.GH4683@hobbes.itsari.int>
References: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com> <20031008200420.GA23545@redhat.com> <57145.212.113.164.100.1065647937.squirrel@maxproxy3.uk2net.com> <20031009234000.GC4683@hobbes.itsari.int> <20031010004047.GE4683@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031010004047.GE4683@hobbes.itsari.int> (from nmonteiro@uk2.net on Fri, Oct 10, 2003 at 01:40:47 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.10.08 22:18, Nuno Monteiro wrote:
> > On Wed, Oct 08, 2003 at 07:32:42PM +0100, Nuno Monteiro wrote:
> >
> > Try this.
> >
> > 		Dave
> 
> 
> Hi Dave,
> 
> Thanks for the input, but still no joy. 


Hi,


Got 5 minutes to look at this today, here is the proper fix. This allows 
to compile for Winchip when CONFIG_MTRR is off. The alternative would be
to pull in asm/mtrr.h and asm/errno.h, but it seems a bit overkill since
we only need mtrr_centaur_report_mcr.

Booted and working fine here on my small gateway box for the past hour.
Please apply.

Regards,

Nuno



--- linux-2.6.0-test7/arch/i386/kernel/cpu/centaur.c	2003-10-10 00:30:58.000000000 +0100
+++ linux-2.6.0-test7-fixed/arch/i386/kernel/cpu/centaur.c	2003-10-10 00:30:05.000000000 +0100
@@ -8,6 +8,10 @@
 
 #ifdef CONFIG_X86_OOSTORE
 
+#ifndef CONFIG_MTRR
+static __inline__ void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi) {;}
+#endif
+
 static u32 __init power2(u32 x)
 {
 	u32 s=1;


