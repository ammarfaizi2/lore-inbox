Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTHSOmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHSOmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:42:17 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:38124 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S270627AbTHSOjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:39:18 -0400
Date: Tue, 19 Aug 2003 16:39:16 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: IPv6 problems with 2.4.21 - Loosing address.
Message-ID: <Pine.LNX.4.51.0308191633040.26164@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed weird problems with the eth interface loosing its address.
The kernel is 2.4.21-xfs-ow1 and is an IPv6 router with a sit0 to tunnel
to the broker on one side, and normal ethernet on the other.

After I set the interfaces up:

# set the tunneling interface up
ip link set sit0 up

# set the addresses
ip addr add 3ffe:8320:1::57 dev eth1
ip addr add 3ffe:8320:2:18::57 dev eth1

# Setting up routing to my network
ip route add 3ffe:8320:2:18::/64 dev eth1

# Setting up the deafult route
ip route add 2000::/3 via ::150.254.166.157 dev sit0


After some time, the connectivity dies and when i check:
# ip addr show and route -A inet6
it shows that both of the addresses are gone, and the route to my net is
gone. Only the default IPv6 route is left.

Setting the addresses and the route up again fixes the case for about 4
minutes.

Might this be a known bug in the kernel?

Regards,
Maciej

