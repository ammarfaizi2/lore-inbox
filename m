Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSGKW7n>; Thu, 11 Jul 2002 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSGKW7m>; Thu, 11 Jul 2002 18:59:42 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59397 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312973AbSGKW7l>;
	Thu, 11 Jul 2002 18:59:41 -0400
Date: Thu, 11 Jul 2002 16:02:23 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020711230222.GA5143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 13 Jun 2002 21:53:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So there I was, trying to remove pci_find_device() and pci_find_class()
from the 2.5 kernel (it's an old depreciated api, so don't start
complaining...) when I ran across the agpgart code which uses
pci_find_class().  I realized I'd have to fix this driver to use the
"new" pci api if I had a chance of getting rid of pci_find_class().
Dave Jones had previously split up this driver into some very nice
logical parts, and it has been living successfully in his tree for a
while now.

So I took that patch, and cleaned it up a bit more (removed some
unneeded typedefs, whitespace changes, moved the Config.in and
Configure.help stuff to the drivers/char/agp directory) and ported the
driver to the pci_register_module() api.  It seems to work for me, so I
would appreciate it if other people tested it out before I sent it on to
Linus for inclusion in the main 2.5 tree.

It can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/misc/agpgart-2.5.25.patch.bz2

Here's the diffstat output of it:
 drivers/char/Config.help             |   87 
 drivers/char/Config.in               |   15 
 drivers/char/agp/Config.help         |   88 
 drivers/char/agp/Config.in           |   14 
 drivers/char/agp/Makefile            |   13 
 drivers/char/agp/agp.h               |  348 +-
 drivers/char/agp/agpgart_be-ali.c    |  265 ++
 drivers/char/agp/agpgart_be-amd.c    |  408 +++
 drivers/char/agp/agpgart_be-hp.c     |  394 +++
 drivers/char/agp/agpgart_be-i460.c   |  595 ++++
 drivers/char/agp/agpgart_be-i810.c   |  594 ++++
 drivers/char/agp/agpgart_be-i8x0.c   |  720 +++++
 drivers/char/agp/agpgart_be-sis.c    |  142 +
 drivers/char/agp/agpgart_be-sworks.c |  626 +++++
 drivers/char/agp/agpgart_be-via.c    |  151 +
 drivers/char/agp/agpgart_be.c        | 4368 +++--------------------------------
 drivers/char/agp/agpgart_fe.c        |   15 
 include/linux/agp_backend.h          |    6 
 include/linux/agpgart.h              |   10 
 19 files changed, 4682 insertions(+), 4177 deletions(-)

thanks,

greg k-h
