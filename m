Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTLPNlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTLPNlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:41:55 -0500
Received: from ftp.ckdenergo.cz ([80.95.97.155]:28615 "EHLO simek")
	by vger.kernel.org with ESMTP id S261754AbTLPNlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:41:53 -0500
Date: Tue, 16 Dec 2003 14:41:31 +0100
To: linux-kernel@vger.kernel.org
Subject: undefined reference to `console_list'
Message-ID: <20031216134131.GA1657@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch-2.1.71 brought posibility to pass list of consoles on kernel
command line.
http://www.funet.fi/pub/Linux/PEOPLE/Linus/v2.1/patch-html/patch-2.1.71/linux_kernel_printk.c.html
http://www.funet.fi/pub/Linux/PEOPLE/Linus/v2.1/patch-html/patch-2.1.71/linux_include_linux_console.h.html

while kernel/printk.c defines
struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
include/linux/console.h reads
extern struct console_cmdline console_list[MAX_CMDLINECONSOLES];

nothing needs fix below at the moment, but to finish MIPS merge it is
needed either export console_setup(char *) or use fix below and this patch
ftp://ftp.linux-mips.org/pub/linux/mips/people/ladis/ip22-setup.diff
but header should be fixed anyway.

--- linux-mips-2.4/include/linux/console.h.orig	2003-12-16 13:52:59.000000000 +0100
+++ linux-mips-2.4/include/linux/console.h	2003-12-16 13:53:10.000000000 +0100
@@ -80,7 +80,7 @@
 	char	*options;			/* Options for the driver   */
 };
 #define MAX_CMDLINECONSOLES 8
-extern struct console_cmdline console_list[MAX_CMDLINECONSOLES];
+extern struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 /*
  *	The interface for a console, or any other device that

regards,
	ladis

ps: please cc me, I'm not on the list
