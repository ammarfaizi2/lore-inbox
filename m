Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUKGV4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUKGV4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKGV4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:56:17 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:21967 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261696AbUKGVyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:54:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 32-bit segfaults on x86_64 in recent mm kernels
Date: Sun, 7 Nov 2004 22:53:34 +0100
User-Agent: KMail/1.6.2
Cc: Andy Lutomirski <luto@myrealbox.com>
References: <418E8759.9070408@myrealbox.com>
In-Reply-To: <418E8759.9070408@myrealbox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411072253.34806.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 of November 2004 21:36, Andy Lutomirski wrote:
> I've had segfaults in 32-bit emulation in recent (and not-so-recent) -mm
> kernels on x86_64.
> 
> 2.6.7-gentoo-r11 and 2.6.10-rc1 both work fine (even wine works for the 
> most part).
> 
> 2.6.9-rc3-mm3 can't run wine -- it always segfaults.  Other apps seem OK.
[-- snip --]

This is because of the flex mmap patch for x86-64.  You can try the following 
workaround from Andi Kleen:

diff -u linux-2.6.10rc1-mm3/kernel/sysctl.c-o 
linux-2.6.10rc1-mm3/kernel/sysctl.c
--- linux-2.6.10rc1-mm3/kernel/sysctl.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/kernel/sysctl.c	2004-11-06 13:50:22.000000000 +0100
@@ -147,7 +147,7 @@
 #endif
 
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
-int sysctl_legacy_va_layout;
+int sysctl_legacy_va_layout = 1;
 #endif
 
 /* /proc declarations: */

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
