Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUFIA3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUFIA3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUFIA3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:29:04 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:12229 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265467AbUFIA27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:28:59 -0400
Date: Tue, 8 Jun 2004 20:33:42 -0400
From: Steve Hemond <steve.hemond@sympatico.ca>
To: linux-kernel@vger.kernel.org
Subject: Inserting a module (2.6 kernel)
Message-Id: <20040608203342.2aa2522c.steve.hemond@sympatico.ca>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I am new to kernel module writing and I base myself on the Linux Device Drivers book from O'reilly. I have written this simple module :

#include <linux/module.h>

int init_module(void)
{
  printk("<1>Module inserted\n");
  return 0;
}

void cleanup_module(void)
{
  printk("<1>Module removed\n");
}

--------------------------------------------
And this is the Makefile :

KERNELDIR = /usr/src/linux

include $(KERNELDIR)/.config

CFLAGS = -D__KERNEL__ -DMODULE -I$(KERNELDIR)/include \
        -O -Wall

ifdef CONFIG_SMP
        CFLAGS += -D__SMP__ -DSMP
endif

all : moduletest.o

clean :
        rm -f *.o *~ core

---------------------------------------------

And look at this :

bash-2.05b# make
gcc -D__KERNEL__ -DMODULE -I/usr/src/linux/include -O -Wall   -c -o moduletest.o moduletest.c
bash-2.05b# insmod ./moduletest.o
insmod: error inserting './moduletest.o': -1 Invalid module format

Anyone know what needs to be added or changed for kernel 2.6, or maybe its simply my own mistake?

(By the way, if you know of a kernel-beginner mailing list that would be better suited about this, tell me)

Thanks a lot in advance,

Best regards,

Steve
