Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTFQWKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTFQWKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:10:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51639 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264959AbTFQWKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:10:36 -0400
Date: Tue, 17 Jun 2003 15:26:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: borked sysfs system devices in 2.5.72
In-Reply-To: <1055887929.24118.6.camel@nighthawk>
Message-ID: <Pine.LNX.4.44.0306171519260.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Jun 2003, Dave Hansen wrote:

> The per-node numa meminfo files in 2.5.72 are broken, the only display
> node0's information.  The devices are being properly registered:
> Registering sys device 'node0':c0423844 id:0 kobj:c042384c
> Registering sys device 'node1':c0423888 id:1 kobj:c0423890
> Registering sys device 'node2':c04238cc id:2 kobj:c04238d4
> Registering sys device 'node3':c0423910 id:3 kobj:c0423918
> 
> When I look at the 4 nodes files with:
> "cat /sys/devices/system/node/*/meminfo", I printed out some
> information:
> subsys_attr_show(kobj: c042384c, attr: c033ea30, page: e76ba000)
> subsys_attr_show(kobj: c0423890, attr: c033ea30, page: e76ba000)
> subsys_attr_show(kobj: c04238d4, attr: c033ea30, page: e76ba000)
> subsys_attr_show(kobj: c0423918, attr: c033ea30, page: e76ba000)
> 
> As you can see, the kobj is the one which belongs to the sys device, yet
> you do a to_subsys() on it.  Why?
> struct subsystem * s = to_subsys(kobj);

Where exactly is that happening? 

> I'm getting a 0 as the node ID out of pure dumb luck.  Is the NUMA code
> broken or is sysfs?

It's taking the ID from the system device of the node that's passed to 
->show(). That is set in register_node(), so I'm not sure how they could 
get out of sync, unless I'm missing something obvious. 

BTW, I did request that the NUMA topology people take a look at these 
patches when I sent them a couple of weeks ago, so as to avoid this. :) 



	-pat

