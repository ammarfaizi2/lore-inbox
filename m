Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTBYTSa>; Tue, 25 Feb 2003 14:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTBYTSa>; Tue, 25 Feb 2003 14:18:30 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:12769 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S267187AbTBYTS1>; Tue, 25 Feb 2003 14:18:27 -0500
Date: Tue, 25 Feb 2003 14:28:29 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: john@pianoman.cluster.toy
To: Pavel Machek <pavel@suse.cz>
cc: Dominik Brodowski <linux@brodo.de>, <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
In-Reply-To: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Pavel Machek wrote:

> Hi!
>
> > > But I agree that hacking proc_intf is not the right thing to do. I did
> > > not see that sysfs access. Where is it?
> >
> > kernel/cpufreq.c
>
> Okay, I see.
>
> > > > - selecting the voltage manually is something which is only valid for some
> > > >   very few drivers - so let's only export one sysfs file[*] for these
> > > >   drivers.
> > >
> > > Very few drivers? It should be common for at least Intel and AMD, no?
> > No. Intel doesn't let you select the exact voltage. IIRC, only vew
> > VIA/Cyrix-longhaul-capable processors and, of course, powernow-k7 are vaild
> > targets for such a patch.
>
> So I guess adding /sys/bus/system/devices/cpu0/voltage? Should code to
> do that be in kernel/cpufreq.c or is it possible to do sysfs from
> powernow-k7 [it does not seem easy]?
 								Pavel
I agree, there shoul dbe a way to add sysfs files from a cpufreq driver
module.  I told dave I was looking into overriding the powernow tables,
but I can't seem to get enough time away from my day job right now.

for the powernow driver, and the userspace governor, I'd like to export a
file "current_setting" or something that contains:

<frequency> <voltage> <fsb? maybe for other drivers>

A write to this file of one, two, or three values would result in changing
the frequency to the closest standard table match we have.  Unless, the
user specifies an "override" flag as a module parameter.  If the override
flag is set, then writing to that file will set the speed and voltage to
exactly what you specify (within the min/max hardware limits), and
basically ignore the standard BIOS table.

simple, elegant, gives standard default behavior....but allows one to
override the tables if they -swear- they know better.  But it's really
tough to do without a way to add sysfs files from the driver itself.

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


