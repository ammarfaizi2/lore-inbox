Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHUTYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHUTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUHUTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:24:16 -0400
Received: from [138.15.108.3] ([138.15.108.3]:49123 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S267678AbUHUTYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:24:14 -0400
Message-ID: <4127A15C.1010905@nec-labs.com>
Date: Sat, 21 Aug 2004 15:24:12 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems compiling kernel modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2004 19:24:04.0190 (UTC) FILETIME=[6B935FE0:01C487B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was trying to compile a kernel module with kbuild. The module 'test.c' 
include a header file 'fred.h' and there is a "#include <stdio.h>" in 
'fred.h'.

Makefile looks like:

------------------------------------------------------------------------
ifneq ($(KERNELRELEASE),)
obj-m       := test.o

else
KDIR        := /usr/src/linux
PWD         := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
	

clean:
	rm -f *.o *.ko *.mod.c *.mod.o \
	.test.o.cmd .test.ko.cmd .test.mod.o.cmd
	rm -rf .tmp_versions
endif

-------------------------------------------------------------------------
But upon compiling, there would be errors like this:
In file included from /home/lei/test.c:49:
/home/lei/fred.h:4:19: stdio.h: No such file or directory

and a lot of undeclared names follow which I assume is from stdio.h.

Could anyone point out what's wrong here?

TIA!

Lei
