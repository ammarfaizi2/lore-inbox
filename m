Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUEOJOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUEOJOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 05:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUEOJOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 05:14:46 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:23482 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261416AbUEOJOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 05:14:44 -0400
Subject: Re: ACPI problems with 2.6.6
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200405150401.44686.dj@david-web.co.uk>
References: <200405150401.44686.dj@david-web.co.uk>
Content-Type: text/plain
Message-Id: <1084612906.29632.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 15 May 2004 11:21:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 05:01, David Johnson wrote:
> Hi,
> 
> I've got some serious strangeness being caused by ACPI on 2.6.6.
> 
> 2.6.3 works perfectly on the same machine. I don't use any acpi option on the 
> kernel command line so it's just using the default options.
> 
> The first problem is that a strange device appears as eth0:
> 
> eth0      Link encap:UNSPEC  HWaddr 
> 00-90-F5-00-00-22-91-25-00-00-00-00-00-00-00-00
>           BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 
> It seems to be some incarnation of the real ethernet adaptor, but even when I 
> manually configure it it is unable to actually talk to the network.
> I can configure the real ethernet adaptor (8139too) as eth1 with no problems.
> 
> Also, for some reason the loopback device is not added to the routing table 
> which in turn causes a stack more problems.
> Lots of other stuff also doesn't work including X.
> 
> But if I boot 2.6.3 or set acpi=off for 2.6.6 everything works perfectly. The 
> same problems exist in 2.6.5 but I haven't tried 2.6.4.
> 
> I've attached my dmesg and .config - let me know what else is needed.
> 
> Thanks,
> David.
This is not a ACPI problem. Here's the culprit:

CONFIG_IEEE1394_ETH1394=m

The IEEE1394 ethernet module is loaded and is now eth0. Tell tail sings
are the long MAC address and the Link encap. which is set to
unspecified.

Jurgen


