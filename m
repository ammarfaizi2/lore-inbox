Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTACXul>; Fri, 3 Jan 2003 18:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTACXul>; Fri, 3 Jan 2003 18:50:41 -0500
Received: from smtp.comcast.net ([24.153.64.2]:5052 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267725AbTACXuW>;
	Fri, 3 Jan 2003 18:50:22 -0500
Date: Fri, 03 Jan 2003 19:08:36 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Tracing TCP/IP packets from NIC to TCP
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1041638921.5190.22.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've asked questions on this topic in the previous e-mails Subj:"Help me
get up to speed, please" and Subj:"From __cpu_raise_softirq() to
net_rx_action()".  I understand the packet flow from the NIC all the way
to the ip_rcv() function (and a little further).  So, maybe somebody can
fill in another little gap for me.

ip_rcv() call NF_HOOK( PF_INET, NF_IP_PRE_ROUTING, skb, dev, NULL,
ip_rcv_finish) which checks all netfilter hooks that are currently
registered in the PREROUTING hook.  All packets that are accepted by
these hook functions get passed to the ip_rcv_finish() function.  In
ip_rcv_finish, we call ip_route_input() which sets skb->dst.  Then
ip_rv_finish() returns skb->dst->input(skb).

I don't understand enough about the kernel's routing mechanisms to
figure out how these packets (sk_buffs) make their way to the tcp
stack.  Can somebody fill me in on exactly what the skb->dst structure
does and where the rt_hash_table array gets setup.  If I could just
follow this sk_buff until I start hitting code from tcp.c I'd be more
than satisfied.

Thanks,
   Josh



