Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSGQSe3>; Wed, 17 Jul 2002 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGQSe3>; Wed, 17 Jul 2002 14:34:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:28435 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316503AbSGQSe1>;
	Wed, 17 Jul 2002 14:34:27 -0400
Date: Wed, 17 Jul 2002 11:36:15 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] agpgart changes for 2.5.26
Message-ID: <20020717183615.GB9589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
 drivers/char/agp/ali.c               |  265 ++
 drivers/char/agp/amd.c               |  408 +++
 drivers/char/agp/Config.help         |   88 
 drivers/char/agp/Config.in           |   14 
 drivers/char/agp/frontend.c          | 1086 ++++++++
 drivers/char/agp/hp.c                |  394 +++
 drivers/char/agp/i460.c              |  595 ++++
 drivers/char/agp/i810.c              |  594 ++++
 drivers/char/agp/i8x0.c              |  726 +++++
 drivers/char/agp/Makefile            |   35 
 drivers/char/agp/sis.c               |  142 +
 drivers/char/agp/sworks.c            |  626 ++++
 drivers/char/agp/via.c               |  151 +
 include/linux/agp_backend.h          |    6 
 include/linux/agpgart.h              |   10 
 39 files changed, 11400 insertions(+), 10789 deletions(-)
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

