Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTLCIBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 03:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTLCIBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 03:01:39 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:58216 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264508AbTLCIBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:01:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 4/3] Input: correctly activate i0842 ports on resume
Date: Wed, 3 Dec 2003 03:01:31 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Brian Perkins <bperkins@netspace.org>
References: <200312010215.58533.dtor_core@ameritech.net> <200312010217.16553.dtor_core@ameritech.net> <200312010217.54552.dtor_core@ameritech.net>
In-Reply-To: <200312010217.54552.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312030301.33600.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1517, 2003-12-03 02:52:23-05:00, dtor_core@ameritech.net
  Input: fix i8042_activate_port() - the port is still disabled on
         resume, need explicitely enable it (found by Brian Perkins)


 i8042.c |    6 ++++++
 1 files changed, 6 insertions(+)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Wed Dec  3 02:55:54 2003
+++ b/drivers/input/serio/i8042.c	Wed Dec  3 02:55:54 2003
@@ -226,6 +226,12 @@
 
 	i8042_flush();
 
+	/* 
+	 * Enable port again here because it is disabled if we are
+	 * resuming (normally it is enabled already).
+	 */
+	i8042_ctr &= ~values->disable;
+
 	i8042_ctr |= values->irqen;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
