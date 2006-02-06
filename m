Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWBFOXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWBFOXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWBFOXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:23:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:5005 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932089AbWBFOXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:23:17 -0500
Date: Mon, 6 Feb 2006 15:23:12 +0100
From: Olaf Hering <olh@suse.de>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Message-ID: <20060206142312.GA31509@suse.de>
References: <200602032312.k13NCDAc012658@hera.kernel.org> <20060205125610.GA26337@suse.de> <20060205190220.GB19458@redhat.com> <20060206072845.GA21300@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060206072845.GA21300@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 06, Olaf Hering wrote:

>  On Sun, Feb 05, Dave Jones wrote:
> 
> > On Sun, Feb 05, 2006 at 01:56:10PM +0100, Olaf Hering wrote:
> >  >  On Fri, Feb 03, Linux Kernel Mailing List wrote:
> >  > 
> >  > > tree 8f70444139c8564c0f1e88e1f33adda036ae6a96
> >  > > parent 278ff9537030bbb292b33504f5e1f6e0126793eb
> >  > > author Dave Jones <davej@redhat.com> Fri, 03 Feb 2006 19:03:44 -0800
> >  > > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 04 Feb 2006 00:32:00 -0800
> >  > > 
> >  > > [PATCH] Fix build failure in recent pm_prepare_* changes.
> >  > > 
> >  > > kernel/power/power.h:49: error: static declaration of 'pm_prepare_console' follows non-static declaration
> >  > > include/linux/suspend.h:46: error: previous declaration of 'pm_prepare_console' was here
> >  > > kernel/power/power.h:50: error: static declaration of 'pm_restore_console' follows non-static declaration
> >  > > include/linux/suspend.h:47: error: previous declaration of 'pm_restore_console' was here
> >  > > 
> >  > > Signed-off-by: Dave Jones <davej@redhat.com>
> >  > 
> >  > this one is not correct, please have a closer look at
> >  > f7b8988ff50d99c99746f65f420364e91362c065
> >  > 
> >  >   CC      drivers/macintosh/via-pmu.o
> >  > drivers/macintosh/via-pmu.c: In function 'pmac_suspend_devices':
> >  > drivers/macintosh/via-pmu.c:2078: error: implicit declaration of function 'pm_prepare_console'
> >  > drivers/macintosh/via-pmu.c: In function 'pmac_wakeup_devices':
> >  > drivers/macintosh/via-pmu.c:2194: error: implicit declaration of function 'pm_restore_console'
> >  > make[2]: *** [drivers/macintosh/via-pmu.o] Error 1


via-pmu needs to call console functions directly from the pmu_ioctl.

 drivers/macintosh/via-pmu.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.16-rc2-olh/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.16-rc2-olh/drivers/macintosh/via-pmu.c
@@ -2070,6 +2070,10 @@ restore_via_state(void)
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
+/* to avoid include mess */
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+
 static int
 pmac_suspend_devices(void)
 {

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
