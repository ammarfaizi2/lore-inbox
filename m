Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUI3OAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUI3OAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUI3N77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:59:59 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:25098 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S269272AbUI3N7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:59:12 -0400
Message-ID: <31920.194.237.142.24.1096552751.squirrel@194.237.142.24>
In-Reply-To: <415BFB7A.40709@eve-team.com>
References: <415BFB7A.40709@eve-team.com>
Date: Thu, 30 Sep 2004 15:59:11 +0200 (CEST)
Subject: Re: building external library under 2.6
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Frederic Dumoulin" <frederic_dumoulin@eve-team.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I succeeded to build an externel module under 2.6 with the following
> Makefile:
>
> ifneq ($(KERNELRELEASE),)
> obj-m		:= testKernel.o
> testKernel-objs	:= $(OBJS)
> else
> KDIR		:= /lib/modules/$(shell uname -r)/build
> PWD		:= $(shell pwd)
> testKernel.ko :
> 	$(MAKE) -C $(KDIR) M=$(PWD) modules
> endif
Look ok except the way you use testKernel.ko.
Much better to use all: since this will not conflict
with a potential output file.

>
> I made modifications in order to build a library:
>
> ifneq ($(KERNELRELEASE),)
> lib-y		:= $(OBJS)
> else
> KDIR		:= /lib/modules/$(shell uname -r)/build
> PWD		:= $(shell pwd)
> lib.a :
> 	$(MAKE) -C $(KDIR) M=$(PWD) modules
> endif

Try wil all: as replacement for lib.a:
It should cure things.

No access to Linux box atm so I cannot check.

   Sam


