Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUJHVx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUJHVx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUJHVxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:53:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:53424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265887AbUJHVxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:53:21 -0400
Date: Fri, 8 Oct 2004 14:52:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008145252.M2357@build.pdx.osdl.net>
References: <87k6ubcccl.fsf@sulphur.joq.us> <1096663225.27818.12.camel@krustophenia.net> <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097272140.1442.75.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 05:49:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-08 at 17:45, Chris Wright wrote:
> > > --- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
> > > +++ linux-2.6.8.1-rt02/security/realtime.c	Mon Oct  4 21:35:41 2004
> > > +static int any = 0;			/* if TRUE, any process is realtime */
> > 
> > unecessary init to 0
> > 
> 
> I think gcc 3.4 complains otherwise.

Nah, it's fine.

$ grep 'int any' security/realtime.c
static int any;                 /* if TRUE, any process is realtime */
$ make security/realtime.o
  CC      security/realtime.o
$ gcc --version
gcc (GCC) 3.4.2 20040907 (Red Hat 3.4.2-2)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- security/realtime.c~orig	2004-10-08 14:27:27.000000000 -0700
+++ security/realtime.c	2004-10-08 14:52:31.303484080 -0700
@@ -26,6 +26,7 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/sysctl.h>
+#include <linux/moduleparam.h>
 
 #ifdef CONFIG_SECURITY
 
@@ -46,16 +47,16 @@
  *  each is referenced only once in each function call.  Nothing
  *  depends on parameters having the same value every time.
  */
-static int any = 0;			/* if TRUE, any process is realtime */
-MODULE_PARM(any, "i");
+static int any;			/* if TRUE, any process is realtime */
+module_param(any, int, 0644);
 MODULE_PARM_DESC(any, " grant realtime privileges to any process.");
 
 static int gid = -1;			/* realtime group id, or NO_GROUP */
-MODULE_PARM(gid, "i");
+module_param(gid, int, 0644);
 MODULE_PARM_DESC(gid, " the group ID with access to realtime privileges.");
 
 static int mlock = 1;			/* enable mlock() privileges */
-MODULE_PARM(mlock, "i");
+module_param(mlock, int, 0644);
 MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
 
 /* helper function for testing group membership */
