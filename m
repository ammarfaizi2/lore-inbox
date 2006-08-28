Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWH1U1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWH1U1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWH1U1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:27:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23788
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751476AbWH1U1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:27:14 -0400
Date: Mon, 28 Aug 2006 13:27:17 -0700 (PDT)
Message-Id: <20060828.132717.57158097.davem@davemloft.net>
To: akpm@osdl.org
Cc: miles.lane@gmail.com, dcbw@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jeremy@goop.org, rml@novell.com
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an
 "eth" device name
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060828120328.ae734de0.akpm@osdl.org>
References: <20060827.003800.95504796.davem@davemloft.net>
	<a44ae5cd0608280852p50e72241vff8e3ae101e94185@mail.gmail.com>
	<20060828120328.ae734de0.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 12:03:28 -0700

> grepping for `ioctl' gives:
> 
> ioctl(9, SIOCGIWNAME, 0xbfe38d8c)                 = -1 EINVAL (Invalid argument)
> ioctl(9, SIOCETHTOOL, 0xbfe38d2c)                 = 0
> ioctl(11, SIOCGIFHWADDR, {ifr_name="eth0", ???})  = -1 ENODEV (No such device)
> ioctl(11, SIOCGIFFLAGS, {ifr_name="eth0", ???})   = -1 ENODEV (No such device)
> 
> Perhaps you could generate the strace output for 2.6.18-rc5, grep that for
> ioctl, look for differences?  That initial SIOCGIWNAME failure is fishy.

That might help, but SIOCGIWNAME just gets a string that
says what wireless mode the device is in, not the device
name.  Althought NetworkManager might use this for something
interesting.

All of the interesting config calls are probably happening
via netlink, which doesn't get decoded by strace.

But changes via netlink can get traced by using "ip" in monitor mode,
try "ip monitor all" as root during such a NetworkManager run.
