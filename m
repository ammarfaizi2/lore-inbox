Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268925AbTCDAm7>; Mon, 3 Mar 2003 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbTCDAm7>; Mon, 3 Mar 2003 19:42:59 -0500
Received: from nef.ens.fr ([129.199.96.32]:30728 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S268925AbTCDAm6>;
	Mon, 3 Mar 2003 19:42:58 -0500
Date: Tue, 4 Mar 2003 01:53:20 +0100
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: unmounting multiply-mounted directories
Message-ID: <20030304015320.A13363@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I use devfs on my installation, even though my distribution
(RedHat-7.3) does not endorse it.  Most of the time it works fine.
However, when I want to upgrade certain packages (for example, that
which contains the entries in the non-devfs /dev directory) I need to
make the original /dev directory visible to the package management
(viz. rpm) program.

Seeing that I cannot unmount the devfs /dev directory since many
processes use it, I figured the best way to do that would be to
temporarily mount the original /dev directory in its place and over
it, and then unmount it.  So I did something like this

mount /dev/sda2 /mnt/bareroot
mount --bind /mnt/bareroot/dev /dev
rpm -U whichever-package-needs-to-access-dev.whatever.rpm

This worked fine.  Unfortunately, I then discovered that I couldn't
unmount the /dev directory!  I get this:

vega root ~ # umount /dev
umount: /dev: device is busy
umount: /dev: device is busy

Hum, why am I getting the error message twice?  Is it because I have
two different mounts on the same /dev mountpoint?

Anyway, I would like to trace that "device is busy" error back to its
causes, that is, determine which processes are preventing me from
unmounting the topmost /dev mount.  How do I do that?  I tried using
fuser but it is useless: it does not have an option to distinguish
open files from the bottommost /dev mount and from the topmost.  So
how should I distinguish the two?

Actually, all sorts of weird things are happening now.  For example,
the /dev/pts directory is all empty (that doesn't seem to bother xterm
overmuch, though, even if I open new xterms).  Well, I guess I'm in
for an emergency reboot.

But, what would be The Right Way to make the old /dev accessible to a
program that needs to access it?  I can think of running the program
chrooted with a specially mounted / but it doesn't seem perfect
either.  Any other ideas?

Oh, and by the way: is there some documentation to mount --bind
somewhere?  Like, something which explains the detailed semantics of
that operation?

Thank you for your help -

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
