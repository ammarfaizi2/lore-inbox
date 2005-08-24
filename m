Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVHXGRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVHXGRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVHXGRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:17:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46223 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751469AbVHXGRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:17:20 -0400
Message-ID: <430C10E7.9060502@pobox.com>
Date: Wed, 24 Aug 2005 02:17:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Another libata TODO item
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Difficulty: beginner / intermediate Modern network
	drivers have a per-NIC list of debugging messages that can be
	enabled/disabled at runtime, implemented as a bitmask named
	'msg_enable' in each driver. VERY useful for tracing specific events
	during debugging. grep for 'msg_enable', 'netif_msg_', and
	'NETIF_MSG_'. [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Difficulty:  beginner / intermediate

Modern network drivers have a per-NIC list of debugging messages that 
can be enabled/disabled at runtime, implemented as a bitmask named 
'msg_enable' in each driver.  VERY useful for tracing specific events 
during debugging.  grep for 'msg_enable', 'netif_msg_', and 'NETIF_MSG_'.

To make libata debugging easier and more fine-grained, we should convert 
DPRINTK/VPRINTK calls in libata to code that looks like

	if (ata_msg_xxx(ap->msg_enable))
		printk(...)

The task involves:

* reviewing net driver msg_enable usage
* reviewing original netif_msg documentation by Donald Becker, at 
(scroll down)
http://www.scyld.com/pipermail/vortex/2001-November/001426.html

* designing a sliding scale of ever-more-verbose classes of messages, 
for libata and libata drivers
* design a method by which userspace may change the per-port msg_enable 
variable in libata

* implement the sliding scale as ATA_MSG_xxx / ata_msg_xxx()
* add msg_enable to struct ata_port
* implement method of setting ap->msg_enable via userspace
* convert messages in libata-core/libata-scsi
* convert messages in each driver
* add 'debug' module option to each driver, in a manner that duplicates 
net driver module options
* test!


