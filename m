Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWJXLMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWJXLMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 07:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWJXLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 07:12:14 -0400
Received: from mail.innomedia.soft.net ([164.164.79.130]:63678 "EHLO
	gateway.innomedia.soft.net") by vger.kernel.org with ESMTP
	id S1030313AbWJXLMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 07:12:13 -0400
Message-ID: <453DF507.8050101@innomedia.soft.net>
Date: Tue, 24 Oct 2006 16:42:07 +0530
From: Dipti Ranjan Tarai <dipti@innomedia.soft.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: kbuild-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Link lib to a kernel module
References: <20061024105518.GA55219@server.idefix.loc>
In-Reply-To: <20061024105518.GA55219@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   As per my knowledge kernel module can not access to a library 
function. Library function are only accessible to user level program. 
Module can access exported symbol only.

Regards
Dipti Ranjan Tarai

Matthias Fechner wrote:
> Hi,
>
> I tried today to link a lib (.a) to my kernel module but I could not
> found howto do it.
> I prepared a little example:
> hello.c:
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/io.h>
> #include <linux/version.h>
> #include "hello_lib.h"
>
> MODULE_LICENSE("GPL");
>
> int init_module(void)
> {
>    printHello();
>    return 0;
> }
> 	   
> void cleanup_module(void)
> {
>    printk("remove module\n");
>    return;
> }
>
> hello_lib.c:
> int helloWorld(void)
> {
>    printk("Hello World\n");
>    return 0;
> }
>
> hello_lib.h:
> int helloWorld(void);
>
> Makefile:
> KDIR    := /lib/modules/$(shell uname -r)/build
> PWD := $(shell pwd)
> EXTRA_CFLAGS+=-I/usr/home/idefix/programming/kernel_hello_world_lib/
>
> obj-m := hello.o
> hello-obj := hello.o libarinc653.a
>
> all:
>         gcc -c -o hello_lib.o hello_lib.c
>         rm -f libhello_lib.a
>         ar cru libhello_lib.a hello_lib.o
>         $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
>
> Can please someone help me here?
>
> Thx a lot,
> Matthias
>
>   

