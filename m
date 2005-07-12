Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVGLMQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVGLMQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGLMNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:13:49 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:65355 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbVGLMNC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:13:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FSPqv7+IDwKwpz+OMd72LgexfIyXr5x2QKJA2SA8/O7eGN9E8GJJOYC34bBjnC6HD3w2y4rb5VrEphuCQETOMNCH8L2f44jL+PkTnirGtFXSFLlpl8aPL/hIc1UETJVykrXxY+VIYf2o3IJilb6PjJnvXfzW1p+vHW1d0UIz/wg=
Message-ID: <4ad99e05050712051341cf6e3@mail.gmail.com>
Date: Tue, 12 Jul 2005 14:13:01 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Rob Mueller <robm@fastmail.fm>
Subject: Re: 2.6.12.2 dies after 24 hours
Cc: linux-kernel@vger.kernel.org, Bron Gondwana <brong@fastmail.fm>,
       Jeremy Howard <jhoward@fastmail.fm>
In-Reply-To: <021801c586d7$5ebf4090$7c00a8c0@ROBMHP>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
	 <4ad99e05050712024319bc7ada@mail.gmail.com>
	 <021801c586d7$5ebf4090$7c00a8c0@ROBMHP>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/05, Rob Mueller <robm@fastmail.fm> wrote:
> Here's the /proc/interrupts dump:
> 
>            CPU0       CPU1       CPU2       CPU3
>   0:   11524000          0          0          0    IO-APIC-edge  timer
>   1:          8          0          0          0    IO-APIC-edge  i8042
>   5:          0          0          0          0   IO-APIC-level  acpi
>  14:         13          0          0          0    IO-APIC-edge  ide0
>  16:          2          0          0          0   IO-APIC-level  ibmasm0
>  20:    2978604          0    2338027          0   IO-APIC-level  eth0
>  22:    1321957          0          0          0   IO-APIC-level  ips
>  24:     581291          0          0          0   IO-APIC-level  pci-umem
>  29:     257154          0          0          0   IO-APIC-level  eth1
> NMI:          0          0          0          0
> LOC:   11524185   11524201   11524194   11524121
> ERR:          0
> MIS:          0

Looks fine to me

> 
> I'm not sure about IRQ balancing sorry. How do I tell? The entire boot
> process output is here:
> 
> http://robm.fastmail.fm/kernel/t7/bootdmesg.txt
> 
> And the config is here:
> 
> http://robm.fastmail.fm/kernel/t7/config.txt

You have irq balancing, the line 

CONFIG_IRQBALANCE=y

in your config file confirms it - I am not completely sure that it is
the root of the problem but when I experienced the problem I changed
two things: my acpi code and irq balancing and one of then made the
difference, I am just to lazy to check which one it is (also it is
production servers so I cannot do whatever I want).


> Our boot doesn't pass any special parameters, just choosing the deadline
> elevator...
> 
> image=/boot/bzImage-2.6.12.2
>   label=linux-2.6.12.2
>   append="elevator=deadline"
>   read-only
>   root=/dev/sda2

I use the same io scheduler so that should not be a problem. I have
uploaded my config file - it works on ibm 335/336 servers, and a quick
look at your boot msg seams to indicate that your server have some of
the same hardware - note however that I load ide/scsi/filesystem stuff
as modules so you will need to build a initrd to use my config.

the config is here

http://randompage.org/static/kernel.conf



--
Lars
