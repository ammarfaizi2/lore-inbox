Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbTF2QoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 12:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbTF2QoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 12:44:05 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:2308
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S265713AbTF2QoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 12:44:01 -0400
Date: Sun, 29 Jun 2003 12:56:27 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Thomas Molina <tmolina@cox.net>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Presario and 2.5.72
In-Reply-To: <Pine.LNX.4.44.0306250542300.1007-100000@lap.molina>
Message-ID: <Pine.LNX.4.44.0306291251240.1007-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 23 Jun 2003, Russell King wrote:
> 
> > On Wed, Jun 18, 2003 at 06:07:05AM -0600, Thomas Molina wrote:
> > > The other problem was getting my pcmcia ethernet card up and operational.  
> > > The change in the yenta module for the latest bk version of 72 allows it 
> > > to be autoloaded by my RedHat 8.0 system as previously done.  However, 
> > > there is another problem.  Although all the required modules get loaded -- 
> > > pcmcia core, yenta socket, ds, crc32, tulip -- for some reason the dhcp 
> > > client doesn't get brought up to acquire an address for the interface.  It 
> > > may be a problem with the RedHat scripts since running the dhclient 
> > > software manually does its magic.  It is a change in behaviour so I am 
> > > reporting it here also.
> > 
> > Can you check whether 2.5.73 fixes it for you?  If not, please re-report
> > the problem.

Here is some additional info.  I am including /var/log/messages output 
from the 0607 version of the kernel which works, and the 0629 (today) 
version of the kernel which doesn't.  Note the differences in the output 
from /etc/hotplug/net.agent.  I will attempt to look into why this is 
happening.


First, the working version from June 7:

Jun 29 12:16:02 lap /etc/hotplug/pci.agent: Setup tulip for PCI slot 
02:00.0
Jun 29 12:16:02 lap kernel: Linux Tulip driver version 1.1.13 (May 11, 
2002)
Jun 29 12:16:02 lap kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Jun 29 12:16:02 lap kernel: eth0: ADMtek Comet rev 17 at 0x1800, 
00:E0:98:8E:C0:94, IRQ 9.
Jun 29 12:16:02 lap /etc/hotplug/net.agent: Bad NET invocation: $INTERFACE 
is not set
Jun 29 12:16:02 lap /etc/hotplug/net.agent: invoke ifup eth0
Jun 29 12:16:11 lap dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 
67
Jun 29 12:16:11 lap dhclient: DHCPACK from 24.35.32.1
Jun 29 12:16:11 lap dhclient: bound to 24.35.32.166 -- renewal in 494444 
seconds.


Now, the non-working version from June 29:

Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: ADMtek Comet rev 17 at 0x1800, 00:E0:98:8E:C0:94, IRQ 9.
Jun 29 12:25:00 lap /etc/hotplug/pci.agent: Setup tulip for PCI slot 
0000:02:00.0
Jun 29 12:25:00 lap kernel: Linux Tulip driver version 1.1.13 (May 11, 
2002)
Jun 29 12:25:00 lap kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 
0003)
Jun 29 12:25:00 lap kernel: eth0: ADMtek Comet rev 17 at 0x1800, 
00:E0:98:8E:C0:94, IRQ 9.
Jun 29 12:25:00 lap /etc/hotplug/net.agent: NET add event not supported


