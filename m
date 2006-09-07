Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWIGRAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWIGRAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWIGRAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:00:33 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:9662 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161068AbWIGRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:00:31 -0400
Date: Thu, 7 Sep 2006 11:00:30 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Grant Grundler <grundler@parisc-linux.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907170030.GR2558@parisc-linux.org>
References: <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com> <20060907152147.GA17324@colo.lackof.org> <45003F1B.7000302@gmail.com> <45004227.8090200@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45004227.8090200@pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 12:00:39PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >arch/i386/pci/common.c overrides cacheline size to min 32 regardless of 
> >actual size.  So, we seem to be using larger cacheline size for MWI 
> >already.
> 
> It clamps the minimum size to 32, yes, but on modern machines common.c 
> configures it to a larger size.
> 
> 
> >Jeff pointed out that there actually are devices which limit CLS config. 
> > IMHO, making PCI configure CLS automatically and provide helpers to LLD 
> >to override it if necessary should cut it.
> 
> We still have to add a raft of quirks, if we start automatically 
> configurating CLS...  Also, many PCI devices hardcode it to zero.

That's not a problem.  As long as they silently discard the writes to
the CLS register, we'll cope.  If they decide to flip out, then we have
the no_cls flag.

> If we start configuring CLS automatically, I forsee a period of breakage...

Probably.  But it's something we should have done a long time ago.
