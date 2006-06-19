Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWFSWJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWFSWJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWFSWJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:09:23 -0400
Received: from mailfe10.tele2.fr ([212.247.155.44]:39583 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964946AbWFSWJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:09:23 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Tue, 20 Jun 2006 00:09:20 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619220920.GB5788@implementation.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
> You can't allow some terminal input to affect init. It has been the
> de facto standard in Unix, that the only time one should have a
> controlling terminal is after somebody logs in and owns something to
> control.

Ok. The following still makes sense, doesn't it? (i.e. set a session for
the emergency shell)

--- linux-2.6.17-orig/init/main.c	2006-06-18 19:22:40.000000000 +0200
+++ linux-2.6.17-perso/init/main.c	2006-06-20 00:07:07.000000000 +0200
@@ -729,6 +729,11 @@
 	run_init_process("/sbin/init");
 	run_init_process("/etc/init");
 	run_init_process("/bin/init");
+
+	/* Set a session for the shell.  */
+	sys_setsid();
+	sys_ioctl(0, TIOCSCTTY, 1);
+
 	run_init_process("/bin/sh");
 
 	panic("No init found.  Try passing init= option to kernel.");
