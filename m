Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUFAPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUFAPSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUFAPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:18:54 -0400
Received: from dns1.vodatel.hr ([217.14.208.29]:5538 "EHLO dns1.vodatel.hr")
	by vger.kernel.org with ESMTP id S262905AbUFAPQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:16:55 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko.ursulin@zg.htnet.hr>
To: linux-kernel@vger.kernel.org
Subject: Question about IDE disk shutdown
Date: Tue, 1 Jun 2004 17:13:59 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

Probably a trivial question for ones who know it - what IDE commands does 
kernel issue when shutting down (which results in automatic power-off if ACPI 
is enabled)?

According to my hard disk manual, it is absolutely recommended to put the 
drive in STANDBY or SLEEP mode before power cut-off because in that way heads 
are nicely parked. In that way it is guaranteed to have 300000 head 
load/unload cycles minimum, while in other case it is just 20000 cycles.

It also explicitely states that FLUSH CACHE is not to be used for drive 
power-off because it does not park the heads.

Looking at the source I see in ide-disk.c:

	.gen_driver = {
		.shutdown	= ide_device_shutdown,
	},

Following that I see that ide_device_shutdown flushes the cache, and then 
calls dev->bus->suspend(dev, PM_SUSPEND_STANDBY); which is in fact 
generic_ide_suspend, right? There, something called REQ_PM_SUSPEND is issued 
to the drive. As SUSPEND != STANDBY or SLEEP, I am left uncertain.

Is there a place to be worried or I am missing something? 
