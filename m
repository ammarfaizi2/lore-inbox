Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSLUUMl>; Sat, 21 Dec 2002 15:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLUUMl>; Sat, 21 Dec 2002 15:12:41 -0500
Received: from smtp.comcast.net ([24.153.64.2]:10645 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S264630AbSLUUMk>;
	Sat, 21 Dec 2002 15:12:40 -0500
Date: Sat, 21 Dec 2002 15:25:50 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Help me get up to speed, please.
To: linux-kernel@vger.kernel.org
Message-id: <1040502350.32170.4.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel crew,

I sent this message to linux-net@vger.kernel.org but that mailing list
appears to be rather inactive compared to this one.  As I've mentioned
below, I'm new to linux kernel- programming.  I've used linux for years,
mainly because I love how easy it is to do all sorts of cool networking
things.  I would really like to get involved with linux kernel
programming, but first I'm going to need to get up to speed with a few
things.  I'd like to learn the linux networking stacks inside and out. 
So, I posted the message below to the linux-net mailing list.  Please
forgive me if you are a member of both that list and this one and are
therefore getting two copies.  Please lend any help you can.

Thanks,
	Josh


-----------------------------------------------------------

I'm new to this mailing list, and to linux kernel programming.  I'm
trying to get a really good grasp on what happens to packets from when
they arrive until they are pushed to user-space applications.  For now
I'm just assuming I am receiving a TCP packet.

I've read almost all the online docs I can find, but most don't get down
and dirty enough for what I'm trying to figure out.  For example,
http://www.gnumonks.org/ftp/pub/doc/packet-journey-2.4.html.  I also
have troubles with running into docs referring to the 2.0 or 2.2 kernels
and interrupt bottom halves, which it seems are not in the 2.4 network
code (softirqs instead).

I'd like to create a list of the functions (in order) that are called
from the time of sk_buff creation/allocation until the buffer is free'd
(kfree_skb).  I'd really like to track an sk_buff throughout it's
'lifespan' in the linux kernel.  So far I think I understand the
following, which isn't much...

Linux network drivers all register themselves with the kernel through a
register_netdev() call.  Lots of structures are allocated and
initialized.  It seems that most sk_buffs come into existence during an
interrupt routine in a NIC card driver (i.e.
/usr/src/linux/drivers/net/pci-skeleton.c, netdrv_rx_interrupt()), which
does the following...

netif_rx(skb) is called, which performs the following...

__skb_queue_tail(&queue->input_pkt_queue,skb); dev.c, line 1255

which puts the sk_buff into the incoming packet queue of one of the
processors, which is really a member of the softnet_data[] array.

>From this point on, I have no idea what happens to the packet.  I know
it has something to do with 2.4's new softirqs, but I don't really have
a good grasp on that yet.

Please help me fill in where my knowledge is lacking.  Also, PLEASE
correct any mistakes you see in my understanding so far.

Thanks,
        Joshua Stewart

joshua.stewart@comcast.net


