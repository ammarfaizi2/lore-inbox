Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTFBVD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTFBVD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:03:58 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:64499 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263953AbTFBVD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:03:56 -0400
Date: Mon, 2 Jun 2003 14:13:16 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] SECURITY_ROOTPLUG must depend on USB
Message-ID: <20030602141316.A15203@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20030601184436.GD29425@fs.tum.de> <20030602172016.GB4992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602172016.GB4992@kroah.com>; from greg@kroah.com on Mon, Jun 02, 2003 at 10:20:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Sun, Jun 01, 2003 at 08:44:36PM +0200, Adrian Bunk wrote:
> > The following patch lets SECURITY_ROOTPLUG depend on USB (otherwise
> > there are link errors since Root Plug Support needs
> > usb_bus_list{,_lock}):
> 
> Applied, thanks.

While we're at it, here's a tiny cleanup for a compile warning from John
Cherry's build stats[1].  You may have a cleaner way you'd rather handle
this.

  CC [M]  security/root_plug.o
security/root_plug.c:57:1: warning: "dbg" redefined
In file included from security/root_plug.c:30:
include/linux/usb.h:979:1: warning: this is the location of the previous definition

thanks,
-chris

[1] http://www.osdl.org/archive/cherry/stability/linux-2.5.69.results/2.5.69.allmodconfig.modules.txt
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== security/root_plug.c 1.2 vs edited =====
--- 1.2/security/root_plug.c	Wed Dec 18 15:09:26 2002
+++ edited/security/root_plug.c	Mon Jun  2 11:42:21 2003
@@ -54,6 +54,9 @@
 #define MY_NAME "root_plug"
 #endif
 
+#ifdef dbg
+#undef dbg
+#endif
 #define dbg(fmt, arg...)					\
 	do {							\
 		if (debug)					\
