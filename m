Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWI1XDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWI1XDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWI1XDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:03:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5008 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750786AbWI1XDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:03:38 -0400
Message-ID: <451C54C0.6080402@garzik.org>
Date: Thu, 28 Sep 2006 19:03:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com>
In-Reply-To: <20060928224550.GJ22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Thu, Sep 28, 2006 at 05:45:41AM -0400, Jeff Garzik wrote:
>> Muli Ben-Yehuda wrote:
>>> On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
>>>> The x86[-64] PCI domain effort needs to be restarted, because we've got
>>>> machines out in the field that need this in order for some devices to
>>>> work.
>>>>
>>> This breaks the Calgary IOMMU, since it uses sysdata for other
>>> purposes (going back from a bus to its IO address space). I'm looking
>>> into it.
>> You'll need to modify struct pci_sysdata in 
>> include/asm-{i386,x86_64}/pci.h to include the data that you previously 
>> stored directly into the sysdata pointer.
> 
> Something like this should do the trick. Note - this should not be
> applied yet - after several gigabytes of network and disk activity it
> takes aic94xx down. More investigation required.

hmmmm.  What kernels did you test?

I would suggest testing

jgarzik/misc-2.6.git#master	-> vanilla Linux kernel
jgarzik/misc-2.6.git#pciseg	-> #master + PCI domain support
#pciseg + your patch

That should narrow down the problems.  A problem with aic94xx sorta 
sounds like something unrelated.


> diff -Naurp -X /home/muli/w/dontdiff pci-domains/arch/x86_64/kernel/pci-calgary.c linux/arch/x86_64/kernel/pci-calgary.c
> --- pci-domains/arch/x86_64/kernel/pci-calgary.c	2006-09-28 13:31:14.000000000 +0300
> +++ linux/arch/x86_64/kernel/pci-calgary.c	2006-09-28 13:14:38.000000000 +0300

ACK patch


