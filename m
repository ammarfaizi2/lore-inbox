Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRDBWcA>; Mon, 2 Apr 2001 18:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDBWbu>; Mon, 2 Apr 2001 18:31:50 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:18882 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S131408AbRDBWbj>; Mon, 2 Apr 2001 18:31:39 -0400
Date: Mon, 2 Apr 2001 15:24:42 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "J . A . Magallon" <jamagallon@able.es>,
   Oliver Xymoron <oxymoron@waste.org>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D . Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <3AC8F881.F20A19A6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104021513510.30128-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the reason for suggesting /proc is that this data needs to be available in
a standard place, putting it in the kernel image (compressed is fine,
bitmap is fine)  eliminates the problems of trying to dictate where in the
filesystem the distros need to put things.

putting it in /proc _somewhere_ (/proc/sys/kernel/config any better???)
avoids the need to invent a new place to put it.

one person suggested that instead of listing all the options in a nice
human readable format we could change it to a series of flags, that won't
quite work as there are three values for most options (Y,N,M) not to
mentions the ones that allow more values. you could still just list all
the config values without including the stuff to the left of the = it
would require matching up with the kernel version specific config file to
tell what is what but would cut down on the space needed.

David Lang


proc is overused, but putting the compile options

 On Mon, 2 Apr 2001, Jeff Garzik wrote:

> Date: Mon, 02 Apr 2001 18:09:05 -0400
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: J . A . Magallon <jamagallon@able.es>
> Cc: Oliver Xymoron <oxymoron@waste.org>, David Lang <dlang@diginsite.com>,
>      Manfred Spraul <manfred@colorfullife.com>,
>      Albert D . Cahalan <acahalan@cs.uml.edu>, lm@bitmover.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: bug database braindump from the kernel summit
>
> "J . A . Magallon" wrote:
> > Could <installkernel> make part of the kernel scripts, or in one other
> > standard software package, like modutils, so its versions are controlled
>
> There is value in putting it into the Linux kernel source tree, in
> linux/scripts dir.  But most vendors can and should take this script as
> a sample, and customize it for their distro.  The Linux-Mandrake
> installkernel script definitely gets touched every so often, and
> decisions it makes, like updating lilo.conf or grub/menu.lst, or
> autodetecting the boot loader, are definitely not to be applied for all
> cases.
>
> FWIW here is our /sbin/installkernel command line usage help text, to
> give a glimpse of what it does and can do:
>
> Usage: ${0##*/} -[lngarhcq] KERNEL_VERSION BOOTIMAGE MAPFILE
>
>   -l:  Add a lilo entry
>   -i:  Dont generate Initrd files
>   -n:  Don't launch lilo.
>   -g:  Add a Grub entry.
>   -d:  Don't autodetect boot loader.
>   -a:  Autodetect boot loader.
>   -r:  Features for RPM post install.
>   -c:  Don't copy files.
>   -q:  Be quiet.
>   -h:  This help.
>
>
> > I think the best solution would be to make /boot the 'official' place for
> > kernels, the -X.Y.Z naming an standard, installkernel should save System.map
> > and .config.
>
> There will never be an official place to put this stuff, because that's
> a distro policy decision.  A quick search just now reveals no reference
> to /boot in the i386 Makefiles, and only a quick reference in the README
> file.
>
> > And you can add something like /proc/signature/map, /proc/signature/config,
> > etc to md5-check if a certain file fits running kernel.
>
> Additionally, everyone should remember: /proc is not a dumping ground :)
>
> Ad-hoc naming like this has created the procfs namespace ugliness we
> have now... let's not add to it unless we have to, and unless we have a
> good idea of proper naming.
>
> --
> Jeff Garzik       | May you have warm words on a cold evening,
> Building 1024     | a full moon on a dark night,
> MandrakeSoft      | and a smooth road all the way to your door.
>

