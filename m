Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135251AbRDLSvm>; Thu, 12 Apr 2001 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135252AbRDLSvd>; Thu, 12 Apr 2001 14:51:33 -0400
Received: from blackhole.compendium-tech.com ([206.55.153.26]:53235 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S135251AbRDLSvX>; Thu, 12 Apr 2001 14:51:23 -0400
Date: Thu, 12 Apr 2001 11:51:08 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Boris Pisarcik <boris@acheron.sk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about SysRq
In-Reply-To: <20010404023911.A1260@Boris>
Message-ID: <Pine.LNX.4.30.0104121138170.4222-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, Boris Pisarcik wrote:
> I looked a bit at the source of sysrq handling. I've found there is
> rather big difference between sysrq+b and other killers handling.
> Sysrq+b is just called with pretty straitforward fashion - stops other
> processors on SMP and reboots directly (hardware impulse or triple fault)
> or through the bios - so it just calls for the corruptions.

ah, that would explain it...

> On the other side sysrq+s marks a single variable, which will be tested
> next cycle in the bdflush kernel threads' main loop, and adds bdflush to
> scheduler runqueue list. So it gets possibility to check for emergency
> sync onle when gets next scheduled. Does it ?
>
> Can you anyhow find something in your logs/console/serial console messages
> like 13.13.2000 kernel : Sysrq: Emergency Sync (this should be present - is
> written within keyboard handler, not after shedule) and what's next logs ?
> We could determine, if the bdflush thread got scheduled and called emergency
> syncing routine indeed.

Nope, there was nothing in the logs.

> As you wrote no of your processes does respond - probably telnet will
> not help. You may try to write experimental programme, that only log
> say current time every n seconds, and see, if it just stopped to
> log messages after lockup-time. If not - it doesn't get scheduled.
> If continues - there's problem with syncing. Again - try, as far
> as i understand, log kernel messages to serial console or alike, because
> the messages should not get written to logfiles - syslogd can't be woken up
> eg.

Telnet's disabled anyways :) Cleartext passwords SUCK. :)
I've got a nifty LCD thingy I can hook up to the serial port and use as a
console if need be.

> Quick help against those corruptions, which comes on my mind, is use
> the reiserfs. I have no real experiences with that and its reliability,
> also as aj followed some of messages in this list about resierfs - it has
> some problems too - but in definition it shoudn't get corrupted by not-
> syncing reboot. But i see this not much helpfull ,cause if you really
> would depend on big reliability, you wouldn't intall 2.3.x-pre kernel :)

I'm not about to convert my filesystems over... It's too much a hassle for
little gain. ext2 is faster anyways, IIRC.

The problem disappeared when I installed 2.4.3 release; I think it was a
DRM issue in the kernel that was causing the lockups

Thanks for the help though

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

