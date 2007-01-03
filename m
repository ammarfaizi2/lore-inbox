Return-Path: <linux-kernel-owner+w=401wt.eu-S1750720AbXACLfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbXACLfY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbXACLfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:35:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:37979 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXACLfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:35:03 -0500
Date: Wed, 3 Jan 2007 17:04:55 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/4] i386: Specify section flags while creating new sections
Message-ID: <20070103113455.GI17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o Older binutils (older than 2.6.15) require explicit flags to be set
  for section. (if a section has been defined using "section" directive).
  Otherwise a section which should have been allocatable and executable
  (AX) will not have properties as per intention.

o I had put a patch in -mm which will break the things if used with
  older binutils. Hence this is the fix on top of that patch.

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/broken-out/i386-move-startup_32-in-texthead-section.patch

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/head.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/head.S~i386-modify-section-directive-for-older-binutils arch/i386/kernel/head.S
--- linux-2.6.20-rc2-mm1-reloc/arch/i386/kernel/head.S~i386-modify-section-directive-for-older-binutils	2007-01-03 11:58:51.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/arch/i386/kernel/head.S	2007-01-03 12:00:03.000000000 +0530
@@ -53,7 +53,7 @@
  * any particular GDT layout, because we load our own as soon as we
  * can.
  */
-.section .text.head
+.section .text.head,"ax",@progbits
 ENTRY(startup_32)
 
 #ifdef CONFIG_PARAVIRT
@@ -155,9 +155,9 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
  */
 
 #ifdef CONFIG_HOTPLUG_CPU
-.section .text
+.section .text,"ax",@progbits
 #else
-.section .init.text
+.section .init.text,"ax",@progbits
 #endif
 
 #ifdef CONFIG_SMP
_
