Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946364AbWJSStb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946364AbWJSStb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946366AbWJSStb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:49:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:913 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946364AbWJSSta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:49:30 -0400
Message-ID: <4537C8B3.5050501@us.ibm.com>
Date: Thu, 19 Oct 2006 13:49:23 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Stoffel <john@stoffel.org>, Avi Kivity <avi@qumranet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain>
In-Reply-To: <1161269405.17335.80.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-10-19 am 10:30 -0400, ysgrifennodd John Stoffel:
>   
>> Avi> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s
>> Avi> allow adding memory to a virtual machine, adding a virtual cpu to
>> Avi> a virtual machine (at most one at this time), transferring
>> Avi> control to the virtual cpu, and querying about guest pages
>> Avi> changed by the virtual machine.
>>
>> Yuck.  ioclts are deprecated, you should be using /sysfs instead for
>> stuff like this, or configfs.  
>>     
>
> Bzzt Wrong answer, please try again 8)
>
> The kernel summit discussions were very much that ioctl has its place,
> and that the sysfs extremists were wrong. sysfs has its place (views
> ranging from that being /dev/null upwards) but sysfs is useless for many
> kinds of interface including those with read/write or other
> synchronization properties, those that trigger actions and those that
> are tied to the file handle you are working with. An executing VM
> interface via sysfs is a ludicrous concept.
>
> Making sure the ioctl sizes are the same in 32/64bit and aligned the
> same way is the more important issue.
>   

ioctls are probably wrong here though.  Ideally, you would want to be 
able to support an SMP guest.  This means you need to have two virtual 
processors executing in kernel space.  If you use ioctls, it forces you 
to have two separate threads in userspace.  This would be hard for 
something like QEMU which is currently single threaded (and not at all 
thread safe).

If you used a read/write interface, you could poll for any number of 
processors and handle IO emulation in a single userspace thread (which 
seems closer to how hardware really works anyway).

Regards,

Anthony Liguori

> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

