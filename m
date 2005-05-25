Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVEYNRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVEYNRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVEYNQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:16:00 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:32242 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262185AbVEYNPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:15:40 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] [1/2] kdump: Use real pt_regs from exception
From: Alexander Nyberg <alexn@telia.com>
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
In-Reply-To: <20050525130607.GB3658@in.ibm.com>
References: <1116103798.6153.30.camel@localhost.localdomain>
	 <20050518123500.GA3657@in.ibm.com>
	 <1116427862.22324.5.camel@localhost.localdomain>
	 <20050525020749.1ad56a80.akpm@osdl.org>
	 <1117023296.877.11.camel@localhost.localdomain>
	 <20050525130607.GB3658@in.ibm.com>
Content-Type: text/plain
Date: Wed, 25 May 2005 15:14:38 +0200
Message-Id: <1117026878.877.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-05-25 klockan 18:36 +0530 skrev Vivek Goyal:
> On Wed, May 25, 2005 at 02:14:56PM +0200, Alexander Nyberg wrote:
> > ons 2005-05-25 klockan 02:07 -0700 skrev Andrew Morton:
> > > Alexander Nyberg <alexn@telia.com> wrote:
> > > >
> > > > -extern void machine_crash_shutdown(void);
> > > >  +extern void machine_crash_shutdown(struct pt_regs *);
> > > 
> > > That'll break x86_64, ppc, ppc64 and s/390.
> > 
> > I'm such an idiot.
> > 
> > Make sure all arches take pt_regs * as argument to
> > machine_crash_shutdown(). (now cross-compiled on above arches except
> > s/390).
> > 
> 
> Alexander, I face following warning if I build my kernel without HIGHMEM
> support. Fianally linker fails in the end.
> 
> CC      kernel/kexec.o
> kernel/kexec.c: In function `kexec_should_crash':
> kernel/kexec.c:37: warning: implicit declaration of function `in_interrupt'
> 
> If I include HIGHMEM support, it compiles fine.
> 
> You might have to include include/linux/hardirq.h in kexec.c to 
> resolve the problem.
> 

Yeah this is fixed in -mm, thanks


