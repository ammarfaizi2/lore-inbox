Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752158AbWCJBfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbWCJBfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCJBfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:35:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752158AbWCJBf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:35:29 -0500
Date: Thu, 9 Mar 2006 17:37:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kwin@ns.sympatico.ca, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm3] x86-64: Eliminate register_die_notifier symbol
 exported twice
Message-Id: <20060309173738.6a97d0eb.akpm@osdl.org>
In-Reply-To: <20060309172854.ae8eeec9.rdunlap@xenotime.net>
References: <4410BDFB.3070401@ns.sympatico.ca>
	<20060309172854.ae8eeec9.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Thu, 09 Mar 2006 19:44:59 -0400 Kevin Winchester wrote:
> 
> > 
> > register_die_notifier is exported twice, once in traps.c and once in 
> > x8664_ksyms.c.  This results in a warning on build.
> > 
> > Signed-Off-By: Kevin Winchester <kwin@ns.sympatico.ca>
> > 
> > --- v2.6.16-rc5-mm3.orig/arch/x86_64/kernel/x8664_ksyms.c       
> > 2006-03-09 19:34:11.000000000 -0400
> > +++ v2.6.16-rc5-mm3/arch/x86_64/kernel/x8664_ksyms.c    2006-03-09 
> > 19:40:46.000000000 -0400
> > @@ -142,7 +142,6 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
> >  EXPORT_SYMBOL(empty_zero_page);
> > 
> >  EXPORT_SYMBOL(die_chain);
> > -EXPORT_SYMBOL(register_die_notifier);
> > 
> >  #ifdef CONFIG_SMP
> >  EXPORT_SYMBOL(cpu_sibling_map);
> 
> Thanks for that.  However, I see 2 such warnings:
> 
> WARNING: vmlinux: 'register_die_notifier' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux
> 

They're all over the place.  Some of them are due to -mm-only patches.

It's not very urgent.  Let's get Sam's stuff settled down into mainline and
get all such warnings in mainline fixed up first.  That way, people will
then know when their new patches are being bad and I'll know when -mm
patches need fixups.
