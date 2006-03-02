Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWCBQZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWCBQZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWCBQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:25:21 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55502 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751571AbWCBQZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:25:21 -0500
Message-ID: <44071C17.8050801@jp.fujitsu.com>
Date: Fri, 03 Mar 2006 01:23:51 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk>
In-Reply-To: <20060302155056.GB28895@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems we need a little more discussion.
Please don't apply my patches >> Andrew, Greg

Russel, I'm sorry, but could you wait some hours for my reply?
I noticed the email from you when I was about to go to bed...

Thanks,
Kenji Kaneshige


Russell King wrote:
> On Fri, Mar 03, 2006 at 12:12:34AM +0900, Kenji Kaneshige wrote:
> 
>>Hi Andrew, Greg,
>>
>>Here is an updated set of patches for PCI legacy I/O port free
>>driver. It incorporates all of the feedbacks. I rebased it against the
>>latest -mm kernel (2.6.16-rc5-mm1).
>>
>>Could you consider applying this to -mm tree?
> 
> 
> I've been wondering whether this "no_ioport" flag is the correct approach,
> or whether it's adding to complexity when it isn't really required.
> 
> In the non-Intel world, the kernel itself sets up the PCI bus mappings,
> and any IO bars which it can't satisfy might also need to be gracefully
> handled.  Currently, we just go 'printk("whoops, didn't allocate
> resource")' and leave the BAR containing whatever random junk it
> contained before, along with the resource containing whatever random
> junk pci_bus_alloc_resource() decided to leave in it.
> 
> In such cases, I would suggest that the method of signalling that IO
> should not be used is to have the IO resource structures cleared out -
> if the IO resources aren't valid, they should not contain something
> which could be interpreted as valid.
> 
> Maybe something like this should be done for the "legacy IO port" case
> as well?
> 

