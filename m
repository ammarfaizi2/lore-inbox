Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSHSGd3>; Mon, 19 Aug 2002 02:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHSGd3>; Mon, 19 Aug 2002 02:33:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58539 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318190AbSHSGd2>; Mon, 19 Aug 2002 02:33:28 -0400
Date: Mon, 19 Aug 2002 02:37:31 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org
Subject: Little console problem in 2.5.30
Message-ID: <20020819023731.C316@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all:

I would appreciate if someone would explain me if the attached patch
does the right thing. The problem is that I do not use the framebuffer,
and use a serial console. Whenever a legacy /sbin/init tries to
open /dev/tty0, the system oopses dereferencing conswitchp in
visual_init().

-- Pete

diff -ur -X dontdiff linux-2.5.30-sp_pbk/drivers/char/console.c linux-2.5.30-sparc/drivers/char/console.c
--- linux-2.5.30-sp_pbk/drivers/char/console.c	Thu Aug  1 14:16:34 2002
+++ linux-2.5.30-sparc/drivers/char/console.c	Sun Aug 18 23:14:20 2002
@@ -652,7 +652,7 @@
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
-	if (currcons >= MAX_NR_CONSOLES)
+	if (currcons >= MAX_NR_CONSOLES || conswitchp == NULL)
 		return -ENXIO;
 	if (!vc_cons[currcons].d) {
 	    long p, q;
