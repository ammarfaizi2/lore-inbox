Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbTIMP02 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 11:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbTIMP02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 11:26:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12814 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261200AbTIMP00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 11:26:26 -0400
Date: Sat, 13 Sep 2003 17:26:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KConfig help text not shown in 2.6.0-test5
In-Reply-To: <3F63197D.2000306@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0309131720270.8124-100000@serv>
References: <3F63197D.2000306@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 Sep 2003, Nick Piggin wrote:

> In 2.6.0-test5, the help text for choice options (eg. processor type,
> highmem) is not shown in either menuconfig or oldconfig. It does work
> in gconfig, however. Don't know when it last worked.

Try the patch below, the main help should be with the choice. This patch 
is only an example, someone else should verify the correct wording.
BTW you can reach the individual help within 'make config' by appending a 
'?' to the number (e.g. '1?').

bye, Roman

--- l/arch/i386/Kconfig	8 Sep 2003 21:15:30 -0000	1.1.1.4
+++ l/arch/i386/Kconfig	13 Sep 2003 00:05:51 -0000
@@ -128,9 +128,6 @@ config ES7000_CLUSTERED_APIC
 choice
 	prompt "Processor family"
 	default M686
-
-config M386
-	bool "386"
 	---help---
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
@@ -166,6 +163,12 @@ config M386
 
 	  If you don't know what to do, choose "386".
 
+config M386
+	bool "386"
+	help
+	  Select this for a 386 series processor, either Intel or one of the
+	  compatible processors.
+
 config M486
 	bool "486"
 	help
@@ -643,9 +646,6 @@ config EDD
 choice
 	prompt "High Memory Support"
 	default NOHIGHMEM
-
-config NOHIGHMEM
-	bool "off"
 	---help---
 	  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
 	  However, the address space of 32-bit x86 processors is only 4
@@ -678,7 +678,13 @@ config NOHIGHMEM
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
-	  If unsure, say "off".
+	  If unsure, select "off".
+
+
+config NOHIGHMEM
+	bool "off"
+	help
+	  Select this if you want turn off High Memory Support.
 
 config HIGHMEM4G
 	bool "4GB"

