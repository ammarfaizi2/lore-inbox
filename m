Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDDWMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUDDWMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:12:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48135 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262874AbUDDWMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:12:23 -0400
Date: Sun, 4 Apr 2004 23:12:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marek Szuba <scriptkiddie@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5] A bunch of various minor bugs not fixed since 2.6.4
Message-ID: <20040404231219.D17113@flint.arm.linux.org.uk>
Mail-Followup-To: Marek Szuba <scriptkiddie@wp.pl>,
	linux-kernel@vger.kernel.org
References: <20040404235411.7ffde014.scriptkiddie@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040404235411.7ffde014.scriptkiddie@wp.pl>; from scriptkiddie@wp.pl on Sun, Apr 04, 2004 at 11:54:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 11:54:11PM +0200, Marek Szuba wrote:
> 1. 'make *config' fails with missing header files

Only people who try to build userspace programs against current
kernel header files experience this problem.

> 2. Platform-specific 'asm' symlink doesn't get created by 'make *config'

This is only a problem for people trying to build userspace programs
against current kernel header files.

> 3. 'make clean' seems to remove too much

See 2.

These three complaints seem to revolve around your attempt to use
the kernels header files for building user space programs against.
This is something which hasn't really been supported by the kernel
for many versions (since before 2.4) as you will find when searching
the LKML archives.

/usr/include/{asm,linux} are supposed to be a copy of the sanitised
kernel headers which were used *when glibc was built* (the words
between the '*' are the important ones here.)

> 4. Floppy LED remains on whenever LILO boots the kernel quickly

This is a lilo bug - lilo is supposed to turn off the floppy motor before
calling the kernel; the kernel has dropped its work-around for this bug
and expects the boot loader to do it.

Alternatively, build a kernel with floppy support built in.

> 6. (not really a bug) It would be nice if the ieee1394 subsystem got
> sysfs'ed soon...

sysfs'ing subsystems is a complex task, one which requires very careful
analysis.  Don't expect ieee1394 to change overnight (or if it does,
expect your kernel to be unstable.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
