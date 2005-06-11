Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVFKPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVFKPxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFKPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:53:41 -0400
Received: from mail.linicks.net ([217.204.244.146]:23051 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261422AbVFKPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:53:37 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org, ilan_sk@netvision.net.il
Subject: Re: 'hello world' module
Date: Sat, 11 Jun 2005 16:53:34 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111653.34161.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilan,

I don't know about the Oh Really! version, but this one taken from 'Beginning 
Linux Programming' (forward by Alan Cox!) ISBN 1-861002-97-1 worked OK for 
me.

2.4.31, GCC 3.4.4

Build like:

gcc -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -c hello.c -o 
hello.o

Edit hello.c to suit:



#include <linux/module.h>

#if defined(CONFIG_SMP)
#define __SMP__
#endif

#if defined(CONFIG_MODVERSIONS)
#define MODVERSIONS
#include <linux/modversions.h>
#endif

#include <linux/kernel.h>

MODULE_AUTHOR ("Nick Warne <nick@linicks.net>");
MODULE_DESCRIPTION ("Hello Kernel! module");
MODULE_LICENSE("GPL");

int init_module(void)
{
        printk(KERN_DEBUG "Hello, kernel!\n");
        return 0;
}

void cleanup_module(void)
{
        printk(KERN_DEBUG "Good-bye, kernel!\n");
}



bash-2.05b# insmod hello.o
bash-2.05b# dmesg | tail -n1
Hello, kernel!

bash-2.05b# lsmod
Module                  Size  Used by    Tainted: P
hello                    320   0  (unused)

bash-2.05b# rmmod hello
bash-2.05b# dmesg | tail -n1
Good-bye, kernel!



Hope that helps.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
