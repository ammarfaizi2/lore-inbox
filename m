Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUKHQsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUKHQsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKHQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:48:09 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261860AbUKHPNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:13:23 -0500
Date: Mon, 8 Nov 2004 10:12:39 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: insmod module-loading errors, Linux-2.6.9
Message-ID: <Pine.LNX.4.61.0411081007530.3682@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello module wizards,

If one makes changes to the kernel configuration,
compiles, then attempts to install the new kernel,
there are two possible things that happen.

(1) One does `make modules_install` before `make install`
or...
(2) One does `make install` before `make modules_install'.

In the first case, `make install` may fail because the
loop device module fails to load with:

Script started on Mon 08 Nov 2004 09:07:41 AM EST
# insmod loop.ko
insmod: error inserting 'loop.ko': -1 Invalid module format
# insmod -f loop.ko
insmod: error inserting 'loop.ko': -1 Invalid module format
# dmesg | tail --lines 2
loop: version magic '2.6.9 SMP preempt PENTIUM4 gcc-3.3' should be '2.6.9 SMP PENTIUM4 gcc-3.3'
loop: version magic '2.6.9 SMP preempt PENTIUM4 gcc-3.3' should be '2.6.9 SMP PENTIUM4 gcc-3.3'
# exit
Script done on Mon 08 Nov 2004 09:08:35 AM EST

..OR..

The installation seems to work, but the system won't complete
a boot because modules from the previous configuration were used
in the `initrd` procedure.

This all comes about because the new module loading procedure
won't allow (ignores) the "-f" (force) parameter. So, one
is screwed trying to do something simple like substituting
a preemptive kernel for another if there isn't already an
alternate bootable system on the disk.

Please restore the "-f" parameter passed to insmod. It
was there for a very good reason. This allows one
who encounters the module-loading error while installing
the kernel to force the module loading. In this way, the
correct modules are used to generate the new `initrd` image.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
