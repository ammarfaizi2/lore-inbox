Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbRBAEaG>; Wed, 31 Jan 2001 23:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129629AbRBAE35>; Wed, 31 Jan 2001 23:29:57 -0500
Received: from bluebox.ne.mediaone.net ([24.91.117.20]:17414 "EHLO
	osiris.978.org") by vger.kernel.org with ESMTP id <S129314AbRBAE3p>;
	Wed, 31 Jan 2001 23:29:45 -0500
Date: Wed, 31 Jan 2001 23:29:44 -0500
From: Brian Ristuccia <brian@ristuccia.com>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net,
        Alex Pennace <alex@osiris.978.org>,
        Dennis Ristuccia <dennis@osiris.978.org>
Subject: usermode linux hoses 2.2.18-SMP host machine when run from regular user account
Message-ID: <20010131232944.J16908@osiris.978.org>
Mail-Followup-To: brianr@osiris.978.org, linux-kernel@vger.rutgers.edu,
	user-mode-linux-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When run from a normal user account with its current working directory on a
NFS filesystem, usermode linux causes the host machine's kernel to enter a
hosed state. No processes (including UML) seem to respond, and the machine
becomes unusable.

I am running 2.2.18 built with SMP and hedrick's IDE patches on a dual
Celeron 366@550 box with 384mB of ram. I have also reproduced the crash on a
single Celeron 366@550 w/ 256mB of ram running 2.2.18-SMP w/ hedrick's IDE
patches, and a dual PPro 166 w/ 256mB of RAM running 2.2.18pre23 unmodified
from the version distributed by Alan Cox. The crash occurs with both the
usermode linux 2.4.0 binary from their web site and the linux 2.4.1 binary
there. I am using the root filesystem image file that comes in the tarball
named deb-package-2.4.0.tar.bz2. The crash comes after the line "INIT:
version 2.78 booting" during the virtual machine's boot sequence. The UML
web site is at http://user-mode-linux.sourceforge.net/

The UML people report that UML doesn't work when being run from an NFS
filesystem: 

  UML doesn't work when it is being run from an NFS filesystem: This seems to
  be a similar situation with the resierfs problem above. Some versions of
  NFS seems not to handle mmap correctly, which UML depends on.  The fix is
  to run UML in a non-NFS directory. The kernel binary and root filesystem
  be be mounted from NFS; UML itself just has to be running in a non-NFS
  directory.

But I can't see how something done in userspace should hang the whole
machine, especially when I set up low hard ulimits to prevent all system
resources from being consumed. The statistics I'm able to gather from
ctrl/shift-scrlock don't seem to indicate memory or process table overuse.

Alt-Fx still switches consoles unless X is running. Ctrl/shift-scrlock still
displays the usual debug stuff. The machine is still pingable and still
accepts tcp/ip connections but you don't get any response from the listening
daemon. Otherwise the box is hung. Ctrl-alt-del won't run the ctrlaltdel
entry in inittab. Hardware reset is required to restore machine to normal
operation.

-- 
Brian Ristuccia
brian@ristuccia.com
bristucc@cs.uml.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
