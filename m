Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWBWE0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWBWE0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBWE0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:26:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:64422 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750824AbWBWE0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:26:36 -0500
Message-ID: <43FD3971.7070703@us.ibm.com>
Date: Wed, 22 Feb 2006 22:26:25 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Mike D. Day" <ncmike@us.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen	hypervisor	attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com>	 <1140542130.8693.18.camel@localhost.localdomain>	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>	 <43FC5B1D.5040901@us.ibm.com>	 <1140612969.2979.20.camel@laptopd505.fenrus.org>	 <43FC61C4.30002@us.ibm.com>	 <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>	 <43FC6A86.90901@us.ibm.com> <1140616911.2979.22.camel@laptopd505.fenrus.org>
In-Reply-To: <1140616911.2979.22.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-02-22 at 08:43 -0500, Mike D. Day wrote:
>   
>> Heiko Carstens wrote:
>>     
>>> On Wed, Feb 22, 2006 at 08:06:12AM -0500, Mike D. Day wrote:
>>>
>>> If it's not needed, why include it at all?
>>>       
>> Sorry for not being clear. It *is* needed for control tools and agents 
>> running in the privileged domain. 
>>     
>
> but again those tools and agents *already* have a way of talking to the
> hypervisor themselves. Why can't they just first ask this info? Why does
> that need to be in the kernel, in unswappable memory?
>   
Hypercalls have to be done in ring 0 for security reasons)  There has to 
be some kernel interface for making hypercalls.

The current interface is a ioctl() on a /proc file (which is awful).  
The ioctl just pretty much passes 5 word arguments to the hypervisor.  
It was suggested previously here that a hypercall pass-through interface 
isn't the right approach.  One suggestion that came up was a syscall 
interface.

Also, there are some kernel-level drivers, like the memory ballooning 
driver, that only exist in the kernel.  Controlling the balloon driver 
requires some sort of interface.  That was the original point of this 
effort (since it's currently exposed as a /proc file).  I think it's 
quite clear that the balloon driver should expose itself through sysfs 
but I'm not personally convinced that this information (hypervisor 
version information) ought to be exposed in sysfs.

Regards,

Anthony Liguori
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

