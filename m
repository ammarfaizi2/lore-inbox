Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVCEKLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVCEKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVCEKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:11:16 -0500
Received: from as1.cineca.com ([130.186.84.251]:26060 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S262939AbVCEKLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:11:10 -0500
Message-ID: <1110017468.422985bc70540@posta.studio.unibo.it>
Date: Sat,  5 Mar 2005 11:11:08 +0100
From: Raffaele Ianniello <raffaele.ianniello@studio.unibo.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 83.103.96.234
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem compiling a module that I am porting form 2.4 to 2.6 linux kernel.

Compiling with this Makefile:
 
DEBUG = y
 
KERNELDIR = /usr/src/linix.2.6.9
SUBDIR = $(KERNELDIR)/drivers/snoop
INCLUDEDIR = $(KERNELDIR)/include
 
obj-m := snoop.o
 
modules: $(MAKE) -C $(KERNELDIR) SUBDIR=$(SUBDIR) modules
 
clean:
        rm -f *.o
        rm -f *.ko

apperars some lines like:
***Warning: "snoop_ip_forward" [drivers/snoop/snoop] is COMMON symbol
***Warning: "snoop_ip_forward_finish" [drivers/snoop/snoop] is COMMON symbol
 
and I have insert in ip_forward.c some lines:
 
    extern int (* snoop_ip_forward_finish) (struct sk_buff *);

and this is in function ip_forward():
       if(snoop_ip_forward && (*snoop_ip_forward)(skb) == -6)
                goto drop;
 
then when I try to install the module it repyes with:
    insmod: error inserting 'snoop.ko': -1 Invalid module format

and in /var/log/message appears some lines line:
    kernel: snoop: Unknown symbol __floatsidf
    kernel: snoop: Unknown symbol __fixunsdfsi
    kernel: snoop: Unknown symbol __adddf3
    kernel: snoop: Unknown symbol __muldf3

I will be very pleased if you can help me in some way.
thank you for your time

regards,
Raffaele 

