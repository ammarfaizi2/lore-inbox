Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTISQMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbTISQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:12:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:47080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbTISQM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:12:29 -0400
Date: Fri, 19 Sep 2003 09:12:04 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test problems loading network drivers
Message-Id: <20030919091204.3a5e1c0c.shemminger@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309172010410.1856-600000@localhost.localdomain>
References: <Pine.LNX.4.44.0309172010410.1856-600000@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Sep 15 22:02:58 localhost cardmgr[1482]: socket 0: Intersil PRISM2 11 Mbps Wireless Adapter
> Sep 15 22:02:58 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
> Sep 15 22:02:58 localhost cardmgr[1482]: executing: 'modprobe hermes'
> Sep 15 22:02:58 localhost cardmgr[1482]: executing: 'modprobe orinoco'
> Sep 15 22:02:58 localhost cardmgr[1482]: executing: 'modprobe orinoco_cs'
> Sep 15 22:02:58 localhost cardmgr[1482]: executing: './network start eth0'
> Sep 15 22:02:58 localhost /etc/hotplug/net.agent: NET add event not supported
> Sep 15 22:03:45 localhost login(pam_unix)[1783]: session closed for user root
> Sep 15 22:03:50 localhost login(pam_unix)[1894]: session opened for user tmolina by (uid=0)

network hotplug changed slightly in 2.6 so the kernel passes: 'add' instead of 'register'
to the scripts.  This is because network devices are kobjects and go through the generic
hotplug path.

The fix is:
--- /etc/hotplug/net.agent.old	2003-09-19 09:10:06.390819425 -0700
+++ /etc/hotplug/net.agent	2003-09-19 09:10:34.545620648 -0700
@@ -26,7 +26,7 @@
 fi
 
 case $ACTION in
-register)
+add|register)
     # Don't do anything if the network is stopped
     if [ ! -f /var/lock/subsys/network ]; then
 	exit 0
