Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268717AbTCCTA4>; Mon, 3 Mar 2003 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268718AbTCCTA4>; Mon, 3 Mar 2003 14:00:56 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:49538 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268717AbTCCTAw>; Mon, 3 Mar 2003 14:00:52 -0500
Date: Mon, 3 Mar 2003 20:11:16 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: re: 2.5-bk menuconfig format problem
Message-ID: <20030303191116.GG6946@louise.pinerecords.com>
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org> <20030303184906.GF6946@louise.pinerecords.com> <20030303185337.A30585@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303185337.A30585@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [hch@infradead.org]
> 
> Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
> on it's placements.  If people who actually do use if feel that it's placed
> wrongly feel free to submit a patch to fix it.


*** Approach A ***

diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2003-03-03 20:04:08.000000000 +0100
+++ b/arch/i386/Kconfig	2003-03-03 20:08:29.000000000 +0100
@@ -5,6 +5,9 @@
 
 mainmenu "Linux Kernel Configuration"
 
+
+menu "Architecture specific options"
+
 config X86
 	bool
 	default y
@@ -23,9 +26,9 @@
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unusre say Y.
+	  for the so-called swap devices or swap files.  There are used to
+	  provide more virtual memory than the actual RAM presents in your
+	  computer.  If unsure, say Y.
 
 config SBUS
 	bool
@@ -38,6 +41,9 @@
 	bool
 	default y
 
+endmenu
+
+
 source "init/Kconfig"
 
 
*** Approach B ***

diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2003-03-03 20:04:08.000000000 +0100
+++ b/arch/i386/Kconfig	2003-03-03 19:58:48.000000000 +0100
@@ -18,15 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool "Support for paging of anonymous memory"
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unusre say Y.
-
 config SBUS
 	bool
 
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2003-02-11 01:09:48.000000000 +0100
+++ b/init/Kconfig	2003-03-03 20:02:11.000000000 +0100
@@ -34,9 +34,18 @@
 
 endmenu
 
-
 menu "General setup"
 
+config SWAP
+	depends on X86
+	bool "Support for paging of anonymous memory"
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for the so-called swap devices or swap files.  There are used to
+	  provide more virtual memory than the actual RAM presents in your
+	  computer.  If unsure, say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---



You choose. ;)

-- 
Tomas Szepe <szepe@pinerecords.com>
