Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423392AbWJYMaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423392AbWJYMaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423390AbWJYMaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:30:17 -0400
Received: from michelle.lostinspace.de ([62.146.248.226]:24307 "EHLO
	michelle.lostinspace.de") by vger.kernel.org with ESMTP
	id S1423385AbWJYMaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:30:15 -0400
Date: Wed, 25 Oct 2006 14:30:05 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Link lib to a kernel module
Message-ID: <20061025123004.GB86838@server.idefix.loc>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061024105518.GA55219@server.idefix.loc> <453DF507.8050101@innomedia.soft.net> <453EA343.2080504@fechner.net> <453EFA4C.9000502@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453EFA4C.9000502@innomedia.soft.net>
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
X-GnuPG: 0x1B756EF6
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (michelle.lostinspace.de [62.146.248.226]); Wed, 25 Oct 2006 14:30:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dipti,

* Dipti Ranjan Tarai <dipti@innomedia.soft.net> [25-10-06 11:16]:
> Now in mod2 call test_export() of mod1, compile it and load the module u 
> can able to access test_export().

thx for that hint, but I want one module :)

I was now successfull with the following code:
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
