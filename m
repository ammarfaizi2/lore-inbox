Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbTLIUTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbTLIUS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266109AbTLIUPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:36 -0500
Date: Tue, 9 Dec 2003 11:39:33 -0800
From: "David S. Miller" <davem@redhat.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/net/ipv4/config/eth0/arp_filter not working?
Message-Id: <20031209113933.32e28db0.davem@redhat.com>
In-Reply-To: <20031209145847.GA10652@codeblau.de>
References: <20031209145847.GA10652@codeblau.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003 15:58:47 +0100
Felix von Leitner <felix-kernel@fefe.de> wrote:

> According to the documentation I found, the kernel (2.6.0-test11) should
> not answer ARP requests for the lo alias if I write 1 to
> /proc/sys/net/ipv4/config/eth0/arp_filter, and to be on the safe side, I
> also wrote 1 to /proc/sys/net/ipv4/config/lo/arp_filter.  However, the
> kernel still answers the ARP requests.

Read the documentation again more clearly:

====================
arp_filter - BOOLEAN
        1 - Allows you to have multiple network interfaces on the same
        subnet, and have the ARPs for each interface be answered
        based on whether or not the kernel would route a packet from
        the ARP'd IP out that interface (therefore you must use source
        based routing for this to work). In other words it allows control
        of which cards (usually 1) will respond to an arp request.
====================

This is telling you that you need to set up your routes correctly
in order for the ARP packets to be filtered the way you want.

The decision to block ARP packets is not just based upon this sysctl
value, it is instead made if this sysctl value is set _AND_ the routes
indicate that we would not use this device for a route to reach that
destination which is trying to be resolved by the ARP request.

