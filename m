Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWIGQBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWIGQBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWIGQBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:01:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6041 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932149AbWIGQBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:01:40 -0400
Message-ID: <45004227.8090200@pobox.com>
Date: Thu, 07 Sep 2006 12:00:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com> <20060907152147.GA17324@colo.lackof.org> <45003F1B.7000302@gmail.com>
In-Reply-To: <45003F1B.7000302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> arch/i386/pci/common.c overrides cacheline size to min 32 regardless of 
> actual size.  So, we seem to be using larger cacheline size for MWI 
> already.

It clamps the minimum size to 32, yes, but on modern machines common.c 
configures it to a larger size.


> Jeff pointed out that there actually are devices which limit CLS config. 
>  IMHO, making PCI configure CLS automatically and provide helpers to LLD 
> to override it if necessary should cut it.

We still have to add a raft of quirks, if we start automatically 
configurating CLS...  Also, many PCI devices hardcode it to zero.

If we start configuring CLS automatically, I forsee a period of breakage...

	Jeff


