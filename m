Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWIVXrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWIVXrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWIVXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:47:09 -0400
Received: from colo.lackof.org ([198.49.126.79]:57806 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964936AbWIVXrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:47:07 -0400
Date: Fri, 22 Sep 2006 17:47:12 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Tejun Heo <htejun@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060922234712.GD7764@colo.lackof.org>
References: <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com> <20060907152147.GA17324@colo.lackof.org> <450042F7.5080202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450042F7.5080202@garzik.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 12:04:07PM -0400, Jeff Garzik wrote:
...
> >Current API (pci_set_mwi()) ties enabling MRM/MRL with enabling MWI
> >and I don't see a really good reason for that. Only the converse
> >is true - enabling MWI requires setting cachelinesize.
> 
> Correct, that's why it was done that way, when I wrote the API. 
> Enabling MWI required making sure the BIOS configured our CLS for us, 
> which was often not the case.  No reason why we can't do a
> 
> 	pdev->set_cls = 1;
> 	rc = pci_enable_device(pdev);

I was thinking the pci_enable_device could safely set CLS if MWI
were NOT enabled. I'm sure somethings would break that worked before
but that's what quirks are for, right?

Anyway, I'm convinced the arch specific PCI code should be setting CLS
either at bus_fixup or via some quirks to compensate for "broken" firmware
(which didn't set CLS). Maybe there is more brokn HW out there than
I think...I'm easy convince that's the case.

If a driver wanted to enable MWI, then pci_set_mwi() should
verify (or force) CLS setttings or return an error.
That part seems pretty straight forward and don't need a
change in API here.

thanks,
grant
