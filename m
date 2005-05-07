Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVEGNTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVEGNTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVEGNTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:19:48 -0400
Received: from web60519.mail.yahoo.com ([209.73.178.167]:16013 "HELO
	web60519.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262983AbVEGNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:19:28 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lIL++jUFXvC1jp8ZH/YhFBsWw+l84fhkWVJ2kSYbsUmsZt2HDnSun8cg1VcGc65RmWNaK0YpFEHGA94ASP2PPYqi0gcccMzHos89515z9gOs6XewWOhQbyeZcpiJ9KizdYWgMQJpq1iBbGwyLXgl4coTsj5UzPdr8gTFy5hZ7lU=  ;
Message-ID: <20050507131928.10643.qmail@web60519.mail.yahoo.com>
Date: Sat, 7 May 2005 06:19:28 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: compiling "hello world" kernel module on 2.6 kernel
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a minimal hello world kernel module.
(see the Makefile and hello.c below)
But I am not able to build it using the kernel build
system.Any idea why this is happening.

I referred  "Chapter 2: Building and Running Modules"
of
http://www.oreilly.com/catalog/linuxdrive3/book/index.csp

I am using SLES9
My kernel sources are at /local/usr/linux-2.6.5-7.162
This is the kernel i am running.

On doing a make it gives me following output, but does
not build hello.o
----------------------------------------------
$ make
make -C /lib/modules/2.6.5-7.162-bigsmp/build
M=/local/usr/linux-2.6.5-7.162 modules
make[1]: Entering directory
`/local/usr/linux-2.6.5-7.162'
  Building modules, stage 2.
  MODPOST
make[1]: Leaving directory
`/local/usr/linux-2.6.5-7.162'
--------------------------------------------------
This is my Makefile:

# If KERNELRELEASE is defined, we've been invoked from
# the kernel build system and can use its language.
ifneq ($(KERNELRELEASE),)
     obj-m := hello.o

# Otherwise we were called directly from the command
# line; invoke the kernel build system.
else
     KERNELDIR ?= /lib/modules/$(shell uname -r)/build
     PWD := $(shell pwd)

default:
         $(MAKE) -C $(KERNELDIR) M=$(PWD) modules
endif
---------------------------------------------------
hello.c

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/version.h>
#include <linux/vermagic.h>

static int __init hello_init (void)
{
        printk("module hello loading");
        return 0;
}

static void __exit hello_exit (void)
{
        printk("module hello exiting");
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE ("GPL");
--------------------------------------------------


		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html

