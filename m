Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUGUR0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUGUR0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUGUR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:26:53 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:32518 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266547AbUGUR0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:26:50 -0400
Date: Wed, 21 Jul 2004 21:27:27 +0200
From: sam@ravnborg.org
To: Idan Spektor <idan@imperva.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: module name is KBUILD_MODNAME
Message-ID: <20040721192727.GA9188@mars.ravnborg.org>
Mail-Followup-To: Idan Spektor <idan@imperva.com>, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <96242ACDF1723A4BBF70D21211FB9B23063690@shrek.webcohort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96242ACDF1723A4BBF70D21211FB9B23063690@shrek.webcohort.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 10:05:33AM +0200, Idan Spektor wrote:
> Here is the makefile I am using to create the .ko
> object. Please notice that I compile my objects
> by myself in a different makefile and only then
> use the kbuild infrastructure.
This may be a source of many problem in the future.
I advise you to use kbuild.

Try sending me ls -R in a clean tree,
your current Makefile or eventueally the src.
Then I will try to guide you.

> makefile:
>    
> ifeq ($(KERNELRELEASE),)
> 
> PWD		:= /home/idan/my_module
> KDIR	:= /usr/src/linux-$(shell uname -r)/
> 
> default:
> 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> 
> else
> 
> obj-m	:= my_module.o
> my_module-objs := my_module_main.o
> 
> $(PWD)/my_module_main.o:
> 	echo do nothing
> 
> endif

The above should not result in the error you describe.
KBUILD_MODNAME is defined to the name of the module
when compiling my_module.mod.c.
Take a look at the output when you use the V=1 option when running make.
If you do not see something like:

$> make -C ~/bk/mars O=~/o M=$PWD V=1
...
	  gcc -Wp,-MD,/home/sam/bk/external/sam/.sam.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/sam/bk/mars/include  -I/home/sam/bk/external/sam -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -msoft-float -mpreferred-stack-boundary=2 -march=pentium3 -I/home/sam/bk/mars/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer -Wdeclaration-after-statement -I/home/sam/bk/mars/ -I /home/sam/bk/external/sam/include -DMODULE -DKBUILD_BASENAME=sam -DKBUILD_MODNAME=sammy -c -o /home/sam/bk/external/sam/sam.o /home/sam/bk/external/sam/sam.c

...

[file is named sam.o, module is named sammy]

Then there is something wrong. You should see -DKBUILD_MODNAME=my_module

	Sam
