Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTEKBH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 21:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTEKBH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 21:07:28 -0400
Received: from smtp5.wanadoo.es ([62.37.236.237]:59838 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S261787AbTEKBHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 21:07:25 -0400
Message-ID: <3EBDA545.4010603@wanadoo.es>
Date: Sun, 11 May 2003 03:20:05 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       marcelo <marcelo@conectiva.com.br>
Subject: [PATCH] kbuild and CONFIG_PROC_FS bug
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi guys,

There is a general error in some files, this was discussed  time
ago: http://marc.theaimsgroup.com/?l=linux-kernel&m=104948738901849&w=2
Roman Zippel had a better solution than mine. And here it goes a
patch for 2.4.21-rc2:

--cut--
diff -Nuar linux/arch/alpha/config.in linux.xose/arch/alpha/config.in
--- linux/arch/alpha/config.in  2003-05-11 02:53:23.000000000 +0200
+++ linux.xose/arch/alpha/config.in     2003-05-11 02:59:04.000000000 +0200
@@ -287,7 +287,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
diff -Nuar linux/arch/i386/config.in linux.xose/arch/i386/config.in
--- linux/arch/i386/config.in   2003-05-11 02:53:24.000000000 +0200
+++ linux.xose/arch/i386/config.in      2003-05-11 02:57:56.000000000 +0200
@@ -315,7 +315,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
diff -Nuar linux/arch/m68k/config.in linux.xose/arch/m68k/config.in
--- linux/arch/m68k/config.in   2003-05-11 02:53:25.000000000 +0200
+++ linux.xose/arch/m68k/config.in      2003-05-11 03:00:15.000000000 +0200
@@ -92,7 +92,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
diff -Nuar linux/arch/ppc/config.in linux.xose/arch/ppc/config.in
--- linux/arch/ppc/config.in    2003-05-11 02:53:26.000000000 +0200
+++ linux.xose/arch/ppc/config.in       2003-05-11 03:00:02.000000000 +0200
@@ -177,7 +177,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT

 # only elf supported, a.out is not -- Cort
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
   define_bool CONFIG_KCORE_ELF y
 fi
 define_bool CONFIG_BINFMT_ELF y
diff -Nuar linux/arch/ppc64/config.in linux.xose/arch/ppc64/config.in
--- linux/arch/ppc64/config.in  2003-05-11 02:53:28.000000000 +0200
+++ linux.xose/arch/ppc64/config.in     2003-05-11 03:01:00.000000000 +0200
@@ -69,7 +69,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT

 # only elf supported, a.out is not -- Cort
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi

diff -Nuar linux/arch/sh/config.in linux.xose/arch/sh/config.in
--- linux/arch/sh/config.in     2003-05-11 02:53:28.000000000 +0200
+++ linux.xose/arch/sh/config.in        2003-05-11 03:00:43.000000000 +0200
@@ -205,7 +205,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
diff -Nuar linux/arch/sparc/config.in linux.xose/arch/sparc/config.in
--- linux/arch/sparc/config.in  2003-05-11 02:53:28.000000000 +0200
+++ linux.xose/arch/sparc/config.in     2003-05-11 02:59:42.000000000 +0200
@@ -65,7 +65,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
diff -Nuar linux/arch/sparc64/config.in linux.xose/arch/sparc64/config.in
--- linux/arch/sparc64/config.in        2003-01-16 04:26:24.000000000 +0100
+++ linux.xose/arch/sparc64/config.in   2003-05-11 03:00:30.000000000 +0200
@@ -64,7 +64,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi
 bool 'Kernel support for Linux/Sparc 32bit binary compatibility' CONFIG_SPARC32_COMPAT
diff -Nuar linux/arch/x86_64/config.in linux.xose/arch/x86_64/config.in
--- linux/arch/x86_64/config.in 2003-05-11 02:53:29.000000000 +0200
+++ linux.xose/arch/x86_64/config.in    2003-05-11 03:01:15.000000000 +0200
@@ -101,7 +101,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi
 #tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
diff -Nuar linux/drivers/char/ftape/Config.in linux.xose/drivers/char/ftape/Config.in
--- linux/drivers/char/ftape/Config.in  2003-01-16 04:26:28.000000000 +0100
+++ linux.xose/drivers/char/ftape/Config.in     2003-05-11 02:57:14.000000000 +0200
@@ -10,7 +10,7 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    int '  Number of ftape buffers (EXPERIMENTAL)' CONFIG_FT_NR_BUFFERS 3
 fi
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
 fi
 choice 'Debugging output'                      \
diff -Nuar linux/drivers/media/radio/Config.in linux.xose/drivers/media/radio/Config.in
--- linux/drivers/media/radio/Config.in 2003-05-11 02:53:34.000000000 +0200
+++ linux.xose/drivers/media/radio/Config.in    2003-05-11 02:57:39.000000000 +0200
@@ -40,7 +40,7 @@
       hex '    Trust i/o port (usually 0x350 or 0x358)' CONFIG_RADIO_TRUST_PORT 350
    fi
    dep_tristate '  Typhoon Radio (a.k.a. EcoRadio)' CONFIG_RADIO_TYPHOON $CONFIG_VIDEO_DEV
-   if [ "$CONFIG_PROC_FS" = "y" ]; then
+   if [ "$CONFIG_PROC_FS" != "n" ]; then
       if [ "$CONFIG_RADIO_TYPHOON" != "n" ]; then
          bool '    Support for /proc/radio-typhoon' CONFIG_RADIO_TYPHOON_PROC_FS
       fi
--end--

-thanks-

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

