Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbRBMRFn>; Tue, 13 Feb 2001 12:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129832AbRBMRFd>; Tue, 13 Feb 2001 12:05:33 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:44555 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129492AbRBMRFZ>; Tue, 13 Feb 2001 12:05:25 -0500
Date: Tue, 13 Feb 2001 17:05:14 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.1-ac10] unsetting TASK_RUNNING
In-Reply-To: <Pine.LNX.4.21.0102131640470.1265-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0102131701010.9400-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Tigran Aivazian wrote:

> Hi Alan,
> 
> The only case in schedule_timeout() which does not call schedule() does
> set tsk->state = TASK_RUNNING explicitly before returning. Therefore, any
> code which unconditionally calls schedule_timeout() (and, of course
> schedule()) does not need to set TASK_RUNNING afterwards.
> 
> I have seen some people setting this TASK_RUNNING incorrectly, based on a
> mere observation that "official Linux kernel code does so" -- so the patch
> below is not just an optimization but serves for education (i.e. to stop
> people copying unnecessary code).

I had a similar set of patches a while ago. I had several more unnecessary settings.

At least Matthew Dharm as usb-storage maintainer wanted to keep his in. Of more
concern IMHO were the drivers busy waiting by failing to reset current->state
on each iteration - e.g. maestro2, maestro3.

The patches I sent (out dated, and some of it buggy) are at :

http://www.movement.uklinux.net/patches/kernel/schedule1.diff
http://www.movement.uklinux.net/patches/kernel/schedule2.diff
http://www.movement.uklinux.net/patches/kernel/schedule3.diff
http://www.movement.uklinux.net/patches/kernel/schedule4.diff

for your reference. The last is similar to your patch.

thanks
john

-- 
"Having Outlook security problems so frequently that they start to blur together is a dangerous thing."
	- hackernews

