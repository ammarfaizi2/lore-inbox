Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWGFPqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWGFPqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWGFPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:46:48 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:56536 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1030350AbWGFPqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:46:48 -0400
Message-ID: <44AD3062.9030601@myri.com>
Date: Thu, 06 Jul 2006 11:46:42 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent
 busses flags
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com> <20060704070643.GA16632@colo.lackof.org> <44AAF5D9.9040908@myri.com> <20060705034829.GA19937@colo.lackof.org> <44AB4243.8030002@myri.com> <20060706153940.GA29981@colo.lackof.org>
In-Reply-To: <20060706153940.GA29981@colo.lackof.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Wed, Jul 05, 2006 at 12:38:27AM -0400, Brice Goglin wrote:
>   
>> Grant Grundler wrote:
>>     
>>> I still don't want the generic PCI code to assume a "root"
>>> PCI Host bus controller was found after that loop.
>>>       
>> If I am not mistaken, we can use the following code to check whether we
>> found a root chipset:
>>         unsigned cap;
>>         u16 val;
>>         u8 ext_type;
>>         cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
>>     
>
> That might work fine on x86 boxen where firmware fakes all devices
> to show up in PCI config space. That's not the case on many other
> architectures. My whole point was the pdev doesn't exist for
> a root chipset on those other arch's.
>   

Right, and the whole point of this check is to detect this case: my
while loop cannot find a root chipset on these architectures since there
is no pci_dev. So the while loop will return another pci_dev, either the
device or another bridge. When we detect that this pci_dev has a wrong
exp_type (not PCI_EXP_TYPE_ROOT_PORT), we know it is not a root chipset,
thus we do not check its no_msi flag.

Brice

