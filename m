Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbTCTWTf>; Thu, 20 Mar 2003 17:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbTCTWTf>; Thu, 20 Mar 2003 17:19:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22533 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262664AbTCTWTb>;
	Thu, 20 Mar 2003 17:19:31 -0500
Date: Thu, 20 Mar 2003 14:30:47 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.65
Message-ID: <20030320223046.GA4959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver cleanups.  These do the following items I
mentioned in my last set of patches:
	- clean up #ifdef mess in i2c controllers
	- fix the printk() calls to use proper levels
	- add i2c controller driver core support

There is also a i2c spelling patch in here, and I've added the i2c-isa
driver, which almost isn't even a driver at all, based on the size of
it. 

Even with adding a new driver, the sum of these patches is still a
smaller number of lines than we started with, which is always nice.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

Things left to do after this:
	- clean up i2c driver core support to work better.
	- add i2c device core support.
	- port remaining drivers from i2c cvs to kernel tree.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig       |   18 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali15x3.c |  304 ++++++++++++++------------------
 drivers/i2c/busses/i2c-amd756.c  |  142 +++++++--------
 drivers/i2c/busses/i2c-amd8111.c |   10 -
 drivers/i2c/busses/i2c-i801.c    |  367 +++++++++++++++------------------------
 drivers/i2c/busses/i2c-isa.c     |   62 ++++++
 drivers/i2c/busses/i2c-piix4.c   |  205 +++++++++------------
 drivers/i2c/chips/adm1021.c      |    4 
 drivers/i2c/chips/lm75.c         |    2 
 drivers/i2c/i2c-algo-pcf.c       |    6 
 drivers/i2c/i2c-core.c           |   22 ++
 drivers/i2c/i2c-proc.c           |    2 
 include/linux/i2c.h              |    3 
 14 files changed, 554 insertions(+), 594 deletions(-)
-----

ChangeSet@1.1143.1.16, 2003-03-20 12:07:55-08:00, greg@kroah.com
  i2c: add initial driver model support for i2c drivers.

 drivers/i2c/i2c-core.c |   22 ++++++++++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 25 insertions(+)
------

ChangeSet@1.1143.1.15, 2003-03-20 11:47:43-08:00, greg@kroah.com
  i2c: added i2c-isa bus controller driver.
  
  Based on the i2c cvs version of this driver.

 drivers/i2c/busses/Kconfig   |   18 ++++++++++++
 drivers/i2c/busses/Makefile  |    1 
 drivers/i2c/busses/i2c-isa.c |   62 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
------

ChangeSet@1.1143.1.14, 2003-03-20 11:28:11-08:00, greg@kroah.com
  i2c i2c-amd8111.c: change the pci driver name to have "2" in it based on previous comments.

 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1143.1.13, 2003-03-20 11:16:19-08:00, greg@kroah.com
  [PATCH] i2c i2c-amd8111.c: change a few printk() to dev_warn()

 drivers/i2c/busses/i2c-amd8111.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.1143.1.12, 2003-03-20 11:15:57-08:00, greg@kroah.com
  [PATCH] i2c i2c-amd756.c: remove some #ifdefs and fix all printk() to use dev_*().
  
  Also some minor whitespace cleanups.

 drivers/i2c/busses/i2c-amd756.c |  142 +++++++++++++++++++---------------------
 1 files changed, 70 insertions(+), 72 deletions(-)
------

ChangeSet@1.1143.1.11, 2003-03-20 11:15:37-08:00, greg@kroah.com
  [PATCH] i2c i2c-ali15x3.c: fix up formatting and whitespace issues.

 drivers/i2c/busses/i2c-ali15x3.c |  184 ++++++++++++++++++---------------------
 1 files changed, 88 insertions(+), 96 deletions(-)
------

ChangeSet@1.1143.1.10, 2003-03-20 11:15:18-08:00, greg@kroah.com
  [PATCH] i2c i2c-ali15x3.c: remove check_region() call.

 drivers/i2c/busses/i2c-ali15x3.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)
------

ChangeSet@1.1143.1.9, 2003-03-20 11:14:58-08:00, greg@kroah.com
  [PATCH] i2c i2c-ali15x3.c: remove #ifdefs and fix all printk() to use dev_*().

 drivers/i2c/busses/i2c-ali15x3.c |  115 +++++++++++++++------------------------
 1 files changed, 45 insertions(+), 70 deletions(-)
------

ChangeSet@1.1143.1.8, 2003-03-19 11:29:45-08:00, elenstev@mesatop.com
  [PATCH] i2c: spelling corrections for drivers/i2c
  
  Here are some spelling and typo fixes for drivers/i2c.

 drivers/i2c/chips/adm1021.c |    4 ++--
 drivers/i2c/chips/lm75.c    |    2 +-
 drivers/i2c/i2c-algo-pcf.c  |    6 +++---
 drivers/i2c/i2c-proc.c      |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
------

ChangeSet@1.1143.1.7, 2003-03-18 17:13:06-08:00, greg@kroah.com
  [PATCH] i2c i2c-piix4.c: fix up formatting and whitespace issues.

 drivers/i2c/busses/i2c-piix4.c |   80 +++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 42 deletions(-)
------

ChangeSet@1.1143.1.6, 2003-03-18 17:12:28-08:00, greg@kroah.com
  [PATCH] i2c i2c-piix4: remove #ifdefs and fix all printk() to use dev_*().

 drivers/i2c/busses/i2c-piix4.c |  120 ++++++++++++++++-------------------------
 1 files changed, 49 insertions(+), 71 deletions(-)
------

ChangeSet@1.1143.1.5, 2003-03-18 17:10:51-08:00, greg@kroah.com
  [PATCH] i2c i2c-piix4.c: remove check_region() call.

 drivers/i2c/busses/i2c-piix4.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)
------

ChangeSet@1.1143.1.4, 2003-03-18 14:37:45-08:00, greg@kroah.com
  [PATCH] i2c i2c-i801.c: fix up formatting and whitespace issues.
  
  Also made everything static, no global functions are needed here.

 drivers/i2c/busses/i2c-i801.c |  177 ++++++++++++++++++------------------------
 1 files changed, 77 insertions(+), 100 deletions(-)
------

ChangeSet@1.1143.1.3, 2003-03-18 14:37:20-08:00, greg@kroah.com
  [PATCH] i2c i2c-i801.c: fix up the pci id matching, and change to use proper pci ids.

 drivers/i2c/busses/i2c-i801.c |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)
------

ChangeSet@1.1143.1.2, 2003-03-18 14:36:49-08:00, greg@kroah.com
  [PATCH] i2c i2c-i801.c: remove check_region() usage.

 drivers/i2c/busses/i2c-i801.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
------

ChangeSet@1.1143.1.1, 2003-03-18 14:27:40-08:00, greg@kroah.com
  [PATCH] i2c i2c-i801.c: remove #ifdefs and fix all printk() to use dev_*().

Push file://home/greg/linux/BK/i2c-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/i2c/busses/i2c-i801.c |  157 +++++++++++++++---------------------------
 1 files changed, 58 insertions(+), 99 deletions(-)
------

