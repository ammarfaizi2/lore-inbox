Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWBZOJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWBZOJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWBZOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:09:19 -0500
Received: from rtr.ca ([64.26.128.89]:53441 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750714AbWBZOJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:09:18 -0500
Message-ID: <4401B689.5050106@rtr.ca>
Date: Sun, 26 Feb 2006 09:09:13 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hda: irq timeout: status=0xd0 DMA question
References: <200602261308.47513.nick@linicks.net>
In-Reply-To: <200602261308.47513.nick@linicks.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
..
> Feb 19 14:05:31 quake kernel: hda: irq timeout: status=0xd0 { Busy }
> Feb 19 14:05:31 quake kernel:
> Feb 19 14:05:31 quake smartd[405]: Device: /dev/hda, not capable of SMART 
> self-check
> Feb 19 14:05:31 quake smartd[405]: Sending warning via  mail to 
> root@localhost ...
> Feb 19 14:05:31 quake kernel: hda: status timeout: status=0xd0 { Busy }
> Feb 19 14:05:31 quake kernel:
> Feb 19 14:05:31 quake kernel: hda: DMA disabled
> Feb 19 14:05:31 quake kernel: hda: drive not ready for command
> Feb 19 14:05:33 quake kernel: ide0: reset: success
..
> I dunno what happened to the drive that time (this is the only logs of the 
> incident) and I turned DMA back on with hdparm - but my question is why is 
> DMA turned off and then left off after a reset?

When I wrote that code in the mid-1990s, the number one causes of drives
getting confused (and needing to be reset again), were improper DMA timings,
cablings, and buggy DMA firmware.

So at the time, since DMA was a newish feature for IDE, we figured that
turning it off after reset was a Good Thing(tm).

And it was.  A more modern implementation might try being more clever about
such stuff, and Tejun is working on something like that for libata.

In the meanwhile, you could have a shell script just loop in the background,
turning DMA back on periodically.  If you care.

Cheers

