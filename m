Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSGQXaX>; Wed, 17 Jul 2002 19:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSGQXaX>; Wed, 17 Jul 2002 19:30:23 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:28164 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316835AbSGQXaV>;
	Wed, 17 Jul 2002 19:30:21 -0400
Date: Wed, 17 Jul 2002 16:32:08 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] agpgart changes for 2.5.26 - take 2
Message-ID: <20020717233207.GC10369@kroah.com>
References: <20020717183615.GB9589@kroah.com> <20020717213056.I18170@suse.de> <20020717203601.GB10047@kroah.com> <20020717224355.B9489@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717224355.B9489@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, I've changed the resulting filenames based on everyone's comments.
Sorry for not catching that email from you the first time around.
Yes, the difftool output for these changes is quite messy, but they are
just 'bk mv' commands :)

These changesets have the latest agpgart code from the -dj tree, and
I've tried to rename the files to something that makes more sense.


Pull from:  http://linuxusb.bkbits.net/agpgart-2.5

 drivers/char/agp/agp.c               | 1664 +++++++++++++
 drivers/char/agp/agpgart_be-ali.c    |  265 --
 drivers/char/agp/agpgart_be-ali.c    |  265 ++
 drivers/char/agp/agpgart_be-amd.c    |  408 ---
 drivers/char/agp/agpgart_be-amd.c    |  408 +++
 drivers/char/agp/agpgart_be.c        | 1662 -------------
 drivers/char/agp/agpgart_be.c        | 4470 +++--------------------------------
 drivers/char/agp/agpgart_be-hp.c     |  394 ---
 drivers/char/agp/agpgart_be-hp.c     |  394 +++
 drivers/char/agp/agpgart_be-i460.c   |  595 ----
 drivers/char/agp/agpgart_be-i460.c   |  595 ++++
 drivers/char/agp/agpgart_be-i810.c   |  594 ----
 drivers/char/agp/agpgart_be-i810.c   |  594 ++++
 drivers/char/agp/agpgart_be-i8x0.c   |  726 -----
 drivers/char/agp/agpgart_be-i8x0.c   |  728 +++++
 drivers/char/agp/agpgart_be-sis.c    |  142 -
 drivers/char/agp/agpgart_be-sis.c    |  142 +
 drivers/char/agp/agpgart_be-sworks.c |  626 ----
 drivers/char/agp/agpgart_be-sworks.c |  626 ++++
 drivers/char/agp/agpgart_be-via.c    |  151 -
 drivers/char/agp/agpgart_be-via.c    |  151 +
 drivers/char/agp/agpgart_fe.c        | 1086 --------
 drivers/char/agp/agpgart_fe.c        |   15 
 drivers/char/agp/agp.h               |  348 +-
 drivers/char/agp/ali-agp.c           |  265 ++
 drivers/char/agp/ali.c               |  265 --
 drivers/char/agp/ali.c               |  265 ++
 drivers/char/agp/amd-agp.c           |  408 +++
 drivers/char/agp/amd.c               |  408 ---
 drivers/char/agp/amd.c               |  408 +++
 drivers/char/agp/Config.help         |   88 
 drivers/char/agp/Config.in           |   14 
 drivers/char/agp/frontend.c          | 1086 ++++++++
 drivers/char/agp/hp-agp.c            |  394 +++
 drivers/char/agp/hp.c                |  394 ---
 drivers/char/agp/hp.c                |  394 +++
 drivers/char/agp/i460-agp.c          |  595 ++++
 drivers/char/agp/i460.c              |  595 ----
 drivers/char/agp/i460.c              |  595 ++++
 drivers/char/agp/i810-agp.c          |  594 ++++
 drivers/char/agp/i810.c              |  594 ----
 drivers/char/agp/i810.c              |  594 ++++
 drivers/char/agp/i8x0-agp.c          |  726 +++++
 drivers/char/agp/i8x0.c              |  726 -----
 drivers/char/agp/i8x0.c              |  726 +++++
 drivers/char/agp/Makefile            |   53 
 drivers/char/agp/sis-agp.c           |  142 +
 drivers/char/agp/sis.c               |  142 -
 drivers/char/agp/sis.c               |  142 +
 drivers/char/agp/sworks-agp.c        |  626 ++++
 drivers/char/agp/sworks.c            |  626 ----
 drivers/char/agp/sworks.c            |  626 ++++
 drivers/char/agp/via-agp.c           |  151 +
 drivers/char/agp/via.c               |  151 -
 drivers/char/agp/via.c               |  151 +
 include/linux/agp_backend.h          |    6 
 include/linux/agpgart.h              |   10 
 57 files changed, 15310 insertions(+), 14699 deletions(-)
------

ChangeSet@1.645, 2002-07-17 16:16:42-07:00, greg@kroah.com
  agpgart: added "-agp" to the .c files that are for specific hardware types, based on mailing list comments.

 drivers/char/agp/ali.c        |  265 ---------------
 drivers/char/agp/amd.c        |  408 -----------------------
 drivers/char/agp/hp.c         |  394 ----------------------
 drivers/char/agp/i460.c       |  595 ----------------------------------
 drivers/char/agp/i810.c       |  594 ----------------------------------
 drivers/char/agp/i8x0.c       |  726 ------------------------------------------
 drivers/char/agp/sis.c        |  142 --------
 drivers/char/agp/sworks.c     |  626 ------------------------------------
 drivers/char/agp/via.c        |  151 --------
 drivers/char/agp/Makefile     |   18 -
 drivers/char/agp/ali-agp.c    |  265 +++++++++++++++
 drivers/char/agp/amd-agp.c    |  408 +++++++++++++++++++++++
 drivers/char/agp/hp-agp.c     |  394 ++++++++++++++++++++++
 drivers/char/agp/i460-agp.c   |  595 ++++++++++++++++++++++++++++++++++
 drivers/char/agp/i810-agp.c   |  594 ++++++++++++++++++++++++++++++++++
 drivers/char/agp/i8x0-agp.c   |  726 ++++++++++++++++++++++++++++++++++++++++++
 drivers/char/agp/sis-agp.c    |  142 ++++++++
 drivers/char/agp/sworks-agp.c |  626 ++++++++++++++++++++++++++++++++++++
 drivers/char/agp/via-agp.c    |  151 ++++++++
 19 files changed, 3910 insertions(+), 3910 deletions(-)
------

ChangeSet@1.643, 2002-07-15 11:54:20-07:00, greg@kroah.com
  agpgart: added agp prefix to the debug printk

 drivers/char/agp/agp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.642, 2002-07-15 11:46:17-07:00, greg@kroah.com
  agpgart: renamed the agp files to make more sense

 drivers/char/agp/agpgart_be-ali.c    |  265 -----
 drivers/char/agp/agpgart_be-amd.c    |  408 --------
 drivers/char/agp/agpgart_be-hp.c     |  394 --------
 drivers/char/agp/agpgart_be-i460.c   |  595 ------------
 drivers/char/agp/agpgart_be-i810.c   |  594 ------------
 drivers/char/agp/agpgart_be-i8x0.c   |  726 ---------------
 drivers/char/agp/agpgart_be-sis.c    |  142 --
 drivers/char/agp/agpgart_be-sworks.c |  626 -------------
 drivers/char/agp/agpgart_be-via.c    |  151 ---
 drivers/char/agp/agpgart_be.c        | 1662 -----------------------------------
 drivers/char/agp/agpgart_fe.c        | 1086 ----------------------
 drivers/char/agp/Makefile            |   22 
 drivers/char/agp/agp.c               | 1662 +++++++++++++++++++++++++++++++++++
 drivers/char/agp/ali.c               |  265 +++++
 drivers/char/agp/amd.c               |  408 ++++++++
 drivers/char/agp/frontend.c          | 1086 ++++++++++++++++++++++
 drivers/char/agp/hp.c                |  394 ++++++++
 drivers/char/agp/i460.c              |  595 ++++++++++++
 drivers/char/agp/i810.c              |  594 ++++++++++++
 drivers/char/agp/i8x0.c              |  726 +++++++++++++++
 drivers/char/agp/sis.c               |  142 ++
 drivers/char/agp/sworks.c            |  626 +++++++++++++
 drivers/char/agp/via.c               |  151 +++
 23 files changed, 6660 insertions(+), 6660 deletions(-)
------

ChangeSet@1.641, 2002-07-15 10:33:27-07:00, greg@kroah.com
  agpgart: fix syntax error in the i8x0 file.

 drivers/char/agp/agpgart_be-i8x0.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.640, 2002-07-15 10:26:18-07:00, greg@kroah.com
  agpgart: Split agpgart code into separate files.
  
  The majority of this work was done by Dave Jones, I merely converted the
  driver to the "new" pci api.

 drivers/char/agp/Config.help         |   88 
 drivers/char/agp/Config.in           |   14 
 drivers/char/agp/Makefile            |   13 
 drivers/char/agp/agp.h               |  348 +-
 drivers/char/agp/agpgart_be-ali.c    |  265 ++
 drivers/char/agp/agpgart_be-amd.c    |  408 +++
 drivers/char/agp/agpgart_be-hp.c     |  394 +++
 drivers/char/agp/agpgart_be-i460.c   |  595 ++++
 drivers/char/agp/agpgart_be-i810.c   |  594 ++++
 drivers/char/agp/agpgart_be-i8x0.c   |  726 +++++
 drivers/char/agp/agpgart_be-sis.c    |  142 +
 drivers/char/agp/agpgart_be-sworks.c |  626 ++++
 drivers/char/agp/agpgart_be-via.c    |  151 +
 drivers/char/agp/agpgart_be.c        | 4470 +++--------------------------------
 drivers/char/agp/agpgart_fe.c        |   15 
 include/linux/agp_backend.h          |    6 
 include/linux/agpgart.h              |   10 
 17 files changed, 4738 insertions(+), 4127 deletions(-)
------

