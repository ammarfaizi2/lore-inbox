Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131256AbQKTGIQ>; Mon, 20 Nov 2000 01:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131268AbQKTGIH>; Mon, 20 Nov 2000 01:08:07 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:24591 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S131256AbQKTGID>;
	Mon, 20 Nov 2000 01:08:03 -0500
Message-Id: <200011200646.BAA17412@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.34-2.4.0-test11
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Nov 2000 01:46:27 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.0-test11 is available.

UML is now able to run as a daemon, i.e. with no stdin/stdout/stderr.

The hostfs filesystem now works as a readonly filesystem.  It's now 
configurable.  I'm using it as a module.  It ought to work compiled into the 
kernel, but I haven't checked this.

I fixed a number of bugs.

NOTE:  If you compile from source, you must put 'ARCH=um' on the make command 
line or in the environment, like:
	make linux ARCH=um
or
	ARCH=um make linux
or
	export ARCH=um
	make linux

This is because I've changed the top-level Makefile to build either a native 
kernel or a usermode kernel, with the default being native.  This is in 
preparation for submitting this port to the main pool.  The ARCH calculation 
is now this:

# SUBARCH tells the usermode build what the underlying arch is.  That is set
# first, and if a usermode build is happening, the "ARCH=um" on the command
# line overrides the setting of ARCH below.  If a native build is happening,
# then ARCH is assigned, getting whatever value it gets normally, and 
# SUBARCH is subsequently ignored.

SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
s/arm.*/arm/ -e s/sa110/arm/)
ARCH := $(SUBARCH)

If anyone has any objections to this going in the main pool, let me know, and 
also let me know what you would suggest as a fix.

The project's home page is http://user-mode-linux.sourceforge.net

The project's download page is http://sourceforge.net/project/filelist.php?grou
p_id=429

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
