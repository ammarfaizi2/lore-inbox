Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTEJH3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTEJH3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:29:38 -0400
Received: from [81.91.1.49] ([81.91.1.49]:49623 "HELO mars.mj.nl")
	by vger.kernel.org with SMTP id S263671AbTEJH3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:29:37 -0400
Subject: Re: The magical mystical changing ethernet interface order
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1052552525.1893.35.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 May 2003 09:42:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> Jean Tourrilhes wrote:
>>         My belief is that configuration scripts should be specified in
>> term of MAC address (or subset) and not in term of device name. Just
>> like the Pcmcia scripts are doing it.
>
> Debian already supports this, integrated into the normal scheme for
> dealing with interfaces.

Yes.  Note that the names 'lan' and 'internet' in the example
are name of possible configurations, not "physical" interface names.
They are only used by the ifupdown package; they do not show up
in an "ifconfig" listing.  Thus, doing "ifup eth0=home-wireless-1"
brings up interface eth0 in the home-wireless-1 configuration.
What implements the ability to work in terms of MAC addresses is the
mapping script /path/to/get-mac-addr.sh.  When, e.g., eth0 comes up,
get-mac-addr.sh scans for the MAC address and outputs either the
name 'lan' or the name 'internet'; ifupdown then configures eth0
with either the "lan" configuration or the "internet" configuration.

(The configurations are called "logical interfaces" in the ifupdown
documentation.)

>	auto eth0 eth1
>	mapping eth0 eth1
>		script /path/to/get-mac-addr.sh
>		map 11:22:33:44:55:66 lan
>		map AA:BB:CC:DD:EE:FF internet
>	iface lan inet static
>		address 192.168.42.1
>		netmask 255.255.255.0
>		pre-up /usr/local/sbin/enable-masq $IFACE
>	iface internet inet dhcp
>		pre-up /usr/local/sbin/firewall $IFACE

-- 
Thomas Hood <jdthood@yahoo.co.uk>

