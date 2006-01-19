Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWASUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWASUTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWASUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:19:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28686 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1161407AbWASUTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:19:04 -0500
Date: Thu, 19 Jan 2006 21:18:57 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick <nick@linicks.net>
Cc: Rumi Szabolcs <rumi_ml@rtfm.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
Message-ID: <20060119201857.GQ7142@w.ods.org>
References: <20060119110834.bb048266.rumi_ml@rtfm.hu> <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:29:51AM +0000, Nick wrote:
> On 1/19/06, Rumi Szabolcs <rumi_ml@rtfm.hu> wrote:
> > Hello!
> >
> > I've got a Linux system running the 2.4.26 kernel which was about
> > to pass the 500 day mark these days and now suddenly what I see is
> > that the uptime counter has reset:
> >
> > $ uname -a && w && cat /proc/uptime && last -1 reboot
> > Linux quasar 2.4.26 #3 SMP Tue Sep 7 09:22:08 CEST 2004 i686 Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux
> >  09:38:08 up 1 day, 12:49,  5 users,  load average: 0.00, 0.00, 0.00
> > USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
> > rumi     pty/s0    08:53    0.00s  0.04s  0.02s screen -r
> > rumi     ttyp1     10Sep04 31:58   9:12   9:12  epic
> > rumi     ttyp3     Tue12   44:33m  0.01s  0.01s -/bin/bash
> > rumi     ttyp2     13Feb05  8days  0.11s  0.11s -/bin/bash
> > rumi     ttypc     11Dec05  0.00s  0.12s  0.11s -/bin/bash
> > 132596.51 39801752.60
> > reboot   system boot  2.4.26           Tue Sep  7 18:47         (498+15:50)
> >
> > From the above it can be seen that the system is running continuously
> > and wasn't rebooted 36 hours ago as the uptime counter would suggest.
> >
> > Is this a known bug?
> 
> 
> It's not a bug - it is a feature.  uptime rolls over after 497 days.
> 
> [sic]
> It computes the result of the "uptime" based on the internal "jiffies"
> counter, which counts the time since boot, in units of 10
> milliseconds.
> This is typecast as an "unsigned long" - on the Intel boxes, that's an
> unsigned 32-bit number.
> Well, it turns out that in a 32-bit number, you can store 497.1 days
> before the number wraps.
> 
> 
> You can use:
> last -xf /var/run/utmp runlevel
> 
> to get true uptime in this instance.
> 
> Nick

I would add that if you need to get valid outputs after such an uptime,
you can apply the vhz-j64 patch available at Robert Love's (RML) on
kernel.org.

Regards,
Willy

