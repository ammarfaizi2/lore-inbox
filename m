Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSLEQYe>; Thu, 5 Dec 2002 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSLEQYe>; Thu, 5 Dec 2002 11:24:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10512 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261463AbSLEQYa>;
	Thu, 5 Dec 2002 11:24:30 -0500
Date: Thu, 5 Dec 2002 08:31:52 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.50
Message-ID: <20021205163152.GA2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few minor fixes left over from the last security ops changes,
a big cleanup of the "default" security operations, and an small example
security module for people to use as a template (yes, it does add two
exported symbols from the USB core, but I'm ok with that :).

Please pull from:
        bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h
	

 drivers/usb/core/hcd.c |    2 
 fs/hugetlbfs/inode.c   |    1 
 fs/namei.c             |    2 
 security/Kconfig       |   10 
 security/Makefile      |    1 
 security/capability.c  |  530 -------------------------------------------------
 security/dummy.c       |  169 ++++++++++++---
 security/root_plug.c   |  189 +++++++++++++++++
 security/security.c    |   50 ----
 9 files changed, 349 insertions(+), 605 deletions(-)
------

ChangeSet@1.797.142.4, 2002-12-04 16:56:51-06:00, greg@kroah.com
  LSM: add the example rootplug module

 drivers/usb/core/hcd.c |    2 
 security/Kconfig       |   10 ++
 security/Makefile      |    1 
 security/root_plug.c   |  189 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+)
------

ChangeSet@1.797.142.3, 2002-12-04 16:14:32-06:00, greg@kroah.com
  LSM: remove "dummy" functions from the capability code, as they are no longer needed.

 security/capability.c |  530 --------------------------------------------------
 1 files changed, 530 deletions(-)
------

ChangeSet@1.797.142.2, 2002-12-04 16:01:47-06:00, greg@kroah.com
  LSM: Added security_fixup_ops()
  
  This allows LSM code to only define the functions that they want to,
  and not be forced to provide "dummy" functions for everything else.

 security/dummy.c    |  169 ++++++++++++++++++++++++++++++++++++++++++----------
 security/security.c |   50 +--------------
 2 files changed, 145 insertions(+), 74 deletions(-)
------

ChangeSet@1.797.131.2, 2002-11-30 00:59:35-08:00, greg@kroah.com
  LSM: add #include <linux/security.h> to fs/hugetlbfs/inode.c
  
  Thanks to venom@sns.it for pointing this out.

 fs/hugetlbfs/inode.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.797.131.1, 2002-11-30 00:13:57-08:00, steve@kbuxd.necst.nec.co.jp
  [PATCH] fs/namei.c fix
  
  One of Greg KH's security cleanups reversed the sense of a test.
  Without this patch, 2.5.50 oopses at boot.  Please apply.

 fs/namei.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

