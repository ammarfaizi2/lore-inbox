Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUGBOCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUGBOCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGBOCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:02:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264560AbUGBOCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:02:10 -0400
Date: Fri, 2 Jul 2004 10:01:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Vladislav Bolkhovitin <vst@vlnb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dependant modules question
In-Reply-To: <40E556E5.90708@vlnb.net>
Message-ID: <Pine.LNX.4.53.0407020952270.3789@chaos>
References: <40E556E5.90708@vlnb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004, Vladislav Bolkhovitin wrote:

> Hello,
>
> I need some assistance with the kernel build system. It looks like this
> topic is not covered anywhere, at least I didn't find anything.
>
> I have two modules, A and B, where B is dependant from A, i.e. uses some
> exported from it symbols. Both modules are built outside of the kernel
> tree.
>
> With A everything is fine, it's compiled and installed with other kernel
> modules in /lib/modules/2.6.7/extra.
>
> Then module B is built. Here I have a problem. Module A is not listed as
> the module from which B depends in .mod.c file, therefore there are
> "Undefined symbols" warnings and it is impossible to load B, even though
> A is loaded.
>
> So, the question is: what should I do to make A be seen as exporting
> some symbols by the kernel and its build system?
>
> The kernel is 2.4.7, EXPORT_SYMBOL() used in A as required.
>
> Thanks,
> Vlad

Did you execute `depmod -a` after putting your modules into the
default  directories and their information into /etc/modules.conf ?

Example:
/etc/modules.conf
alias char-major-177  module-a		# First to load
alias char-major-177  module-b		# Second to load
alias char-major-177  off		# All done


# cp module-a.o /lib/modules/`uname -r`/kernel/drivers/char
# cp module-b.o /lib/modules/`uname -r`/kernel/drivers/char
# depmod -a

The first time anybody tries to access a device with the major
number of 177, its modules will be loaded in the correct order
by modprobe.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


