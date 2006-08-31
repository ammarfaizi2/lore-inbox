Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHaVe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHaVe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHaVe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:34:56 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:62655 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S932134AbWHaVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:34:56 -0400
Subject: Re: [PATCH 7/8] Implement smp_processor_id() with the PDA.
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44F73429.9060101@goop.org>
References: <20060830235201.106319215@goop.org>
	 <20060831000515.338336117@goop.org>
	 <1157027758.12949.327.camel@localhost.localdomain>
	 <44F73429.9060101@goop.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 22:34:51 +0100
Message-Id: <1157060091.25220.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 21:36:57.0640 (UTC) FILETIME=[95CE4A80:01C6CD45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 12:10 -0700, Jeremy Fitzhardinge wrote:
> Ian Campbell wrote:
> > smp_processor_id() is defined for !SMP in include/linux/smp.h, I don't
> > know if it would be appropriate to add early_smp_processor_id() there
> > since it seems i386 specific. asm/smp.h isn't included by linux/smp.h
> > when !SMP but you could add an explicit include to common.c I suppose.
> >   
> The simple solution is to just define a !SMP version of 
> early_smp_processor_id().  It's i386 specific, but that's the only arch 
> that uses it:

Are you sure that works? When I tried it didn't. I think because
asm/smp.h isn't included by linux/smp.h for !SMP.

I needed the below to make it work, but including linux/smp.h and
asm/smp.h in the same file smells a bit fishy to me... Probably
acceptable for now if you are thinking of redoing SMP processor bringup
anyway.

diff -r fa530c593b97 arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c     Thu Aug 31 22:28:11 2006 +0100
+++ b/arch/i386/kernel/cpu/common.c     Thu Aug 31 22:33:08 2006 +0100
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mtrr.h>
 #include <asm/mce.h>
+#include <asm/smp.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>

Ian.


