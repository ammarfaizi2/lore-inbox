Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUFAPe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUFAPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUFAPe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:34:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265015AbUFAPez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:34:55 -0400
Date: Tue, 1 Jun 2004 16:42:24 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406011542.i51FgOwk000160@81-2-122-30.bradfords.org.uk>
To: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko.ursulin@zg.htnet.hr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
References: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
Subject: Re: Question about IDE disk shutdown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Probably a trivial question for ones who know it - what IDE commands does 
> kernel issue when shutting down (which results in automatic power-off if ACPI 
> is enabled)?
> 
> According to my hard disk manual, it is absolutely recommended to put the 
> drive in STANDBY or SLEEP mode before power cut-off because in that way heads 
> are nicely parked. In that way it is guaranteed to have 300000 head 
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
> generic_ide_suspend, right? There, something called REQ_PM_SUSPEND is issued 
> to the drive. As SUSPEND != STANDBY or SLEEP, I am left uncertain.
> 
> Is there a place to be worried or I am missing something? 

This kind of thing has been discussed extensively in the past.  Basically,
there are loads of broken drives which do a wide range of different things,
so following the standards doesn't necessarily work best in practice.

John.
