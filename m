Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946368AbWJSSzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946368AbWJSSzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946369AbWJSSzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:55:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36816 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946368AbWJSSzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:55:37 -0400
Message-ID: <4537CA25.6070003@us.ibm.com>
Date: Thu, 19 Oct 2006 13:55:33 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Avi Kivity <avi@qumranet.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <20061019173151.GD4957@rhun.haifa.ibm.com>
In-Reply-To: <20061019173151.GD4957@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Thu, Oct 19, 2006 at 03:45:49PM +0200, Avi Kivity wrote:
>
>   
>> The following patchset adds a driver for Intel's hardware virtualization
>> extensions to the x86 architecture.  The driver adds a character device
>> (/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
>> this driver, a process can run a virtual machine (a "guest") in a fully
>> virtualized PC containing its own virtual hard disks, network adapters, and
>> display.
>>     
>
> Hi,
>
> Looks pretty interesting! some comments:
>
> - patch 4/7 hasn't made it to the list?
> - it would be useful for reviewing this if you could post example code
>   making use of the /dev/kvm interfaces - they seem fairly complex.
> - why do it this way rather than through a virtual machine monitor
>   such as Xen? what do you gain from having the virtual machines
>   encapsulated as Linux processes?
>   

With VT (or even SVM) you gain nothing from having a microkernel based 
hypervisor.  With paravirtualization, having a hypervisor that fits into 
64mb of address space is critical for reducing the cost of hypercalls 
(to avoid tlb flushes).

With both VT and SVM, address space switching is mandatory.  Since this 
is already occurring, switching to a microkernel (like Xen) has no 
performance benefit to switching to a macrokernel (like Linux).

Not to mention, many of VT/SVM performance problems in Xen are related 
to the amount of switching required to service IO requests (from HVM 
domain, to hypervisor, to dom0 kernel, then to dom0 userspace).  
Compared to KVM where you only switch from guest, to kernel, to 
userspace and I find it highly likely that this is a faster approach.

There are some reasons why you may still want a hypervisor (resource 
isolation and scheduler guarantees) but there's nothing fundamental that 
keeps one from adding those to Linux.

This is definitely good stuff.  Too much of it is just taken from Xen 
though and ought to be thought out a little more but for what it's 
worth, I think this is the right idea.

Regards,

Anthony Liguori

> Cheers,
> Muli
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

