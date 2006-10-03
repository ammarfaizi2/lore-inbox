Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWJCBlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWJCBlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWJCBlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:41:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:23442 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030231AbWJCBlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:41:11 -0400
Message-ID: <4521BFB3.9070607@us.ibm.com>
Date: Mon, 02 Oct 2006 18:41:07 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, suka@us.ibm.com
Subject: Re: 2.6.18-mm2 networking problem + IRQ panic
References: <1159830432.5039.16.camel@dyn9047017100.beaverton.ibm.com> <20061002162227.1096ac17.akpm@osdl.org>
In-Reply-To: <20061002162227.1096ac17.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 02 Oct 2006 16:07:12 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>   
>> Hi,
>>
>> I am having problem bringing up networking on 2.6.18-mm2.
>> I don't see any interrupts for eth0. I also see "cannot 
>> handle IRQ" panic on shutdown - wondering if they are related..
>>
>> ...
>>     
> yes, this is probably the insert-ioapics-and-local-apic-into-resource-map
> patch.  Does mainline crash too?  It should.  Or at least, it should have
> the same resource allocation errors.
>
>   
Yes. Backing out this solved the problem. (I got the patch from your -mm1
broken out directory and reverted that).

x86_64-mm-insert-ioapics-and-local-apic-into-resource-map

> I've backed that out and applied an updated version.  My current rollup
> (which actually seems to mostly compile now) is at
>
> http://userweb.kernel.org/~akpm/badari.bz2
>
> That's against 2.6.18.  Can you see if that fixes things?
>
>   
>> INIT:do_IRQ: cannot handle IRQ -1
>> ----------- [cut here ] --------- [please bite here ] ---------
>> Kernel BUG at arch/x86_64/kernel/irq.c:118
>> invalid opcode: 0000 [1] SMP
>> last sysfs file: /devices/pci0000:00/0000:00:06.0/irq
>> CPU 1
>> Modules linked in: acpi_cpufreq ipv6 thermal processor fan button
>> battery ac dm_mod floppy parport_pc lp parport
>> Pid: 1, comm: init Not tainted 2.6.18-mm2 #1
>> RIP: 0010:[<ffffffff8020ced0>]
>>
>>     
>
> Once upon a time we'd have got a backtrace from that.
>   
 :)

Thanks,
Badari


