Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTEHXYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTEHXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:24:51 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:59921 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262237AbTEHXYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:24:50 -0400
Subject: Re: The magical mystical changing ethernet interface order
From: Ray Lee <ray-lk@madrabbit.org>
To: jt@bougret.hpl.hp.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052437088.13561.36.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 May 2003 16:38:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
>         My belief is that configuration scripts should be specified in
> term of MAC address (or subset) and not in term of device name. Just
> like the Pcmcia scripts are doing it.

Debian already supports this, integrated into the normal scheme for
dealing with interfaces. Anyone running Debian can take a look at
/usr/share/doc/ifupdown/examples directory, the network-interfaces.gz
file contains sample /etc/network/interfaces stanzas for configuring
your interfaces via MAC address:

	auto eth0 eth1
	mapping eth0 eth1
		script /path/to/get-mac-addr.sh
		map 11:22:33:44:55:66 lan
		map AA:BB:CC:DD:EE:FF internet
	iface lan inet static
		address 192.168.42.1
		netmask 255.255.255.0
		pre-up /usr/local/sbin/enable-masq $IFACE
	iface internet inet dhcp
		pre-up /usr/local/sbin/firewall $IFACE

You can even do something like:

	iface wireless inet dhcp
		wireless_key 12345678901234567890123456

A sample get-mac-address.sh is in the same directory, though it has a
typo (missing a close paren -- I need to report that...). This same
scheme works for pinging some well-known host to determine where you
are, or using ARPs, or whatever. I use it on my laptop with PCMCIA
cards, works great.

Ray

