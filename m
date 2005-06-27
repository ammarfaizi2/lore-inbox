Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVF0Xe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVF0Xe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVF0Xbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:31:33 -0400
Received: from smtp04.auna.com ([62.81.186.14]:10470 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262008AbVF0X1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:27:11 -0400
Date: Mon, 27 Jun 2005 23:27:09 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
To: linux-kernel@vger.kernel.org
In-Reply-To: <200506271521.j5RFL5Z02225@freya.yggdrasil.com> (from
	adam@yggdrasil.com on Mon Jun 27 17:21:05 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119914829l.29992l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 28 Jun 2005 01:27:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I will post in this dicussion, even I'm not aware of any
techical/religious concerns with devfs, udev and co.
I just want to give a suer/admin point of view.
Flame-proof suit goes on...

On 06.27, Adam J. Richter wrote:
> On 2005-06-24, Greg KH wrote:
> >Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> >tiny:
> >$ size fs/ndevfs/inode.o 
> >   text    data     bss     dec     hex filename
> >   1571     200       8    1779     6f3 fs/ndevfs/inode.o
> >replacement for devfs for those embedded users who just can't live
> >without the damm thing.  It doesn't allow subdirectories, and only uses
> >LSB compliant names.  But it works, and should be enough for people to
> >use, if they just can't wean themselves off of the idea of an in-kernel
> >fs to provide device nodes.
> >
> >Now, with this, is there still anyone out there who just can't live
> >without devfs in their kernel?
> >
> >Damm, the depths I've sunk to these days, I'm such a people pleaser...
> >
> >Comments?  Questions?  Criticisms?
> 
...
> 
> 	To start with the most obvious, subdirectories in /dev is
> something many people find to be a much more readable user interface
> (which can save human time and avoid mistakes, which is often the whole
> point of computers).
> 

I agree on this.

> 	Perhaps less obvious, ndevfs system lacks demand-loading
> functionality, which will typically make your system consume _more_
> memory than a system using either the old devfs or my lookup trapping
> facility that I separated from my devfs variant.  With demand loading,
> it is not necessary to load modules for sound interfaces, or devices
> that are available but will not be used before the computer shuts down,
> or even to spin up disks to scan partition tables that will not be used.
> It can also be useful to be able to create soft devices on demand that
> have no hardware counterpart, especially in /dev/mapper/.
> 

What I would like (I know the answer will be 'write it', but anyways...)

- Boot with an empty /dev. Especially for diskless nodes on clusters
- Mount a filesystem on /dev that shows the registered drivers _at the
  moment of mount action_. No need to magically show devices afterwards.
  Let rc mount it as the very first thing it does. Or even it could
  be mounted in kernel just before calling init, to allow booting
  with init=/bin/bash and have a console...
- That filesystem should allow all normal ops (mkdir, ln -s, chmod ...)
  to let udev do its work after init starts.
- Let devices appear on /sys, and let userspace decide if it wants the
  device created or not and where.

No magical load of drivers if I access a non existent device node. What
for ? I want the node when device is there, not when somebody tries to
open it. I want the device when the user plugs its firewire drive, not
when he tries to open it and forgot to plug it.

What about devices present but not used ? Is it so big the overload in
memory that an embedded system will have ? Sure you can shave many more
bytes in userspace...
What if I don't want to see sound devices even if I have the hardware ?
Write the right init scripts sequence. Nowadays distros use udev, but
just start udev and let it create everything. All it finds under /sys.
You could split current udev
in each subsytem, and make the sound initscript to do something like
'udevstart SOUND' (don't remember the exact syntax) to create the
sound device nodes (forced hotplugging ?). If you don't start sound,
no sound devices. With a fully configured udev/hotplug system, perhaps
initscripts could reduce to 'udevstart XXXX'...

I am surely missing too many techical details, but this is what I would
really like to see from a user point of view.

Is it so difficult to get an agreement ?


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam4 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


