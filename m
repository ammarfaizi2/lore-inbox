Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWCOUcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCOUcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCOUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:32:15 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:19676 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751276AbWCOUcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:32:14 -0500
Date: Wed, 15 Mar 2006 15:32:00 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315203200.GB7465@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060315193114.GA7465@in.ibm.com> <1142452665.3021.43.camel@laptopd505.fenrus.org> <C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org> <m1ek13h3ej.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ek13h3ej.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 01:13:56PM -0700, Eric W. Biederman wrote:
> Kumar Gala <galak@kernel.crashing.org> writes:
> 
> > On Mar 15, 2006, at 1:57 PM, Arjan van de Ven wrote:
> >
> >>
> >>> One of the possible solutions to this problem is that expand the size
> >>> of "start" and "end" to "unsigned long long". But whole of the PCI  and
> >>> driver code has been written assuming start and end to be unsigned  long
> >>> and compiler starts throwing warnings.
> >>
> >>
> >> please use dma_addr_t then instead of unsigned long long
> >>
> >> this is the right size on all platforms afaik (could a ppc64 person
> >> verify this?> ;)
> >
> > Actually we really just want "start" and "end" to be u64 on all  platforms.
> > Linus was ok with this change but no one has gone through  and fixed everything
> > that would be required for it.
> 
> Since it is faster to ask :)
> 
> How is it that other pieces of code have problems?
> Warnings or something nasty?

Few problems which I have noticed so far.

- Many printk() warnings. Wherever start and end are being printed,
  the format specifier being used is %lx. Needs to be changed to %Lx.

- Some folks save a pointer of type (unsigned long *) to start and end field
  and then try to operate on it. This pointer type shall have to be changed
  to something like u64*.

	unsigned long *port, *end, *tport, *tend;
	port = &dev->res.port_resource[idx].start;

- Some folks cast "start" to a pointer and then use it. Compiler gives warning. 

	addr_reg = (void __iomem *) addr->start;

-vivek
