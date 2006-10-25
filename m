Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423377AbWJYM0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423377AbWJYM0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423384AbWJYM0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:26:45 -0400
Received: from michelle.lostinspace.de ([62.146.248.226]:8920 "EHLO
	michelle.lostinspace.de") by vger.kernel.org with ESMTP
	id S1423377AbWJYM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:26:44 -0400
Date: Wed, 25 Oct 2006 14:26:10 +0200
From: Matthias Fechner <idefix@fechner.net>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Link lib to a kernel module
Message-ID: <20061025122609.GA86838@server.idefix.loc>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20061024105518.GA55219@server.idefix.loc> <slrnejs14h.93p.olecom@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnejs14h.93p.olecom@flower.upol.cz>
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
X-GnuPG: 0x1B756EF6
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (michelle.lostinspace.de [62.146.248.226]); Wed, 25 Oct 2006 14:26:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

* Oleg Verych <olecom@flower.upol.cz> [24-10-06 12:11]:
> `Documentation/kbuild' directory in your linux sources.
> `makefiles.txt' about `lib-y',
> `modules.txt'   about modules.

I was now successfull with:
hello_lib.h:
int printHello(int);

hello_lib.c
int printHello(int count)
{
   int i;
      
   for(i=0;i<=count;i++)
   {
       printk("Hello World\n");
   }
   return 0;
}
			   
hello.c:
#include <linux/kernel.h>
#include <linux/module.h>
#include "hello_lib.h"
   
MODULE_LICENSE("GPL");
			   
int init_module(void)
{
    printk("call function\n");
    printHello(5);
    return 0;
}
				    
void cleanup_module(void)
{
    printk(KERN_INFO "remove module\n");
    return;
}
					  
Makefile:
KDIR    := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

obj-m += test.o
test-y := hello.o libhello_lib.a

all:
   gcc -I/usr/include -c -o hello_lib.o hello_lib.c
   rm -f libhello_lib.a
   ar cru libhello_lib.a hello_lib.o
   $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules KBUILD_VERBOSE=1
	      


Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
