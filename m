Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271903AbTG2Q11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTG2Q0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:26:54 -0400
Received: from palrel10.hp.com ([156.153.255.245]:12166 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S271895AbTG2Q0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:26:24 -0400
Date: Tue, 29 Jul 2003 09:26:21 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Javier Achirica <achirica@ttd.net>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
Message-ID: <20030729162621.GA20410@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote :
> 
> Here's a patch against Linus current airo.c, it adds back some fixes I
> did during OLS on the previous version of this driver. I couldn't test
> this new 'fixed' version though as I don't have the airo card anymore:
> 
>  - Initialize the work_struct structures used by the driver
>  - Change most of schedule_work() to schedule_delayed_work(). The
>    problem with schedule_work() is that the worker_thread will never
>    schedule() if the work keeps getting added back to the list by the
>    callback, which typically happened with this driver when the xmit
>    work gets scheduled while the semaphore was used by a pending
>    command. Note that -ac tree has a modified version of this driver
>    that gets rid of this "over-smart" work queue stuff and uses normal
>    spinlock instead, probably at the expense of some latency...
>  - Fix a small signed vs. unsigned char issue
>  - Remove bogus pci_module_init(), use pci_register_driver() instead and
>    add missing pci_unregister_driver() so the module can now be removed
>    without leaving stale references (and thus avoid an oops next time
>    the driver list is walked by the device core).
> 
> Jeff, if you are ok with these, please send to Linus,

	Ben,

	Would you mind sending your patch to Javier (who is the
current maintainer). Javier did some work lately to fix some of those
problems, and I think your patch collides with it.
	Thanks...

	Jean
