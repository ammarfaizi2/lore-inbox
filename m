Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbTIQSJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbTIQSJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:09:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13530 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262606AbTIQSJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:09:16 -0400
Subject: [PATCH] linux-2.6.0-test5_hangcheck-compile-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: storri@sbcglobal.net, Andrew Morton <akpm@osdl.org>,
       Joel Becker <Joel.Becker@oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063822023.26723.134.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Sep 2003 11:07:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Since monotonic_clock() is not defined on every arch yet, this patch
insures the hangcheck-timer module (currently the only user of
monotonic-clock) is not built where it will not compile.

I know, I know. Ideally monotonic_clock() would be implemented on all
arches, but I've just not had the time.  If any of the non x86/x86-64
folks feel bored, drop me a line.  It'd be a fairly easy project.

thanks
-john


diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Wed Sep 17 10:52:55 2003
+++ b/drivers/char/Kconfig	Wed Sep 17 10:52:55 2003
@@ -1001,6 +1001,7 @@
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
+	depends on X86_64 || X86
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system



