Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbTL3HH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTL3HH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:07:27 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:42961 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S264954AbTL3HHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:07:21 -0500
Date: Tue, 30 Dec 2003 02:07:18 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel panic
Message-ID: <20031230070718.GB2158@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031228020759.GA2158@Master.Wizards> <20031230033036.GA2158@Master.Wizards> <Pine.LNX.4.58.0312292238390.4176@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312292238390.4176@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 10:42:06PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 29 Dec 2003, Murray J. Root wrote:
> > On Sat, Dec 27, 2003 at 09:07:59PM -0500, Murray J. Root wrote:
> > > P4 2GHz
> > > ASUS P4S533 mainboard
> > > 1G PC2700 RAM
> > > GF2 GTS video using nv driver
> > > 2.6.0 compiled with gcc 3.3.2
> > > 
> > > At boot kernel gets:
> > >    INIT: cannot execute "/etc/rc.d/rc.sysinit"
> > > then panic.
> > > 
> > > Same configuration for 2.6.0-test11 and earlier works fine.
> > > 
> > 
> > To answer myself, I did a diff between 2.6.0-test11 and 2.6.0. Found this:
> 
> Sounds like one of the partitions that has the executable script loader is
> mounted with "noexec". 
> 
> On most systems, /etc/rc.d/rc.sysinit is a bash script, and explicitly
> points to /bin/bash. Check "ldd /bin/bash", and verify that all the
> libraries (and /bin itself, of course) are mounted on executable
> filesystems.
> 
> That would be a bug that 2.6.0 uncovers. 
> 

Thought of that. What does the initial mounting of / ? If it's using /etc/fstab
then that isn't the problem - I have no partitions mounting noexec.
/bin and /lib are on the / partition. If it's a script then it's from Mandrake
and I'll have to hunt it down and send them a patch.

Not using devfs or udev. No initrd. All components built-in although module
support is enabled.

/etc/fstab is included below.

-- 
Murray J. Root

[root@Master source]# cat /etc/fstab
/dev/hda1 /mnt/windows vfat iocharset=iso8859-1,codepage=850,umask=0 0 0
/dev/hda5 / reiserfs notail 1 1
/dev/hda6 /usr/local reiserfs notail 1 2
/dev/hda7 /mirror reiserfs notail 1 2
/dev/hda8 /home reiserfs notail 1 2
/dev/hda9 swap swap defaults 0 0
/dev/hda10 /common reiserfs notail 1 2
/dev/hdc /mnt/cdrom iso9660 noauto,nosuid,ro,umask=0,user,nodev 0 0
/dev/hdd /mnt/cdrom2 iso9660 codepage=850,iocharset=iso8859-1,noauto,nosuid,ro,umask=0,user,nodev 0 0
/dev/sda1 /mnt/disk vfat noauto,rw,user,umask=0 0 0
none /dev/pts devpts mode=0620 0 0
none /proc proc defaults 0 0

