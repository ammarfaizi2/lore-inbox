Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVBQUJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVBQUJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBQUH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:07:58 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:14085 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S261194AbVBQUG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:06:27 -0500
Date: Thu, 17 Feb 2005 21:06:20 +0100
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird, a mkinitrd based on hotplug concepts
Message-ID: <20050217210620.A20645@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, time to stop polishing and start publishing.

This is to announce yaird, Yet Another mkInitRD, a rewrite of mkinitrd
based on hotplug algorithms.

MOTIVATION
==========
Why a rewrite?  The versions of mkinitrd that I studied, Debian sid
and Fedora FC3, have some problems: they capture a lot of knowledge
about the boot process, but don't always understand when a new kernel
uses a different module name than the old kernel, may rely on modules
compiled into the kernel, and don't always catch errors at the earliest
opportunity.

Assumption: there are three issues that cause most of these problems.
 - Backward compatibility: sysfs provides a wealth of information
   about hardware, but if you have to support 2.4 kernels, you have
   to limit yourself in the use you can make of that information.
 - Originality: hotplug does a pretty good job of finding the appropriate
   modules for a device, basically because it closely follows the
   algorithms the kernel uses for matching hardware with modules.
   Deviating from those algorithms is unlikely to produce a more
   robust result.
 - Shell scripting: beyond a certain level of complexity, the shell
   syntax makes it difficult to focus on the data structures you're
   trying to process and makes it difficult to do rigorous error checking.

Yaird is intended to find out whether that assumption is correct: if so, 
a program to build initrd images will be more reliable if it's written
in perl, if it uses sysfs to determine what hardware needs to be supported,
and if it closely follows the methods hotplug uses find the modules
needed to support some hardware.

STATUS
======
There is working code: yaird booted the machine this note is written on.
Code is available online, there also is a paper that discusses the workings
of the application in detail.

	http://www.xs4all.nl/~ekonijn/yaird/

So far, the program works correctly on every machine it's been tested on,
but with only two test boxes that does not mean much.

Basic creature comforts are in place: "configure; make" but no RPM or
deb files, a README and help option but no manual page.

Features:
 - understands SATA and IDE.  USB sticks and SCSI should work, but are
   untested.
 - understands MDADM and LVM2, activates only necessary devices,
   understands stacks like LVM on top of stripe on top of mirror.
 - handles both initrd and initramfs.
 - understands USB keyboards.
 - understands hotplug blacklist.
 - knows that a module compiled into the kernel does not need insmod.
 - understands /etc/fstab, including niceties such as labels, uuids and
   octal escapes.
 - image generation understands symbolic links and shared libraries.
   (should support 32bit emulation on 64bit kernels; untested).
 - templating system to simplify tuning the initrd image to the distribution.
 - avoids hard-coded device numbers; does not require devfs.
 - testing mode gives detailed overview of the systems hardware
   and the modules needed to support that.

There are rough edges in practically every feature: this is suitable
for testing, but not for production use.

TODO
====
(1) Testing so far is 100% successful, but with just two boxes to play
with, that's not saying much.  If you can find space to test the code
on your system, your results are highly appreciated.  At this point,
hardware testing is most valuable: I already know that dm-crypt is
unsupported for now, but whether this stuff can boot a powerbook, sparc,
or just about anything else is an open question.

(2) Feedback.  This may be an interesting idea, but how does it relate
to other new stuff floating about?  In particular, what about the work
that's going on putting udev on initramfs: are these approaches complementary
or alternatives?  Different perspectives on where this stuff fits in would
help.

(3) Support more configurations.  dm-crypt is unsupported for now, and so
are multipath, swsusp, EVMS, NFS and loopback mounts.  Implementing this
stuff becomes interesting once there are some tests results that the
basic ideas work in practice.

Regards,
Erik


