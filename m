Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWDTV3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWDTV3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWDTV3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:29:03 -0400
Received: from leitseite.net ([213.239.214.51]:11956 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1751329AbWDTV3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:29:00 -0400
Date: Thu, 20 Apr 2006 23:28:24 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: linux-kernel@vger.kernel.org
Subject: Bug: PPP dropouts in >=2.6.16
Message-ID: <Pine.LNX.4.58.0604202217450.4014@pc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening,

I've recently had problems with my ADSL connection (PPPoE) after upgrading
from 2.6.15.3 to 2.6.16.5. Every now and then, it would stall for 30-50
seconds. According to tcpdump, during these dropouts packets get received
through ppp0 but none that are supposed to be sent appear on the
interface. This is consistent with the modem not sending out any data via
its ATM interface during these periods. I made sure the ISP, modem or
ethernet interface wasn't the problem with a second box running IPCop
(minimal 2.4 router distro, I can log in twice with my ISP) and a telnet
connection to the modem that never stalled.

Upgrading pppd from 2.4.2 to 2.4.4b1 and rp-pppoe from 3.5 (latest Debian
package) to 3.8 had no effect.
I was using Bittorrent and also the folding@home client so the system had
a high load. Stopping those seemed to reduce the frequency of dropouts
but they were still coming up at least every few hours. A fallback to the
old kernel made the problem disappear.

I then tested 24 hours a day this week by pinging my box from 2 hosts and
making sure above load was persistent, while trying different kernels. So
far I can say that:

- <= 2.6.15.7 is not affected, tested with .3, .4 and .7
- >= 2.6.16 is affected, tested with 2.6.16, .1, .5 and .9
- the dropouts last between 30 and 50 seconds but often exactly 41, they
  appear about every half to one hour
- a night yields 20-40 lost packets with 2.6.15 and 700-1100 with 2.6.16
  on my connection

The system:
P4 Northwood with HT enabled, 2 GB RAM, Asus P4C800
Boot/root PATA ICH5, torrents saved to SATA HD through ata-piix
Third drive through sata-promise
Debian GNU/Linux unstable
Kernel config: http://jawad.org/.config

Let me know what I can do to give you more specific information.

Regards,
Nuri
