Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbSI2XGr>; Sun, 29 Sep 2002 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSI2XGr>; Sun, 29 Sep 2002 19:06:47 -0400
Received: from adsl-64-164-168-233.dsl.lsan03.pacbell.net ([64.164.168.233]:5760
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S261858AbSI2XGq>; Sun, 29 Sep 2002 19:06:46 -0400
Date: Sun, 29 Sep 2002 16:12:06 -0700
From: Phil Oester <kernel@theoesters.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 - make MCE options arch dependent
Message-ID: <20020929161206.A14962@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to see P4 or Athlon options if you don't have one...

-Phil


--- linux-2.5.39-orig/arch/i386/config.in       Fri Sep 27 14:49:42 2002
+++ linux-2.5.39/arch/i386/config.in    Sun Sep 29 15:55:44 2002
@@ -187,8 +187,12 @@
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
-dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
-dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
+if [ "$CONFIG_MK7" = "y" ]; then
+   dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
+fi
+if [ "$CONFIG_MPENTIUM4" = "y" ]; then
+   dep_bool 'Check for P4 thermal throttling interrupt' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
+fi 

