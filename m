Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262533AbTCIQWU>; Sun, 9 Mar 2003 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262534AbTCIQWU>; Sun, 9 Mar 2003 11:22:20 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:33238 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262533AbTCIQWT>; Sun, 9 Mar 2003 11:22:19 -0500
Date: Sun, 9 Mar 2003 17:32:42 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Work around console initialization ordering problem
Message-ID: <20030309163242.GA2335@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Works around the console ordering problem in 2.5.64-bk3. Following 
the similar fix I did for x86-64.

-Andi

--- linux-2.5.64-work/arch/i386/kernel/setup.c-o	2003-03-05 10:40:08.000000000 +0100
+++ linux-2.5.64-work/arch/i386/kernel/setup.c	2003-03-09 17:27:57.000000000 +0100
@@ -516,6 +516,9 @@
 	int len = 0;
 	int userdef = 0;
 
+	if (!strstr(saved_command_line, "console="))
+	     strcat(saved_command_line, " console=tty0");
+
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
