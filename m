Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbTHARjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270856AbTHARjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:39:02 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:38078 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S270854AbTHARi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:38:59 -0400
Message-ID: <3F2AA64F.3090404@pacbell.net>
Date: Fri, 01 Aug 2003 10:41:35 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
References: <20030723220805.GA278@elf.ucw.cz> <3F2673C4.9010302@pacbell.net> <20030731141807.GC16463@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030731141807.GC16463@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>Here's a patch that makes things slightly better. ....
>>
>>Where "better" means that it seems functional after the
>>first suspend/resume cycle, and re-enumerates the device
>>that's connected ... but there's still strangeness.  And
>>I can see how some of it would be generic.
> 
> For me it:
> 
> reports problem after first suspend, and ohci stops working

When you say "reports problem", what do you mean?

I can see problems _during_ the suspend, before any USB
suspend calls are even made.  Only if the controller has
work to do, so it's scanning the schedules (DMA) ... it's
fine until the suspend starts, then the controller gets
an "Unrecoverable Error" IRQ, which I'm used to seeing
for DMA errors.  (As if something started shutting down
hardware before the driver had a chance to clean up.)

If there's no DMA action before the suspend starts, the
current code behaved OK for me -- on an APM D3cold
suspend/resume cycle, which isn't so different from what
you'll see with swsusp.

That makes me think I'll be better off waiting for some
of those PM updates to get merged, before I spend much
more time looking at the usb parts of these issues.


> oopses in hcd_panic during second suspend (IIRC).

Likely because resuming a halted controller is nonsense,
and the code needs to reject such attempts.

Of course, if the controller weren't going bonkers before
it's told to start suspending, these particular faults
wouldn't be happening ... :)

- Dave



