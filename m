Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVLDWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVLDWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVLDWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:25:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39995
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932335AbVLDWZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:25:56 -0500
Date: Sun, 4 Dec 2005 23:25:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       klive@cpushare.com
Subject: Re: Linux 2.6.15-rc5: off-line for a week
Message-ID: <20051204222551.GB28539@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512041035l53bf4578n6372c2e3d7c96322@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 07:35:40PM +0100, Jesper Juhl wrote:
> But, forcing users to install python, twistd, zope interface etc is
> not exactely making it simple for people to run (and they have to know
> about it first as well).
> If this was instead implemented in C and distributed with the kernel

Thanks to Christian Aichinger's contribution there's now a python
standalone version that can be invoked by cron every few minutes (
http://klive.cpushare.com/klive.py ), it only requires python and no
other lib, it sends the packet with exponential backoff too by keeping
track of the last packet delivery.

This only works correctly if /proc/uptime doesn't overflow (so 2.6
should be ok, 2.4 sure not).

Also note, zope isn't really required, it's just that twisted shares a
library inside zope called zopeinterfaces, you can install that single
lib and not the whole zope. In any recent distro, you've only to select
the twisted-python package, it'll pick up all other (tiny) dependencies
automatically.

The autoinstaller ( http://klive.cpushare.com/klive.sh
--install|--uninstall ) is available only for the twisted version, I
believe that's simpler to setup and handle than the cron driven one even
if it requires twisted (and in turn zopeinterfaces ;)

Everything is GPL including the server code and the network protocol, so
feel free to write a C client, but frankly I think the python standalone
one is more than enough if you don't want a daemon in the background,
writing a C version would be a worthless complication, but still I'm not
against it, if you write it I'll audit and merge it too.

Note, that with the new protocol activated recently I already collected
quite some more info (all can be deactived by editing the script or by
setting the environment variables, there's a wiki where to document all
the stuff too: http://klive.cpushare.com:8819/ ). What you see on the
homepage is what was being logged with the old protocol.

So soon we'll be able to see the pci-ids with the highest/avg/min
uptime, the filesystems mounted and the kernel modules. Furthermore you
will be able to track your own uptime (for your all computers combined
or each one separately) by setting an environment variable. I didn't
start using the new information that gets logged yet, because I'm trying
to start transactions on CPUShare first (my spare time is quite
limited), but it shouldn't take too long before I startup CPUShare and
the KLive new features becomes available too. Incoming patches will
preempt my CPUShare work of course, so feel free to send patches already
if you write them ;).

The next step after the new pciid/fs/module info becomes browsable is to
write a netconsole oops dumper that pushes the oops to the network using
symmetric encryption (the password has to be set with an environment
variable or something like that, that the klive client will pass to
the kernel along with the routing and ip information) that only the
computer owner can decrypt. Then depending on the oops he can decide to
open it up (or he can just leave it always open without password if he
knows there's no sensitive info in the computer).  This will also avoid
people to setup netconsole servers, the cpushare server will log all
oopses securely and with full privacy (and with klive I can still track
how many oopses each kernel is generating even when they're encrypted).

You're welcome to followup discussions on the klive@cpushare.com mailing
list too.

Thanks!
