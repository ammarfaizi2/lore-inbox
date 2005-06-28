Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVF1Jgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVF1Jgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVF1Jgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:36:53 -0400
Received: from lucidpixels.com ([66.45.37.187]:17540 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S262020AbVF1JgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:36:18 -0400
Date: Tue, 28 Jun 2005 05:36:12 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Packet of death w/NFS+ULOGD+XFS under Kernel 2.6.x?
Message-ID: <Pine.LNX.4.63.0506280528550.18228@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following e-mail is related to the previous thread:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.2/0067.html

Recently, I was copying some images I scanned in (a good 300MB or so) with 
the following command: cp -r images /remote/disk2/share

It caused the _SAME_ lockup as my dd problems.

The weird part is as follows, once the box locks up (the remote host I am 
sending the images to), I reboot and when sets the IP interfaces up, the 
client machine (which the images) is still sending it some kind of 'death' 
packet, as you can see below:

May 14 08:51:27 localhost kernel: ipt_ULOG: error during NLMSG_PUT

I get a few of these messages and then the kernel/console freezes up.  It 
is not until I reboot or shutoff the client machine that the server can 
come up.  I actually thought it might be a ulogd issue, I tried removing 
all of the ulogd rules from my FWALL but still had freezing issues.

Has anyone had similar problems?

Syslog bootup & crash below:

May 14 08:51:26 localhost kernel: e100: eth1: e100_watchdog: link up, 
100Mbps, full-duplex
May 14 08:51:26 localhost kernel: e100: eth2: e100_watchdog: link up, 
100Mbps, full-duplex
May 14 08:51:26 localhost kernel: ipt_ULOG: error during NLMSG_PUT
May 14 08:51:26 localhost kernel: ipt_ULOG: Error building netlink message
May 14 08:51:26 localhost kernel: nfs warning: mount version older than 
kernel
May 14 08:51:26 localhost last message repeated 4 times
May 14 08:51:27 localhost kernel: process `named' is using obsolete 
setsockopt SO_BSDCOMPAT
May 14 08:51:27 localhost kernel: ipt_ULOG: error during NLMSG_PUT
May 14 08:51:27 localhost kernel: ipt_ULOG: Error building netlink message
May 14 08:51:27 localhost kernel: ipt_ULOG: error during NLMSG_PUT
May 14 08:51:27 localhost kernel: ipt_ULOG: Error building netlink message
May 14 08:51:29 localhost kernel: ipt_ULOG: error during NLMSG_PUT
May 14 08:51:29 localhost kernel: ipt_ULOG: Error building netlink message

^^ Once it gets to this point the console is locked hard, nothing will fix 
except a reboot or shutdown.

^^^ Also, until the other machine is shut off, rebooted or simply 
disconnected from the network, this one will not boot.


