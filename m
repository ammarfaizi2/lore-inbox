Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWFBHeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWFBHeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFBHeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:34:23 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37088 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751271AbWFBHeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:34:22 -0400
Message-ID: <447FE943.3010702@jp.fujitsu.com>
Date: Fri, 02 Jun 2006 16:31:15 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>, "bibo,mao" <bibo.mao@intel.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <20060602055642.GC1501@colo.lackof.org>
In-Reply-To: <20060602055642.GC1501@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Fri, Jun 02, 2006 at 11:57:36AM +0900, Kenji Kaneshige wrote:
> ...
> 
>>As Rajesh pointed out, there are many drivers which initialize the
>>device with the wrong order. They should be fixed.
> 
> 
> Then you also agree with the patch to pci.txt?

Yes. I agree with you.

>>I would like to
>>confirm the correct order to initialize the device again. Is the
>>following correct order?
>>
>>   (1) pci_request_regions()
>>   (2) pci_enable_device()
>>   (3) request_irq()
>>   (4) free_irq()
>>   (5) pci_disable_device()
>>   (6) pci_release_regions()
> 
> 
> Yes, that's what I would prefer and would like to see reccomended.
> Would you like to see that order listed (like you have above)
> in the pci.txt file?
> 

I think that list would be very useful. But as you said, there are
other steps remaining than ones I came up with at once. I can't
deal with the steps of all of them...

BTW, Section 3 says "Before you do anything with the device you've
found, you need to enable it by calling pci_enable_device()...". I
think it would be one of the causes of misunderstanding the order
between pci_request_regions() and pci_enable_device().

Thanks,
Kenji Kaneshige


> A less precise list is in the first section of Documentation/pci.txt.
> 
> [ TODO: Can someone define which kernel versions implement "new style"? ]
> 
> There's more to this list unfortunately:
> 	DMA mask settings, MSI support, power state
> 
> And probably a few more that I'm not thinking of right now.
> 
> Restructing the document to list the steps, indicate which
> are optional, and describe each step in order is more than
> I can deal with right now.  Section 3 and 5 cover most of
> the material but aren't as clear as Kenji's list.
> 
> thanks,
> grant
> 

