Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVDQWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDQWgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVDQWgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 18:36:46 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:20164 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261532AbVDQWgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 18:36:43 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, ebiederm@xmission.com
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 18 Apr 2005 00:36:41 +0200
Message-Id: <1113777401.348.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mån 2005-04-11 klockan 01:25 -0700 skrev Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 

I tried to kexec on my x64 and it hangs up in calibrate_delay() because
the PIT never fires any interrupts so jiffies is never updated. Has
kexec been tested on x64 and should be working? I want to know if I
should start looking at weirdness with my hardware or if it is like this
on all x64 boxes.

Also, patch at bottom is needed to compile kexec on x64 without ia32
emulation support (the includes are not used at the moment).

  CC      arch/x86_64/kernel/crash.o
In file included from arch/x86_64/kernel/crash.c:18:
include/linux/elfcore.h: I funktion `elf_core_copy_regs':
include/linux/elfcore.h:92: error: dereferencing pointer to incomplete type
include/linux/elfcore.h:92: error: dereferencing pointer to incomplete type


Index: x64_mm/arch/x86_64/kernel/crash.c
===================================================================
--- x64_mm.orig/arch/x86_64/kernel/crash.c	2005-04-16 19:23:58.000000000 +0200
+++ x64_mm/arch/x86_64/kernel/crash.c	2005-04-16 19:47:56.000000000 +0200
@@ -14,8 +14,6 @@
 #include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/kexec.h>
-#include <linux/elf.h>
-#include <linux/elfcore.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>


