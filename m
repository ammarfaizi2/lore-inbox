Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDFBx4>; Thu, 5 Apr 2001 21:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbRDFBxq>; Thu, 5 Apr 2001 21:53:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19724 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S130507AbRDFBxa>; Thu, 5 Apr 2001 21:53:30 -0400
Date: Thu, 5 Apr 2001 21:45:22 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 fails to boot with initrd - solved
Message-ID: <Pine.LNX.3.96.1010405214420.18763A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM:

  kernel 2.4.3 will not boot on systems with initrd files

DESCRIPTION

  Building kernel 2.4.3 and attempting to boot it failed. The problem
turned out to be in the modutils-2.4.5 rpm for i386.

DETAIL

  After building the 2.4.3 kernel and moving the boot modules to the
initrd image, it was noted the the system stopped when trying to load
modules for the root filesystem device. First solution attempted was to
get the i386 rpm from kernel.org for the latest (2.4.5) modutils and
install, copying the insmod program to the initrd image.

  This fails, with the message "insmod: no such program" at boot.
Examination showed that the binary provided was not static linked. Got
the source from kernel.org and built. By default this still isn't static
linked! Changed the common Makfile to set LDFLAGS to "-static -s" and
built again. After install and copy to initrd image this resulted in a
bootable system.

  While it is possible to copy the libraries needed to the initrd image,
it becomes larger than the default ramdisk size (at least on my system).
And including the drivers in the kernel hurts portability and makes the
kernel too large to boot from floppy.

SYSTEMS AFFECTED

  Redhat 7.x and similar using configurations which have the root device
driver loaded from modules.

SUGGESTED FIX

  None needed, but the kernel "Changes" file should include a note that
people using initrd will need to rebuild them static along with the note
that a newer modutils is needed. Even for people who build their own
initrd files, this is NOT obvious!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

