Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282233AbRKWUfX>; Fri, 23 Nov 2001 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282235AbRKWUfO>; Fri, 23 Nov 2001 15:35:14 -0500
Received: from [212.18.232.186] ([212.18.232.186]:21765 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282233AbRKWUe6>; Fri, 23 Nov 2001 15:34:58 -0500
Date: Fri, 23 Nov 2001 20:34:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15: FS corruption on EXT2
Message-ID: <20011123203452.A3141@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just been testing 2.4.15 on my NetWinder (which was running 2.4.15-pre5
quite happily - its built several kernels and been through a fair number of
reboot cycles with that version).

With 2.4.15, I can now 100% reproduce every time filesystem corruption of
an ext2 filesystem, specifically in /var/lock/subsys/.

/var/lock/subsys contains a load of 0 byte files, one for each daemon that
is started by the redhat-like boot scripts.  On shutdown they're removed.

After a second boot with 2.4.15, all the names are still present in the
directory, rm complains with:

	rm: cannot remove `/var/lock/subsys/xyz': Input/output error

stracing rm reveals that lstat of a file in /var/lock/subsys/ returns -EIO.
Trying to get a directory listing results in every single file giving an
input/output error.

This is just a heads up - several people are already looking into it.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

