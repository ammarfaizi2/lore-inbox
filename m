Return-Path: <linux-kernel-owner+w=401wt.eu-S1754144AbXACEQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbXACEQ7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbXACEQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:16:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:37307 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbXACEQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:16:58 -0500
Date: Wed, 3 Jan 2007 09:46:45 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Jean Delvare <khali@linux-fr.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] i386 kernel instant reboot with older binutils fix
Message-ID: <20070103041645.GA17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o i386 kernel reboots instantly if compiled with binutils older than
  2.6.15.

o Older binutils required explicit flags to mark a section allocatable
  and executable(AX). Newer binutils automatically mark a section AX if
  the name starts with .text.

o While defining a new section using assembler "section" directive,
  explicitly mention section flags. 

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/boot/compressed/head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/boot/compressed/head.S~jean-reboot-issue-fix arch/i386/boot/compressed/head.S
--- linux-2.6.20-rc2-reloc/arch/i386/boot/compressed/head.S~jean-reboot-issue-fix	2007-01-02 09:54:56.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/boot/compressed/head.S	2007-01-02 09:57:46.000000000 +0530
@@ -28,7 +28,7 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 
-.section ".text.head"
+.section ".text.head","ax",@progbits
 	.globl startup_32
 
 startup_32:
_
