Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVLCBaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVLCBaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLCBaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:30:19 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:56020 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750783AbVLCBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:30:18 -0500
Subject: [ANNOUNCE] clean-boot.pl version 0.1 - Simple utility to clean up
	/boot and /lib/modules
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 20:30:15 -0500
Message-Id: <1133573415.32583.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this has been done already or not (let me know if it
has), but I've just noticed that after playing with several
developmental kernels I had about 30 to 40 different versions of
vmlinuz, initrd.img, config, and System.maps in my /boot directory, not
to mention all the modules loaded in /lib/modules.

So I wrote this perl script that let me pick and choose what I wanted to
clean up.  Be careful, this must be run as root, and although the
default is to do nothing, if you hit a "y" in the wrong place, you can
lose that kernel.

The script is here:

http://www.kihontech.com/code/clean-boot.pl

Here's the usage:

# ./clean-boot.pl -h

usage: clean-boot.pl [-b boot_dir] [-m module_dir]
  (version 0.1)
   default boot_dir = /boot
   default module_dir = /lib/modules

It's run like the following:

---
#./clean-boot.pl
List of versions found:
  2.6.12-1-386              2.6.14                    2.6.14-2-386
  2.6.14-2-k7-smp           2.6.14-kthrt2             2.6.14-rt13
  2.6.14-rt13-logdev1       2.6.14-rt15               2.6.14-rt20
  2.6.15-rc3
Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  ?
  y - remove files from boot and modules
  n [default] - skip this version
  l - list the found versions again
  q - quit
  ? - display this message
Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  q
---

If you hit "y" (or yes or ye, case is ignored), it will then remove any
of the vmlinuz, initrd.img, config and System.map files for version
2.6.12-1-386 in /boot and the directory /lib/modules/2.6.12-1-386.

This is under just a public license, no warranty, so just be careful not
to delete too much.

Also remember to update lilo or grub, since this doesn't handle that.

Comments?

-- Steve

