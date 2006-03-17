Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWCQSng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWCQSng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWCQSnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:43:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:22972 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030258AbWCQSne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:43:34 -0500
Message-ID: <441B034F.7020102@us.ibm.com>
Date: Fri, 17 Mar 2006 12:43:27 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Xen-devel] Re: [RFC,	PATCH 0/24] VMI i386 Linux virtualization
 interface proposal
References: <200603171058_MC3-1-BADF-9E3F@compuserve.com> <441AF747.5000400@vmware.com>
In-Reply-To: <441AF747.5000400@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Chuck Ebbert wrote:
>> In-Reply-To: <20060315102522.GA5926@infradead.org>
>>
>> On Wed, 15 Mar 2006 10:25:22 +0000, Christoph Hellwig wrote:
>>   I'd like to see a test harness implementation that has no actual
>> hypervisor functionality and just implements the VMI calls natively.
>> This could be used to test the interface and would provide a nice
>> starting point for those who want to write a VMI hypervisor.
>>   
>
> I was going to make one yesterday.  But Fry's electronics stopped 
> carrying flashable blank PCI cards. :)  Anyone know of a vendor?
It's very practical to just patch Qemu to load a VMI rom as an option 
ROM.  That makes such an example VMI ROM very practical without having 
to build a special PCI device.

Regards,

Anthony Liguori
> It is possible to do in a software layer, although it really is a lot 
> easier to have the BIOS take care of all the fuss of finding a place 
> in low memory for you to live, setting up the various memory maps and 
> everything else for you.
>
> There is enormous benefit to having such a layer - you have a very 
> power test harness, not just to make sure VMI works, but even more 
> importantly, to inspect and verify the native kernel operation as 
> well.  You have a plethora of imporant hooks into the system, which 
> feed you knowledge you can not otherwise gain about which page tables 
> have been made active, when you take IRQs, where the kernel stack lives.
>
> All of this is ripe for a debug harness that can verify the kernel 
> doesn't overflow the kernel stack, doesn't write to active page table 
> entries without proper accessors and subsequent invalidations, and 
> obeys the rules that are required for correctness when running under a 
> hypervisor.  You probably even want to do hypervisor like things - 
> such as write protecting the kernel page tables so that you can be 
> confident there are no stray raw PTE accesses.
>
> We actually found one (harmless on native) in i386, which was enabling 
> NX bit.
>
> Zach
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel

