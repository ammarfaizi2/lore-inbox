Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbULJPVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbULJPVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbULJPVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:21:32 -0500
Received: from [81.3.11.18] ([81.3.11.18]:36489 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S261699AbULJPVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:21:11 -0500
Date: Fri, 10 Dec 2004 16:21:08 +0100
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: How do klogd and syslogd influence code execution timing?
Message-ID: <20041210152107.GA23594@synertronixx3>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

At the moment me and my colleauge are trying to debug a very bizarre
problem that our usb host controller has (or we :)).
We are implementing a device driver for the usb host controller philips
isp1161a1. We are at the state, that it recognizes usb-storage devices
and we can mount them. But only sometimes.
It is absolutely _required_ that we start syslogd and klogd before
inserting the storage device. Then it gets recognized cleanly. If we
remove or add a printk in some areas of the code, the device recognition
gets sloppy or breaks.
Hardware timing you may point out.

We have the chip connected to an Motorola i.MX cpu (arm9).

I triple checked scratching a 16Bit register and a 32Bit register and
not one bit is misread or miswritten. Not one... There where ndelays in
the code. Together with a scope I adjusted the hardware timing of the
bus signals exactly as the are required by the datasheet. As a result I
removed any ndelays out of the code and scratching, reading and writing
registers works 100%. I am sure. Or what else can I do to test this?
Currently i have to loops from 0 to 0xffff resp 0xffffffff where the
loopcount is written, read back and BUG_ON(1) if written != read.

Now the misterious syslogd/klogd. I think there is an area in the
driver, where we should take care of protecting ourself from the kernel
interfering and doing something. My question to experienced kernel
programmers is, how can we find such an area? Whow are running
syslogd/klogd affecting the "workflow" of the kernel? Or has somebody
experienced a similair situation and the fix is a standerd procedure to
take care of we missed?

Well, kinda weird. it is also not possible to replace syslogd/klogd by
other RAM eating or process time eating server daemons. I tried sshd ir
httpd and stuff. Even replacing the klogd triggering printk by stock
printk does not the same as the logdaemons.

Regards, Konstantin



-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
