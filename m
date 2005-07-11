Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVGKVtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVGKVtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVGKVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:47:19 -0400
Received: from li4-142.members.linode.com ([66.220.1.142]:13 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S262786AbVGKVpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:45:13 -0400
Date: Mon, 11 Jul 2005 17:43:59 -0400
From: Michael B Allen <mba2000@ioplex.com>
To: "Jar" <jar@pcuf.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prism 2.5 MiniPCI Wireless Unstable
Message-Id: <20050711174359.6de1f4df.mba2000@ioplex.com>
In-Reply-To: <1118.192.168.0.150.1121090918.squirrel@kone>
References: <1108.192.168.0.150.1121089967.squirrel@kone>
	<1118.192.168.0.150.1121090918.squirrel@kone>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 17:08:38 +0300 (EEST)
"Jar" <jar@pcuf.fi> wrote:
> 
> > FYI:
> >
> > Please use more suitable driver for 802.11b Prism cards. This kind of driver is
> > hostap_pci (for PCI cards). It can be downloaded from http://hostap.epitest.fi/
> >
> > This driver really works for Prism2/2.5/3 cards!
> 
> Sorry about this spam, I didn't read your mail in LKML properly. You already have
> used hostap in the past :)
> 
> Still I think the hostap_pci is the best driver for Prism2/2.5/3 cards. I have one
> Prism2.5 PCI card in daily & heavy use as access point. The card becomes 100% stable
> after I updated it's primary and station firmawares (PRI 1.0.0 --> 1.1.1, STA
> 1.4.9-->1.7.4). There have been a lot of development after 2.4 days in hostap
> driver. I use the latest and greatest 0.3.9 version :)

Better. With the hostap_pci driver, after 2 and a half tries, I managed to
get the backup to complete. But I still get lots of errors along the way:

Jul 11 16:29:42 quark kernel: NETDEV WATCHDOG: wifi0: transmit timed out
Jul 11 16:29:42 quark kernel: wifi0 Tx timed out! Resetting card
Jul 11 16:29:43 quark kernel: hostap_pci: wifi0: resetting card
Jul 11 16:30:13 quark last message repeated 2 times
Jul 11 16:30:28 quark kernel: NETDEV WATCHDOG: wifi0: transmit timed out
Jul 11 16:30:28 quark kernel: wifi0 Tx timed out! Resetting card
Jul 11 16:30:29 quark kernel: hostap_pci: wifi0: resetting card
Jul 11 16:31:03 quark last message repeated 2 times
Jul 11 16:31:18 quark kernel: NETDEV WATCHDOG: wifi0: transmit timed out
Jul 11 16:31:18 quark kernel: wifi0 Tx timed out! Resetting card
Jul 11 16:31:19 quark kernel: hostap_pci: wifi0: resetting card
...

With the hostap_pci driver, the first time I tried to run the backup
(rsync over ssh from workstation next to AP to T30 w/ prism card)
my machine locked up after about 15 minutes. After rebooting, running
fsck, and moving close to the AP I stopped X and tried to run it on
virtual consoles. After about 15 minutes it stopped but the machine
didn't lockup. It was totally idle w/ no network traffic. Running
lsof | grep rsync tool about 20 seconds to respond. After stopping
the interface and reloading the hostap_pci modules I was able to get
network back. Interestingly rsync suddenly resumed where it left off and
eventually completed (resetting the card all the way). Something about
this rsync backup really tickles the system.

Is this a known problem? Is it known to be the driver, firmware,
or what? Could it be my access point (Linksys 802.11b 4 port switch
BEFW11S4 v.2)?

Thanks for your help. Personally I think I'm ok - now that I've sync'd
up the backup should only take a minute or two now. But I'm willing to
explore this if someone wants me to try some debugging.

> See..
> 
> hostap_pci: 0.3.9 - 2005-06-10 (Jouni Malinen <jkmaline@cc.hut.fi>)
> PCI: Found IRQ 9 for device 0000:00:09.0
> hostap_pci: Registered netdevice wifi1
> wifi1: Original COR value: 0x0
> prism2_hw_init: initialized in 195 ms
> wifi1: NIC: id=0x8013 v1.0.0
> wifi1: PRI: id=0x15 v1.1.1
> wifi1: STA: id=0x1f v1.7.4
> wifi1: Intersil Prism2.5 PCI: mem=0xe7800000, irq=9
> wifi1: registered netdevice wlan1
> wifi1: Deauthenticate all stations
> wifi1: prism2_send_mgmt - device is not UP - cannot send frame
> wlan1: Enabling ALC

hostap_pci: 0.3.9 - 2005-06-10 (Jouni Malinen <jkmaline@cc.hut.fi>)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
hostap_pci: Registered netdevice wifi0
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.1.0
wifi0: STA: id=0x1f v1.4.9
wifi0: Intersil Prism2.5 PCI: mem=0xf8000000, irq=11

Mike
