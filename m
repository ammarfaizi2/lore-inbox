Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWJXKz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJXKz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWJXKz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:55:28 -0400
Received: from michelle.lostinspace.de ([62.146.248.226]:64737 "EHLO
	michelle.lostinspace.de") by vger.kernel.org with ESMTP
	id S1030236AbWJXKz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:55:27 -0400
Date: Tue, 24 Oct 2006 12:55:18 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linux-kernel@vger.kernel.org
Subject: Link lib to a kernel module
Message-ID: <20061024105518.GA55219@server.idefix.loc>
Reply-To: kbuild-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG: 0x1B756EF6
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (michelle.lostinspace.de [62.146.248.226]); Tue, 24 Oct 2006 12:55:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried today to link a lib (.a) to my kernel module but I could not
found howto do it.
I prepared a little example:
hello.c:
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/io.h>
#include <linux/version.h>
#include "hello_lib.h"

MODULE_LICENSE("GPL");

int init_module(void)
{
   printHello();
   return 0;
}
	   
void cleanup_module(void)
{
   printk("remove module\n");
   return;
}

hello_lib.c:
int helloWorld(void)
{
   printk("Hello World\n");
   return 0;
}

hello_lib.h:
int helloWorld(void);

Makefile:
KDIR    := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
EXTRA_CFLAGS+=-I/usr/home/idefix/programming/kernel_hello_world_lib/

obj-m := hello.o
hello-obj := hello.o libarinc653.a

all:
        gcc -c -o hello_lib.o hello_lib.c
        rm -f libhello_lib.a
        ar cru libhello_lib.a hello_lib.o
        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

Can please someone help me here?

Thx a lot,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
