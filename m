Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVANTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVANTpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVANTpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:45:20 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:32445 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262061AbVANTow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:44:52 -0500
Message-ID: <41E82129.3020403@candelatech.com>
Date: Fri, 14 Jan 2005 11:44:41 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jyri.poldre@artecdesign.ee
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver link state propagation to ip stack
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
In-Reply-To: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jüri Põldre wrote:
> All,
> 
> I am experiencing issues with connecting two network adapters to the same
> subnet, eg.
> 
> eth0 192.168.100.200
> eth1 192.168.100.201
> 
> The task is to have redundant connections to two different hubs. In case one
> link goes down the connection should go through the other. The driver
> handles link events with netif_carrier_ok and netif_carrier_on from
> linux/netdevice.h. These eventually send messages to networking stack with
> netdev_change_state from net/core/dev.c
> 
> My question is:  Does the kernel handle  the interface state/routing tables
> modifications due to link changing automatically or is there some external
> daemon required to do that. Any links are greatly appreciated.

As far as I know, you have to handle this sort of thing in user-space.  You may
also have ARP issues with having two interfaces on the same subnet.  Often people
will use two private, non-related IP addresses and then migrate a virtual IP back
and forth, placing it on the preferred (ie, link-ok) interface.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

