Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUGTUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUGTUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUGTUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:43:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:35750 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266220AbUGTUn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:43:27 -0400
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40FD82B1.8030704@optonline.net>
References: <40FD38A0.3000603@optonline.net>
	 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
	 <40FD4CFA.6070603@optonline.net>
	 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
	 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
	 <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
	 <40FD82B1.8030704@optonline.net>
Content-Type: text/plain
Message-Id: <1090356079.1993.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 16:41:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 16:38, Nathan Bryant wrote:
> Benjamin Herrenschmidt wrote:
> > NO ! The exact opposite in fact. I'll work on cleaning that up and
> > write some doco this week with Pavel.
> 
> Did more code reading. I assume the value passed to pci_dev->suspend is 
> going to be one of:
> 
> enum {
>          PM_SUSPEND_ON,
>          PM_SUSPEND_STANDBY,
>          PM_SUSPEND_MEM,
>          PM_SUSPEND_DISK,
>          PM_SUSPEND_MAX,
> };

Yes something around those lines

> And the value passed to pci_set_power_state will continue to be 0..3 
> (except enumerated)?

We could keep those unenumerated, which power state is to be used by the
device is under driver control, most of the time, they'll do D3 though,
for suspend-to-RAM, and they can probably just not do anything special
for suspend-to-disk (except shutting down the driver itself of course)

Note regarding aix7xxx, we also need proper hooks in the SCSI stack to
block the queue correctly etc... in the same way we do on IDE. I didn't
have time to look into this yet.

Ben.


