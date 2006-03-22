Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWCVQPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWCVQPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWCVQPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:15:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38046 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751222AbWCVQPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:15:14 -0500
Message-ID: <442177FE.4030300@us.ibm.com>
Date: Wed, 22 Mar 2006 10:14:54 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063804.956561000@sorel.sous-sol.org> <442174B9.4050309@us.ibm.com> <048b633179d2ecffd95c58eada4313fc@cl.cam.ac.uk>
In-Reply-To: <048b633179d2ecffd95c58eada4313fc@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
>
> On 22 Mar 2006, at 16:00, Anthony Liguori wrote:
>
>> This has always seemed a bit wrong to me and makes a number of things 
>> kind of awkward (like a virtual video driver).
>>
>> It would seem better me to treat this driver as what it really is, a 
>> virtual serial device.  It adds a little bit of additional work to 
>> the userspace tools (they just have to make sure to pass 
>> console=ttyS0) but it seems worth it.
>
> That already works pretty much (userspace tools have to pass 
> xencons=ttyS as well as console=ttyS0).
>> We could also solve the tty[0-9] problem by implementing a proper 
>> console driver that could use multiple virtual serial devices if we 
>> wanted to go that route.
>
> Yes, that could live alongside this driver.

This is going to come up in the next release if we try to merge the 
framebuffer stuff.

>> Another option would be to just emulate a serial driver.  The console 
>> driver isn't really performance critical.  It seems to me that it's a 
>> bit unnecessary to even bother paravirtualizing the console device 
>> when it's so easy to emulate.
>
> Easy except that Xen can't implement the 'console backend', or at 
> least not easily. The console bits need to end up in management 
> virtual machine's user space. We'd have to do something skanky like 
> the current HVM qemu model.

We could make an exception for console devices and just have a small 
buffer in the hypervisor for console input/output (similar to the 
emergency console).  The biggest advantage to doing this IMHO is that it 
makes guest OS's a bit easier to port.  The console already is treated 
as an exception since it is setup in start_info (instead of through 
XenBus) so this is not that awful I think.

Regards,

Anthony Liguori

>  -- Keir
>

