Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273754AbRI0SFZ>; Thu, 27 Sep 2001 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273755AbRI0SFP>; Thu, 27 Sep 2001 14:05:15 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50951 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273754AbRI0SFG>; Thu, 27 Sep 2001 14:05:06 -0400
Message-ID: <3BB36A6A.B0736CA2@zip.com.au>
Date: Thu, 27 Sep 2001 11:05:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ookhoi@dds.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
In-Reply-To: <20010927171818.H774@humilis>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ookhoi wrote:
> 
> Hi All,
> 
> Ingo was not aware of the sourceforge project, and suggested me to
> resend my reply to lkml. Does the patch work for you guys? Do I do
> something wrong? That would be more than possible. :-)
> 
> ...
> cuddle:~# uname -a
> Linux cuddle 2.4.9-ac15 #1 Thu Sep 27 13:54:51 CEST 2001 i686 unknown
> cuddle:~# insmod netconsole dev=eth0 target_ip=0x0a604875 source_port=6666 target_port=5555
> Using /lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o
> /lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o: init_module: Operation not permitted
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

If you're not using the eepro100 driver, then an insmod of the
netconsole driver will fail:


+       if (!ndev->poll_controller) {
+               printk(KERN_ERR "netconsole: %s's network driver does not implement netlogging yet, aborting.\n", dev);
+               return -1;
+       }

Maybe that message is in your logs somewhere?

Take a look at the poll_controller() implementation in the eepro100
part of Ingo's patch - it's dead simple.

What we need is for a bunch of people to implement poll_controller()
for *their* ethernet driver and contribute the tested diffs
back to Ingo.

-
