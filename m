Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTDWNkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTDWNkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:40:55 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:24797 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264038AbTDWNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:40:52 -0400
Date: Wed, 23 Apr 2003 15:51:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Fix SWSUSP & !SWAP
Message-ID: <20030423135100.GA320@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Swsusp without swap makes no sense, but leads to compilation
failure. This fixes it. Please apply,
							Pavel

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig	2003-04-22 00:04:32.000000000 +0200
+++ linux/arch/i386/Kconfig	2003-04-22 00:02:32.000000000 +0200
@@ -798,7 +798,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
+	depends on EXPERIMENTAL && PM && SWAP
 	---help---
 	  Enable the possibilty of suspendig machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig	2003-04-22 00:04:32.000000000 +0200
+++ linux/arch/x86_64/Kconfig	2003-04-22 00:02:37.000000000 +0200
@@ -286,7 +286,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
+	depends on EXPERIMENTAL && PM && SWAP
 	---help---
 	  Enable the possibilty of suspending the machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
