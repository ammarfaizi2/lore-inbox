Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbTGFJ3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 05:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266659AbTGFJ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 05:29:10 -0400
Received: from tag.witbe.net ([81.88.96.48]:57611 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S266655AbTGFJ3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 05:29:06 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>, <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
       <shemminger@osdl.org>, <netdev@oss.sgi.com>
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
Date: Sun, 6 Jul 2003 11:43:30 +0200
Message-ID: <008201c343a3$0f9f8a70$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3F03BC55.6050506@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
> Well, I've upgraded to the latest 2.5.74 kernel and pppd 
> version 2.4.2b3 
> (still using the rp-pppoe userspace software though).
> 
> Per Stephen's suggestion I also tried removing the ip address and 
> bringing down the ppp link before shuttind down the adsl connection.
> 
> Makes no difference.
> 
To complete on this topic : I've got the problem since 2.5.70, when
netdev_wait_allrefs has been introduced in net/core/dev.c

I have the same behavior using vtund, configured to create a tap0
interface.
At shutdown time, the interface refuses to get freed and I'm stuck.

Having vtund started at boot time (within the /etc/rc.d/... stuff)
or later doesn't make any difference.

Shutting down the interface before stopping the application or halting
the machine doesn't make any difference either.

The other problem is that the current implementation of 
netdev_wait_allrefs makes that if you kill an application that is
using a device not correctly counted, you lock the console you are
working on.
e.g., killing vtund will create a printk(... unregister_netdevice...),
and the console cannot be used anymore as long as the counter hasn't
reached 0 and the device is freed...

Paul

