Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFKRD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFKRD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFKRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:02:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264229AbUFKQ73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:59:29 -0400
Date: Fri, 11 Jun 2004 12:59:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org,
       "Surendra I." <surendrai@esntechnologies.co.in>,
       Subramanyam B <subramanyamb@esntechnologies.co.in>
Subject: Re: Problem in module loading automatically at boot time
In-Reply-To: <1118873EE1755348B4812EA29C55A9722AF3A5@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0406111255020.746@chaos>
References: <1118873EE1755348B4812EA29C55A9722AF3A5@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004, Srinivas G. wrote:

>
> Hi,
>
> I have written a small driver program called hello.c.
>
> ************************************************************************
> ***************
> #include <linux/module.h>
>
> MODULE_LICENSE("GPL");
>
> int init_module(void)
> {
>   printk("<1>" "Hello world\n");
>   return 0;
> }
>
> void cleanup_module(void)
> {
>   printk("<1>good bye\n");
> }
>
> ************************************************************************
> ****************
>
> I compiled the above program with cc -DMODULE -D__KERNEL__
> -I/usr/src/linux2.4/include -O2 -c hello.c
>
> I am using Red Hat Linux 7.3 with kernel version of 2.4.18-3.
> It works fine when I load it with insmod from root prompt.
>
> Now, I want to make it load automatically at boot time.
> For that I have used the following steps.
>
> ---> I copied the hello.o file in the
> /lib/modules/2.4.18-3/kernel/drivers/block
>
> ---> I run the depmod command. It included the above path in
> /lib/modules/2.4.18-3/modules.dep file.
>
> ---> I added "alias hello1 hello" entry into /etc/modules.conf file.
>
> When I reboot the machine after the above changes, my driver is not
> loaded and an error message is printed as follows.
>
> ---> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-3/kernel/drivers/block/hello.o
>
>
> Could anyone suggest me, if I am missing anything here?
>
> Srinivas G
>

Maybe `depmod -e ...` would tell you what symbols are missing??

Then, after you observe that, try including <linux/kernel.h>,
and <linux/module.h>, like you are supposed to do.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


