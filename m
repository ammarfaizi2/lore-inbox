Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTFQV75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTFQV75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:59:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15791 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264933AbTFQV7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:59:55 -0400
Subject: borked sysfs system devices in 2.5.72
From: Dave Hansen <haveblue@us.ibm.com>
To: mochel@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055887929.24118.6.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 15:12:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The per-node numa meminfo files in 2.5.72 are broken, the only display
node0's information.  The devices are being properly registered:
Registering sys device 'node0':c0423844 id:0 kobj:c042384c
Registering sys device 'node1':c0423888 id:1 kobj:c0423890
Registering sys device 'node2':c04238cc id:2 kobj:c04238d4
Registering sys device 'node3':c0423910 id:3 kobj:c0423918

When I look at the 4 nodes files with:
"cat /sys/devices/system/node/*/meminfo", I printed out some
information:
subsys_attr_show(kobj: c042384c, attr: c033ea30, page: e76ba000)
subsys_attr_show(kobj: c0423890, attr: c033ea30, page: e76ba000)
subsys_attr_show(kobj: c04238d4, attr: c033ea30, page: e76ba000)
subsys_attr_show(kobj: c0423918, attr: c033ea30, page: e76ba000)

As you can see, the kobj is the one which belongs to the sys device, yet
you do a to_subsys() on it.  Why?
struct subsystem * s = to_subsys(kobj);

I'm getting a 0 as the node ID out of pure dumb luck.  Is the NUMA code
broken or is sysfs?

-- 
Dave Hansen
haveblue@us.ibm.com

