Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUJBFOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUJBFOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUJBFOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 01:14:11 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6003 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S267283AbUJBFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 01:14:05 -0400
Date: Sat, 02 Oct 2004 01:13:54 -0400
From: Andre Bonin <kernel@bonin.ca>
Subject: Module building oddities with <module>-objs under Kernel 2.6.8.1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <415E3912.3000900@bonin.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2)
 Gecko/20040803
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
I have a simple module in datasim.c and several service functions in 
another file status.c

The module compiles fine (no warnings) with the following Makefile, but 
the printk function doesn't seem to output anything.  The output doesn't 
show with dmesg, tail -f /var/message and everything else I tried.

The same code works fine if copy-pasted inside the datasim.c module (and 
not compiled using datasim-objs: in the makefile).  It also works fine 
if i do the ugly thing of (*shudder*)  #include "status.c"

/usr/bin/nm datasim.ko yields "U    printk".

I know the entry points get called properly because the module is 
loaded, and functions after the printk's that set up sysfs attributes 
are successfull (and appear under sysfs).

I find it odd that if i compile with the datasim-objs stuff that i can't 
view the printk, but if i comment it out and do #include "datasim.c" it 
works fine. 

Thanks

Here is the Makefile.
----------------------------------------------------
KDIR         := /usr/src/linux
PWD          := $(shell pwd)

obj-m        += datasim.o
datasim-objs := status.o

all:
    $(MAKE) -C $(KDIR) SUBDIRS=$(PWD)

clean:
    rm -rf *.o
    rm -rf *.ko
    rm -rf *.mod.c
    rm -rf .datasim*
    rm -rf .built-in.o.cmd
    rm -rf *~
    rm -rf *.cache
    sudo rm -rf .tmp_versions
install:
    sudo /sbin/insmod datasim.ko
uninstall:
    sudo /sbin/rmmod datasim.ko
TAGS:
    etags *.c   





