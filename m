Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVFGQSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVFGQSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVFGQSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:18:49 -0400
Received: from colo.lackof.org ([198.49.126.79]:31937 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261927AbVFGQSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:18:11 -0400
Date: Tue, 7 Jun 2005 10:21:43 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Vivek Goyal <vgoyal@in.ibm.com>, greg@kroah.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Bodo Eggert <7eggert@gmx.de>,
       Dipankar Sarma <dipankar@in.ibm.com>, stern@rowland.harvard.edu,
       awilliam@fc.hp.com, bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050607162143.GE29220@colo.lackof.org>
References: <1118113637.42a50f65773eb@imap.linux.ibm.com> <20050607050727.GB12781@colo.lackof.org> <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 03:59:18AM -0600, Eric W. Biederman wrote:
> > *lots* of PCI devices predate PCI2.3. Possibly even the majority.
> 
> In general generic hardware bits for disabling DMA, disabling interrupts
> and the like are all advisory.  With the current architecture things
> will work properly even if you don't manage to disable DMA (assuming
> you don't reassign IOMMU entries at least).

ISTR, pSeries (IBM), some alpha, some sparc64, and parisc (64-bit) require
use of the IOMMU for *any* DMA. ie IOMMU entries need to be programmed.
Probably want to make a choice to ignore those arches for now
or sort out how to deal with an IOMMU.

> Shared interrupts are an interesting case.  The simplest solution I can
> think of for a crash dump capture kernel is to periodically poll
> the hardware, as if all interrupts are shared.  At that level
> I think we could get away with ignoring all hardware interrupt sources.

Yes, that's perfectly ok. We are no longer in a multitasking env.

> Does anyone know of a anything that would break by always polling
> the hardware?  I guess there could be a problem with drivers
> that don't understand shared interrupts, are there enough of those
> to be an issue.

PCI requires drivers support Shared IRQs.
A few oddballs might be broken but I expect networking/mass storage
drivers get this right.

grant
