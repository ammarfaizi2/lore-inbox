Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUFGVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUFGVmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUFGVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:42:53 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:41357 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265103AbUFGVmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:42:09 -0400
Message-ID: <20040607214034.27475.qmail@web51807.mail.yahoo.com>
Date: Mon, 7 Jun 2004 14:40:34 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200406080712.44759.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OOOPPPSSSS....

I need to make a correction on my previous data.  I
had inadvertantly turned off interactivity and also
increased the compute time to 100.  I confirmed that
just setting interactivity off, does not solve my
problem:

2.6.7-rc3-s63 (0 @ /proc/sys/kernel/interactive):
A:  37.30user 40.56system 1:42.01elapsed 76%CPU
B:  37.29user 40.35system 1:23.87elapsed 92%CPU
C:  37.30user 40.56system 1:36.01elapsed 81%CPU

2.6.7-rc3-s63 (0 @ /proc/sys/kernel/interactive & 1
/proc/sys/kernel/compute):
A:  37.28user 40.36system 1:25.60elapsed 90%CPU
B:  37.22user 40.35system 1:22.17elapsed 94%CPU
C:  37.27user 40.35system 1:24.71elapsed 91%CPU

The question here, noticing that user and kernel time
are the same, where is the dead time coming from and
why is it sooooo much more deterministic with compute
time at 100 vs 10?  Maybe I am misinterpreting the
data, but this suggests to me that something is going
awry (ping-pong, no settle, ???) within the kernl?


Also please note the degredation between
2.6.7-rc2-bk8-s63:

A:  35.57user 38.18system 1:20.28elapsed 91%CPU
B:  35.54user 38.40system 1:19.48elapsed 93%CPU
C:  35.48user 38.28system 1:20.94elapsed 91%CPU

Interesting how much more time is spent in both user
and kernel space between the two kernels.  Also note
that 2.4.x exhibits even greater delta:

A:  28.32user 29.51system 1:01.17elapsed 93%CPU
B:  28.54user 29.40system 1:01.48elapsed 92%CPU
B:  28.23user 28.80system 1:00.21elapsed 94%CPU

Could anyone suggest a way to understand why the
difference between the 2.6 kernels and the 2.4
kernels?

Thank you for your time.
Phy





--- Con Kolivas <kernel@kolivas.org> wrote:
> On Tue, 8 Jun 2004 05:57, Phy Prabab wrote:
> > I have had a chance to test this patch.  
> 
> Thanks
> 
> > I have a make 
> > system that has presented 2.6 kernels with
> problems,
> > so  I am using this as the test.  Observations
> show
> > that turning off interactive is much more
> > deterministic:
> >
> > 2.6.7-rc2-bk8-s63:
> > echo 0 > /proc/sys/kernel/interactive
> >
> > A:  35.57user 38.18system 1:20.28elapsed 91%CPU
> > B:  35.54user 38.40system 1:19.48elapsed 93%CPU
> > C:  35.48user 38.28system 1:20.94elapsed 91%CPU
> >
> > 2.6.7-rc2-bk8-s63:
> > A:  35.32user 38.51system 1:26.47elapsed 85%CPU
> > B:  35.43user 38.35system 1:20.79elapsed 91%CPU
> > C:  35.61user 38.23system 1:25.00elapsed 86%CPU
> >
> > However, something is still slower than the 2.4.x
> > kernels:
> >
> > 2.4.23:
> > A:  28.32user 29.51system 1:01.17elapsed 93%CPU
> > B:  28.54user 29.40system 1:01.48elapsed 92%CPU
> > B:  28.23user 28.80system 1:00.21elapsed 94%CPU
> >
> > Nice work, as I can now turn off some
> functionality
> > within the kernel that is causing me some slow
> down.
> 
> Glad to see it does what you require. Turning off
> "interactive" should still 
> provide moderately good interactive performance at
> low to moderate loads, but 
> is much stricter about cpu usage distribution as you
> can see.
> 
> Cheers,
> Con



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
