Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317652AbSGJWoz>; Wed, 10 Jul 2002 18:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317653AbSGJWoy>; Wed, 10 Jul 2002 18:44:54 -0400
Received: from pD952AE71.dip.t-dialin.net ([217.82.174.113]:30595 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317652AbSGJWox>; Wed, 10 Jul 2002 18:44:53 -0400
Date: Wed, 10 Jul 2002 16:47:33 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <Pine.LNX.4.44.0207101640340.5067-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207101646301.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jul 2002, Thunder from the hill wrote:
> I guess I forgot the half of it...

I did. Here is the whole version:

Index: arch/i386/Config.help
===================================================================
RCS file: /var/cvs/thunder-2.5/arch/i386/Config.help,v
retrieving revision 1.4
diff -p -u -r1.4 Config.help
--- arch/i386/Config.help	7 Jul 2002 09:59:46 -0000	1.4
+++ arch/i386/Config.help	10 Jul 2002 22:40:17 -0000
@@ -991,3 +991,13 @@ CONFIG_X86_EARLY_PRINTK
   to the console  much earlier in the boot  process than printk.  This
   is useful when  debugging fatal problems early in  the boot sequence
   (e.g. within setup_arch).  If unsure, say N.
+
+Low kernel scheduler rate
+CONFIG_SCHED_LOW_HZ
+  Enable this  if you care about  your CPU sleeping  time. The current
+  interval for  scheduling processes in  the kernel has  recently been
+  increased. The advantage is less latency for many things that depend
+  on the  timer, the disadvantage is  that your cpu  will probably not
+  go to sleep in time (so  CPU power management will possibly not work
+  at all)
+
Index: include/asm-i386/param.h
===================================================================
RCS file: /var/cvs/thunder-2.5/include/asm-i386/param.h,v
retrieving revision 1.2
diff -p -u -r1.2 param.h
--- include/asm-i386/param.h	6 Jul 2002 18:17:30 -0000	1.2
+++ include/asm-i386/param.h	10 Jul 2002 22:40:17 -0000
@@ -2,7 +2,11 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# ifdef CONFIG_SCHED_LOW_HZ
+#  define HZ		100		/* Internal kernel timer frequency */
+# else
+#  define HZ		1000		/* Internal kernel timer frequency */
+# endif
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
Index: arch/i386/config.in
===================================================================
RCS file: /var/cvs/thunder-2.5/arch/i386/config.in,v
retrieving revision 1.8
diff -p -u -r1.8 config.in
--- arch/i386/config.in	7 Jul 2002 09:59:47 -0000	1.8
+++ arch/i386/config.in	10 Jul 2002 22:45:28 -0000
@@ -181,6 +181,7 @@ else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
+bool 'Low scheduler rates' CONFIG_SCHED_LOW_HZ
 bool 'Machine Check Exception' CONFIG_X86_MCE
 dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
 dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

