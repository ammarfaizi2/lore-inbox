Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWIGQEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWIGQEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWIGQEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:04:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16025 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932241AbWIGQEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:04:20 -0400
Message-ID: <450042F7.5080202@garzik.org>
Date: Thu, 07 Sep 2006 12:04:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Tejun Heo <htejun@gmail.com>, Matthew Wilcox <matthew@wil.cx>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com> <20060907152147.GA17324@colo.lackof.org>
In-Reply-To: <20060907152147.GA17324@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> hrm...if the driver can put a safe value in cachelinesize register
> and NOT enable MWI, I can imagine a significant performance boost
> if the device can use MRM or MRL. But IMHO it's up to the driver
> writers (or other contributors) to figure that out.

Yes.


> Current API (pci_set_mwi()) ties enabling MRM/MRL with enabling MWI
> and I don't see a really good reason for that. Only the converse
> is true - enabling MWI requires setting cachelinesize.

Correct, that's why it was done that way, when I wrote the API. 
Enabling MWI required making sure the BIOS configured our CLS for us, 
which was often not the case.  No reason why we can't do a

	pdev->set_cls = 1;
	rc = pci_enable_device(pdev);

or

	rc = pci_set_cacheline_size(pdev);

Regards,

	Jeff



