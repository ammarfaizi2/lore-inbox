Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbTFMSwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTFMSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:52:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58752 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265487AbTFMSwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:52:40 -0400
Date: Fri, 13 Jun 2003 12:02:10 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Steven Dake <sdake@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613120210.A23314@beaverton.ibm.com>
References: <Pine.LNX.4.44.0306130942040.908-100000@cherise> <3EEA0577.8050200@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EEA0577.8050200@mvista.com>; from sdake@mvista.com on Fri, Jun 13, 2003 at 10:10:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:10:15AM -0700, Steven Dake wrote:

> I propose the following test:
> Create 3 partitions on all 50 disks. Create system to boot kernel.org 
> 2.5.70 with initramdisk. Try greg's original udev without kernel aptch, 
> try modified udev with kernel patch, time each system's startup time.
> 
> Do you agree with the test methodology? If so, then we can proceed with 
> gathering real data.

I've seen a large variance on detect/probe/scan for fibre disks depending
on whether the feral or qlogic drive is used.

This is with switch attached fibre storage.

The qlogic takes more time to probe, but has shorter timeouts when trying
to detect disabled or disconnected ports. On my system (where I have a few
unconnected fibre cards), the insmod of the qlogic and feral seem to be
about equal (I haven't timed the actual differences, I normally don't
build a kernel or modules with both feral and qlogic available, they are
both available only outside of the mainline kernel). If I removed or
connected the unconnected cards, the feral driver would be faster.

You could probably improve boot time (or modprobe time) more by speeding
up the qlogic driver or using the feral driver rather than trying to speed
up the hotplug/whatever.

Note that scsi_debug driver has a default IO response time of 1 tick
(scsi_debug_delay), you can set it to zero, but then it has to wakeup the
softirqd to complete the IO. So you you either rely on a timeout to
complete an IO, or a wakeup of the ksoftirqd. I was trying to measure IO
latencies at one point using scsi_debug, but I seemed to end up measuring
context switch times instead.

-- Patrick Mansfield
