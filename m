Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUFAWwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUFAWwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUFAWv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:51:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46502 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265296AbUFAWiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:38:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko.ursulin@zg.htnet.hr>
Subject: Re: Question about IDE disk shutdown
Date: Wed, 2 Jun 2004 00:41:22 +0200
User-Agent: KMail/1.5.3
References: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
In-Reply-To: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406020041.22420.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 of June 2004 17:13, Tvrtko A. Uršulin wrote:
> Hello all,
>
> Probably a trivial question for ones who know it - what IDE commands does
> kernel issue when shutting down (which results in automatic power-off if
> ACPI is enabled)?
>
> According to my hard disk manual, it is absolutely recommended to put the
> drive in STANDBY or SLEEP mode before power cut-off because in that way
> heads are nicely parked. In that way it is guaranteed to have 300000 head
> load/unload cycles minimum, while in other case it is just 20000 cycles.
>
> It also explicitely states that FLUSH CACHE is not to be used for drive
> power-off because it does not park the heads.
>
> Looking at the source I see in ide-disk.c:
>
> 	.gen_driver = {
> 		.shutdown	= ide_device_shutdown,
> 	},
>
> Following that I see that ide_device_shutdown flushes the cache, and then
> calls dev->bus->suspend(dev, PM_SUSPEND_STANDBY); which is in fact
> generic_ide_suspend, right? There, something called REQ_PM_SUSPEND is
> issued to the drive. As SUSPEND != STANDBY or SLEEP, I am left uncertain.
>
> Is there a place to be worried or I am missing something?

You are missing PM code in ide-disk.c.  :-)

See idedisk_start_power_step() and idedisk_complete_power_step(),
also read comment in <linux/ide.h> about ide_pm_state_*.

Bartlomiej

