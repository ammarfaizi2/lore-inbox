Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUI3M0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUI3M0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 08:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUI3M0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 08:26:38 -0400
Received: from relay01a.ntr.oleane.net ([194.2.8.85]:28561 "EHLO
	relay01a.ntr.oleane.net") by vger.kernel.org with ESMTP
	id S269243AbUI3M0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 08:26:35 -0400
Message-ID: <415BFB7A.40709@eve-team.com>
Date: Thu, 30 Sep 2004 14:26:34 +0200
From: Frederic Dumoulin <frederic_dumoulin@eve-team.com>
Organization: EVE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: building external library under 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I succeeded to build an externel module under 2.6 with the following Makefile:

ifneq ($(KERNELRELEASE),)
obj-m		:= testKernel.o
testKernel-objs	:= $(OBJS)
else
KDIR		:= /lib/modules/$(shell uname -r)/build
PWD		:= $(shell pwd)
testKernel.ko :
	$(MAKE) -C $(KDIR) M=$(PWD) modules
endif



I made modifications in order to build a library:

ifneq ($(KERNELRELEASE),)
lib-y		:= $(OBJS)
else
KDIR		:= /lib/modules/$(shell uname -r)/build
PWD		:= $(shell pwd)
lib.a :
	$(MAKE) -C $(KDIR) M=$(PWD) modules
endif

I've just the following output:

make -C /lib/modules/2.6.8.1/build M=xxx/testKernel modules
make[1]: Entering directory `/usr/src/linux-2.6.8.1'
   Building modules, stage 2.
   MODPOST
make[1]: Leaving directory `/usr/src/linux-2.6.8.1'

I've got neither .o nor .a files

What's wrong?



Fred
