Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVBAX2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVBAX2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVBAX1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:27:46 -0500
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:51751 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262170AbVBAX1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:27:30 -0500
Message-ID: <34184.192.168.1.250.1107300443.squirrel@www.bennee.com>
Date: Tue, 1 Feb 2005 23:27:23 -0000 (GMT)
Subject: Forcedeth Network driver lockup report
From: "Alex Bennee" <alex@bennee.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: alex@bennee.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso_8859_1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've hit a wierd lockup in the forcedeth (Nvidia onboard lan
chipset) driver on 2.6.9-gentoo-r9. When the failure occurs the
network just dies with loads of:

NETDEV WATCHDOG: eth0: transmit timed out
nv_stop_tx: TransmitterStatus remained busy<7>eth0: tx_timeout: dead entries!

Rebooting doesn't solve the problem although the driver will sit there
and accumulate a load of IRQ's achieving nothing:

eth0: nv_nic_irq
eth0: irq: 00000020
eth0: irq: 00000000
eth0: nv_nic_irq completed

Even shutting down and "powering off" doesn't clear the condition.
However if you remove the power from the box and wait a bit and
restart it comes back too life. I'm 50/50 on if this is failing
hardware or just that without physically removing power the chip
doesn't get fully reset. I have copious diagnostic traces since I #if
1'd the dprintk but before I flood lkml with traces.

* Has anyone else seen this problem?

* Could it be a reset problem?

* Should you be able to fully reset the chip with ethtool/mii-tool?

Please cc me as I'm no longer subscribed to the email torrent that is
lkml :-)


-- 
Alex
http://www.bennee.com/~alex/


