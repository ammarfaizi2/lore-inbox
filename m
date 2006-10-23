Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWJWHmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWJWHmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWJWHmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:42:24 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:40579 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751691AbWJWHmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:42:24 -0400
Message-ID: <453C725A.7080501@qumranet.com>
Date: Mon, 23 Oct 2006 03:42:18 -0400
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com>	 <20061019173151.GD4957@rhun.haifa.ibm.com> <4537BD27.7050509@qumranet.com>	 <200610211816.27964.arnd@arndb.de>  <453B2DDB.3010303@qumranet.com> <1161547015.1919.36.camel@localhost.localdomain>
In-Reply-To: <1161547015.1919.36.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 07:42:23.0324 (UTC) FILETIME=[C714C9C0:01C6F676]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-10-22 am 10:37 +0200, ysgrifennodd Avi Kivity:
>   
>> I like this.  Since we plan to support multiple vcpus per vm, the fs 
>> structure might look like:
>>     
>
> Three times the syscall overhead is bad for an emulation very bad 

Why? You would usually just call kvm_run(). get/set regs are not needed 
normally.

> for an
> emulation of a CPU whose virtualisation is half baked.
>
>   

Blood rare.  The thing can't even virtualize the first instruction executed.

>> It's certainly a lot more code though, and requires new syscalls.  Since 
>> this is a little esoteric does it warrant new syscalls?
>>     
>
> I think not - ioctl exists to avoid adding a billion esoteric one user
> syscalls. The idea of a VFS sysfs type view of the running vm is great
> for tools however so I wouldn't throw it out entirely or see it as ioctl
> versus fs.
>   

I still want a separate object per vcpu:


    kvm_fd = open("/dev/kvm")
    for (i = 0; i < n; ++i)
        vcpu_fds[i] = ioctl(kvm_fd, KVM_CREATE_VCPU, i)

so the refcounting doesn't bounce cachelines too much.  In effect it's a 
mini filesystem.

-- 
error compiling committee.c: too many arguments to function

