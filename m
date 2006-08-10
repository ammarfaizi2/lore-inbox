Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbWHJMWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWHJMWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWHJMWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:22:17 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:21955 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030575AbWHJMWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:22:16 -0400
Message-ID: <44DB2436.6080501@aitel.hist.no>
Date: Thu, 10 Aug 2006 14:19:02 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>	 <20060810030602.GA29664@mail> <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
In-Reply-To: <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
[...]
>
> As far as I remember, I configured it to automatically update everything.
> Apparently that function just broke itself very early on :-).
>
> I guess the problem is that I don't know a single Linux packaging system
> that actually works well enough to keep a system up to date at all times,
> and I don't have any free time to spend on reinstalling systems all the
> time.
Have you considered debian then?  That package system certainly
have been able to keep many a system running for years and years.
You never reinstall, just upgrade.
>
> I think most of the package managers break because their dependency 
> system
> sucks.  Some of them doesn't suck, but they break because there's no
> integrity checks, and package maintainers can dump any kind of bizarre
> corrupt dependencies they like into them.  That's how Gentoo works, for
Sure, you have to trust someone.  If you can't trust any distro and its
maintainers, your only choice is to roll your own.
> example.  Others have even more bizarre ways of breaking, again Gentoo as
> an example requires the user to run a "switch to newer GCC" command from
> time to time, otherwise random packages just start breaking.
>
> AFAIK, every single Linux package manager on the planet is half-ass, 
> broken
> like above or in some other way.  If you know of one that's actually well
> thought through on all planes and well implemented and thus works good 
> enough
> to keep a system up to date for three years in a row without human
> intervention....
> Please speak up!!!
Well, if you expect to keep a computer running for three years
without human intervention - good luck to you!  Not only will there be
new vulnerabilities and attacks via the internet in that time, there is also
a substantial risk of hardware breakdown.  Disks in particular seems not
to live much more than three years, and if you have several, the chance
is bigger that one goes.  Raid protects the data, but surely you will 
intervene
to replace the failed drive?  Or do you install six hot spares so the
system really can keep running alone?

It is certainly possible to run debian and spend 5min per week
on running "apt-get dist-upgrade" which installs anything that
was upgraded since the last time.  And if you have many identical
servers, then you know that when one upgrade went without
problems the others will too.
>> > (Maybe the kernel SHOULD coordinate it somehow,
>> > seems like some of the distros are doing a pretty bad job as is.)
>>
>> That's pretty much impossible, the best the kernel can do is send
>> signals to all of the running processes.
>
> Impossible?  Few things in the software world are impossible.
>
> Surely it's possible to create a kernel interface where processes
> can tell the kernel about which other processes they'd like to
> outlive and which ones they'd like to get killed before.
>
> The kernel could then coordinate the killing of processes in a
> "shutdown" function, which the various distro's 'reboot' and
> 'shutdown' scripts could call.
Such coordination can certainly be done - there is just no
reason at all to do it in the _kernel_.  This is the job of the
program called "init".  (The kernel is a very important piece of
a linux system, but don't make the mistake of believing
it therefore should be the "general manager" for all things less
important.)

Init is the first program that runs,
it is started up by the kernel.  Init will then start all other
software you need, such as samba, any other server software,
and of course the login services. When you shut the pc down,
init is the program responsible for stopping everything in
a sane order.

Init is customizable, by editing and/or renaming the so-called
initscripts.  That way, you can alter the order of startup and
shutdown of software, if your distribution didn't get this right.
This isn't all that hard, and a linux system administrator is
supposed to be able to make simple adjustments in this area.
Many linux/unix books documents how initscripts work, and there
is usually plenty of online documentation as well.

> And voila, that difficult task of assessing in which order to do
> things is out of the hands of distros like Red Hat, and into the
> hands of those people who actually make the binaries.
Not so easy.  You do not want to shut down md devices because
samba is using them. Someone else may run samba on a single
harddisk and also have some md-devices that they take down
and bring up a lot.  So having samba generally depend on md doesn't
work.  Your setup need it, others may have different needs.
That's why the initscripts are _scripts_, simple textfiles that
administrators can manipulate without having to know C programming.
>
> Which is probably a good thing, because
>
> a) Red Hat's init scripts probably fails for me because there's
>   something in my setup that Red Hat didn't expect.  A greatly
>   simplified system as outlined above would help to fix things
>   like this.
Learn to manipulate the initscripts then.  Changing the
shutdown order really is as simple as renaming samba's
script file so it occur earlier in the shutdown order than
the script responsible for taking down the md devices.
You don't even need to understand shellscript programming to
re-order stuff.
>
> b) Less duplicated effort in the form of init script coding for
>   the distro maintainers.
It is open source, they can copy each others's scripts to save
effort.  They often do -  and sometimes the initscript for a
particular piece of sw is written by the maker of that sw too.

Helge Hafting
