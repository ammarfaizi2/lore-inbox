Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263280AbVCES0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbVCES0P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbVCES0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:26:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:5610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263280AbVCESZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:25:56 -0500
Message-ID: <4229F6F2.2030108@osdl.org>
Date: Sat, 05 Mar 2005 10:14:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Raffaele Ianniello <raffaele.ianniello@studio.unibo.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
References: <1110017468.422985bc70540@posta.studio.unibo.it>
In-Reply-To: <1110017468.422985bc70540@posta.studio.unibo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raffaele Ianniello wrote:
> I have a problem compiling a module that I am porting form 2.4 to 2.6 linux kernel.
> 
> Compiling with this Makefile:
>  
> DEBUG = y
>  
> KERNELDIR = /usr/src/linix.2.6.9
> SUBDIR = $(KERNELDIR)/drivers/snoop
> INCLUDEDIR = $(KERNELDIR)/include
>  
> obj-m := snoop.o
>  
> modules: $(MAKE) -C $(KERNELDIR) SUBDIR=$(SUBDIR) modules
>  
> clean:
>         rm -f *.o
>         rm -f *.ko
> 
> apperars some lines like:
> ***Warning: "snoop_ip_forward" [drivers/snoop/snoop] is COMMON symbol
> ***Warning: "snoop_ip_forward_finish" [drivers/snoop/snoop] is COMMON symbol
>  
> and I have insert in ip_forward.c some lines:
>  
>     extern int (* snoop_ip_forward_finish) (struct sk_buff *);
> 
> and this is in function ip_forward():
>        if(snoop_ip_forward && (*snoop_ip_forward)(skb) == -6)
>                 goto drop;
>  
> then when I try to install the module it repyes with:
>     insmod: error inserting 'snoop.ko': -1 Invalid module format
> 
> and in /var/log/message appears some lines line:
>     kernel: snoop: Unknown symbol __floatsidf
>     kernel: snoop: Unknown symbol __fixunsdfsi
>     kernel: snoop: Unknown symbol __adddf3
>     kernel: snoop: Unknown symbol __muldf3
> 
> I will be very pleased if you can help me in some way.
> thank you for your time

I don't know what the ***Warning's are, but the first 2
problems to solve are:

a.  use a proper 2.6 Makefile:  see Documentation/kbuild/*
     and http://lwn.net/Articles/driver-porting/
     or see an example at
     http://www.xenotime.net/linux/modprms/Makefile
IOW, you need to use the 2.6 build system.

b.  The code is being generated with some floating point
     operations in it.  Linux kernel does not (generally)
     allow/support FP operations in kernel code, so you'll
     need to use some other method for those calculations.
     (unless this problem goes away because of using the
     correct 2.6 build system tools)

-- 
~Randy
