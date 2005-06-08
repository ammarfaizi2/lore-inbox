Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVFHKjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVFHKjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVFHKj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:39:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47531 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262159AbVFHKhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:37:07 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Bodo Eggert <7eggert@gmx.de>,
       stern@rowland.harvard.edu, awilliam@fc.hp.com, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       bjorn.helgaas@hp.com
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <1118113637.42a50f65773eb@imap.linux.ibm.com>
	<20050607050727.GB12781@colo.lackof.org>
	<m1slzuwkqx.fsf@ebiederm.dsl.xmission.com>
	<20050607162143.GE29220@colo.lackof.org>
	<m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
	<20050608040253.GA21060@colo.lackof.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2005 22:38:36 -0600
In-Reply-To: <20050608040253.GA21060@colo.lackof.org>
Message-ID: <m1mzq1v4xf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <grundler@parisc-linux.org> writes:

> On Tue, Jun 07, 2005 at 12:42:42PM -0600, Eric W. Biederman wrote:
> > The howto deal with an IOMMU has been sorted out but so far no one 
> > has actually done it.  What has been discussed previously is simply
> > reserving a handful of IOMMU entries,
> 
> How? with dma_alloc_consistent() or some special hook?
> I'm just curious.

We didn't get that far but I believe the idea was a special hook.

> ...
> >  and then only using those
> > in the crash recover kernel.  This is essentially what we do with DMA
> > on architectures that don't have an IOMMU and it seems quite safe
> > enough there.
> 
> Yeah, in general that should be feasible.
> 
> One might be able to trivially allocate a small, seperate IO PDIR
> just for KDUMP and switch to that. Key thing is it be physically
> contiguous in memory. Very little code is involved with IO Pdir
> setup for both parisc and IA64. I can't speak for Alpha/sparc/ppc/et al.

Cool.
 
> ...
> > Well we are at least capable of multitasking but that is no longer the
> > primary focus.  Having polling as at least an option should make
> > debugging easier.  Last I looked Andrews kernel hand an irqpoll option
> > to do something very like this.
> 
> You could run the itimer but I don't see why you should.
> Kdump is essentially an embedded linux kernel. It really
> doesn't need to be premptive multitasking either.

It is mostly a matter of minimizing differences from the norm.

> Anyway, sounds like you guys are on the right track.

Thanks.   It just takes a while for the simple solutions to
get there.

Eric
