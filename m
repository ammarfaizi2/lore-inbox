Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267470AbUHaUOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUHaUOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269094AbUHaUMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:12:33 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:45976 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269133AbUHaUHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:07:45 -0400
From: Duncan Sands <baldrick@free.fr>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: external modules make clean doesn't do much
Date: Tue, 31 Aug 2004 22:07:44 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408311347.52754.baldrick@free.fr> <20040831170148.GB7310@mars.ravnborg.org>
In-Reply-To: <20040831170148.GB7310@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408312207.44769.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 19:01, Sam Ravnborg wrote:
> On Tue, Aug 31, 2004 at 01:47:52PM +0200, Duncan Sands wrote:
> > make clean for an external module only seems to clean
> > .tmp_versions:
> > 
> > $ make clean
> > make -C /lib/modules/2.6.9-rc1/build M=`pwd` clean
> > make[1]: Entering directory `/home/duncan/Linux/linux-2.5'
> >   CLEAN   /home/duncan/SpeedTouch/.tmp_versions
> > make[1]: Leaving directory `/home/duncan/Linux/linux-2.5'
> > $
> > 
> > This leaves all the .o etc files which doesn't sound right...
> Nope - let me try.
> 
> sam@mars rtl8180 $ ls *o
> built-in.o   r8180_if.o        rtl8180.ko     rtl8180.o
> priv_part.o  r8180_pci_init.o  rtl8180.mod.o  usercopy.o
> sam@mars rtl8180 $ make -C ~/bk/kbuild M=$PWD clean
> make: Entering directory `/home/sam/bk/kbuild'
>   CLEAN   /home/sam/bk/external/rtl8180/.tmp_versions
> make: Leaving directory `/home/sam/bk/kbuild'
> sam@mars rtl8180 $ ls *o
> ls: *o: No such file or directory
> sam@mars rtl8180 $ cat Makefile
> obj-m           := rtl8180.o
> rtl8180-y       += r8180_if.o r8180_pci_init.o usercopy.o
> rtl8180-y       += priv_part.o
>   
> 
> Looks to be OK here.
> Please let me see the Makefile you use for SpeedTouch

Hi Sam, thanks for looking into this.  Here it is:

KERNELDIR  := /lib/modules/$(shell uname -r)/build

obj-m := speedtch.o

all clean help modules modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) $(filter-out all,$(MAKECMDGOALS))

install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
