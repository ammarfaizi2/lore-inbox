Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTEJShb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTEJShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:37:31 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:13726 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S264392AbTEJSha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:37:30 -0400
Message-ID: <3EBD49CF.7030304@cox.net>
Date: Sat, 10 May 2003 13:49:51 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stian Jordet <liste@jordet.nu>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: PCI problem [was Re: ACPI conflict with USB]
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com> <1052444521.3ebb076946267@webmail.jordet.nu> <3EBB0A95.20902@cox.net>
In-Reply-To: <3EBB0A95.20902@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
> Stian Jordet wrote:
> 
>> Sitat Greg KH <greg@kroah.com>:
>>
>>
>>> On Thu, May 08, 2003 at 05:50:36PM -0500, David van Hoose wrote:
>>>
>>>> I'm wondering if there is any work towards correcting the ACPI 
>>>> conflict with USB. On my system, I cannot use any USB devices due to 
>>>> a timeout anytime I use ACPI with my kernel. Other people have 
>>>> noticed this happening on their systems as well, so I am assuming it 
>>>> isn't just on my system.
>>>
>>>
>>> Have you tried the latest 2.5 kernels?  I think this is fixed in 2.5.69
>>> for the majority of people.  Also, does booting with "noapic" work for
>>> you?
>>
>>
>>
>> If it is supposed to have been fixed in 2.5.69, that must be the 
>> reason usb
>> stopped working with acpi on 2.5.69 for me. Worked fine with 2.5.68.
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=105216850332081&w=2
>>
>> Only three days since I reported it, and you say it is fixed? Gee.
>>
>> David: The consensus on acpi-devel is to report it in bugzilla, and 
>> see what
>> happens.
> 
> I'm using kernel 2.5.69-bk3 with this recent test. Booted with noapic, 
> and I get thousands of lines of APIC errors. I still get the 'bulk_msg: 
> timeout' with USB though.
> This hasn't ever worked for me. First tried with 2.5.54. I don't think I 
> tried 2.5.68. Should I and see if it was something in a patch to 2.5.69?

Okay. I think I have figured some things out.
With 2.5.69-bk4, I have ACPI and APM built into my kernel.

If I boot normally, ACPI loads first and I get timeouts and my USB 
trackball doesn't register with input.

If I boot with noacpi, I still have the same problem.

If I boot with pci=noacpi, I do *not* have the problem. I still have the 
timeout, but my trackball works. However, I have many lines of an 
acpi_irq handler and call trace with the comment 'irq 20: nobody 
cared!'. I also get 'APIC error on CPU0: 00(40)' and 'APIC error on 
CPU0: 40(40)' a couple dozen times each.

If I boot with noacpi *and* pci=noacpi, I have the all of the problems 
mentioned; no trackball and the pci=noacpi related problems.

Someone mentioned using noapic, but it doesn't have any effect.

Any questions?

Thanks,
David

