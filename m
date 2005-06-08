Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVFHD7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVFHD7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVFHD7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:59:23 -0400
Received: from colo.lackof.org ([198.49.126.79]:44493 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262092AbVFHD7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:59:15 -0400
Date: Tue, 7 Jun 2005 22:02:53 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Morton Andrew Morton <akpm@osdl.org>, awilliam@fc.hp.com,
       greg@kroah.com, Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bodo Eggert <7eggert@gmx.de>, stern@rowland.harvard.edu,
       bjorn.helgaas@hp.com
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050608040253.GA21060@colo.lackof.org>
References: <1118113637.42a50f65773eb@imap.linux.ibm.com> <20050607050727.GB12781@colo.lackof.org> <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com> <20050607162143.GE29220@colo.lackof.org> <m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 12:42:42PM -0600, Eric W. Biederman wrote:
> The howto deal with an IOMMU has been sorted out but so far no one 
> has actually done it.  What has been discussed previously is simply
> reserving a handful of IOMMU entries,

How? with dma_alloc_consistent() or some special hook?
I'm just curious.

...
>  and then only using those
> in the crash recover kernel.  This is essentially what we do with DMA
> on architectures that don't have an IOMMU and it seems quite safe
> enough there.

Yeah, in general that should be feasible.

One might be able to trivially allocate a small, seperate IO PDIR
just for KDUMP and switch to that. Key thing is it be physically
contiguous in memory. Very little code is involved with IO Pdir
setup for both parisc and IA64. I can't speak for Alpha/sparc/ppc/et al.

...
> Well we are at least capable of multitasking but that is no longer the
> primary focus.  Having polling as at least an option should make
> debugging easier.  Last I looked Andrews kernel hand an irqpoll option
> to do something very like this.

You could run the itimer but I don't see why you should.
Kdump is essentially an embedded linux kernel. It really
doesn't need to be premptive multitasking either.

Anyway, sounds like you guys are on the right track.

thanks,
grant
