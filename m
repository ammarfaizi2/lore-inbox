Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269750AbUJHIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbUJHIIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJHIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:08:22 -0400
Received: from mail9.messagelabs.com ([194.205.110.133]:23774 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S269745AbUJHIHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:07:16 -0400
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-12.tower-9.messagelabs.com!1097222834!12612264
X-StarScan-Version: 5.2.10; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: [PATCH] trivial fix for warning in kernel/power/console.c
From: Ian Campbell <icampbell@arcom.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20041007160858.0708e968.akpm@osdl.org>
References: <1097157857.5231.10.camel@icampbell-debian>
	 <20041007160858.0708e968.akpm@osdl.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1097222833.5231.67.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 09:07:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not only that, orig_kmsg is assigned to but never read from.

I decided to restore it rather that dump it, so how about:

Fix warnings in kernel/power/console.c by only declaring orig_fgconsole
and orig_kmsg when required by SUSPEND_CONSOLE. Restore kmsg_redirect on
resume.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6-bk/kernel/power/console.c
===================================================================
--- 2.6-bk.orig/kernel/power/console.c	2004-10-07 14:47:25.000000000 +0100
+++ 2.6-bk/kernel/power/console.c	2004-10-08 08:56:28.750936142 +0100
@@ -11,7 +11,9 @@
 
 static int new_loglevel = 10;
 static int orig_loglevel;
+#ifdef SUSPEND_CONSOLE
 static int orig_fgconsole, orig_kmsg;
+#endif
 
 int pm_prepare_console(void)
 {
@@ -50,6 +52,7 @@
 	acquire_console_sem();
 	set_console(orig_fgconsole);
 	release_console_sem();
+	kmsg_redirect = orig_kmsg;
 #endif
 	return;
 }

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
