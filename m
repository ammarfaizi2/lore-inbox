Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUFKPn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUFKPn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUFKPn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:43:59 -0400
Received: from [202.125.86.130] ([202.125.86.130]:64137 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264067AbUFKPn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:43:56 -0400
Subject: Problem in module loading automatically at boot time
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 11 Jun 2004 21:14:41 +0530
Content-class: urn:content-classes:message
Message-ID: <1118873EE1755348B4812EA29C55A9722AF3A5@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem in module loading automatically at boot time
Thread-Index: AcRPywKPWT4M+sA7TrGtzHCLygPw9w==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Surendra I." <surendrai@esntechnologies.co.in>,
       "Subramanyam B" <subramanyamb@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have written a small driver program called hello.c.

************************************************************************
***************
#include <linux/module.h>

MODULE_LICENSE("GPL");

int init_module(void)
{
  printk("<1>" "Hello world\n");
  return 0;
}

void cleanup_module(void)
{
  printk("<1>good bye\n");
}

************************************************************************
****************

I compiled the above program with cc -DMODULE -D__KERNEL__
-I/usr/src/linux2.4/include -O2 -c hello.c

I am using Red Hat Linux 7.3 with kernel version of 2.4.18-3.
It works fine when I load it with insmod from root prompt.

Now, I want to make it load automatically at boot time. 
For that I have used the following steps.

---> I copied the hello.o file in the
/lib/modules/2.4.18-3/kernel/drivers/block

---> I run the depmod command. It included the above path in
/lib/modules/2.4.18-3/modules.dep file.

---> I added "alias hello1 hello" entry into /etc/modules.conf file.

When I reboot the machine after the above changes, my driver is not
loaded and an error message is printed as follows.

---> depmod: *** Unresolved symbols in
/lib/modules/2.4.18-3/kernel/drivers/block/hello.o


Could anyone suggest me, if I am missing anything here?

Srinivas G


